package com.softindustry.main;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.Configuration;
import org.eclipse.jetty.webapp.WebAppContext;

import java.io.File;
import java.nio.file.Path;


/**
 * Created by skyrvr on 05.02.17.
 */
public class Main {
    public static void main(String[] args) throws Exception {

        Server server = new Server(8080);

        Path warPath = new File("target/web-app.war").toPath().toRealPath();

        Configuration.ClassList classlist = Configuration.ClassList
                .setServerDefault( server );
        classlist.addBefore(
                "org.eclipse.jetty.webapp.JettyWebXmlConfiguration",
                "org.eclipse.jetty.annotations.AnnotationConfiguration" );

        WebAppContext webapp = new WebAppContext();
        webapp.setContextPath("/");
        webapp.setWar(warPath.toUri().toASCIIString());
        webapp.setParentLoaderPriority(true);

        server.setHandler(webapp);
        server.start();
        server.join();
    }
}
