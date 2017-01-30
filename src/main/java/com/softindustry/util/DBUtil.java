package com.softindustry.util;

import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by skyrvr on 27.01.17.
 */
public class DBUtil { //TODO add abstraction

    private static final String PROPERTY_FILE_PATH = "mysql.properties";

    private static BasicDataSource dataSource; //TODO why apache? remake to plain JDBC?

    public DBUtil() {
        initDataSource();
    }

    private void initDataSource() {
        if (dataSource != null) {
            return;
        }
        try (InputStream inputStream =
                     getClass().getClassLoader().getResourceAsStream(PROPERTY_FILE_PATH)) {
            Properties properties = new Properties();
            properties.load(inputStream);
            dataSource = new BasicDataSource();
            dataSource.setDriverClassName(properties.getProperty("db.driver"));
            dataSource.setUrl(properties.getProperty("db.url"));
            dataSource.setUsername(properties.getProperty("db.username"));
            dataSource.setPassword(properties.getProperty("db.password"));
        } catch (IOException e) {
            throw new RuntimeException("Property file reading error ", e);
        }
    }


    public static Connection getConnection() throws SQLException {
        Connection conn = dataSource.getConnection();
        conn.setAutoCommit(false);
        return conn;
    }
}
