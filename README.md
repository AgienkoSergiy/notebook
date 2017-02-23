#Notebook
###Notebook is an application which can be used to persist person's contact information via embedded DB, edit it and perform contextual search by any field.
======================================

##Requirements
Apache Maven and JRE (at least 1.7) need to be installed on your PC to run this project.


##Install
This is a maven project. To build it, run from project directory:

    $ mvn clean package
Also you can use bat script (Windows only): just execute run.bat file, this action installs and runs application automatically.

##Usage
To run project `com.softindustry.main.Main`via embedded Jetty:

    $ mvn exec:exec

Open your web browser to:

    http://localhost:8080/  

To stop Jetty:

  use <kbd>CTRL</kbd>+<kbd>C</kbd>
  
##Technologies used
Development of the application involved usage of JSP, Servlet API, Jetty(embedded), JDBC, H2 DB.
