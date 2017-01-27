package com.softindustry.model.dao;

import com.softindustry.model.entity.User;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by konstr6 on 27.01.2017.
 */
public class MySQLNotebookDAO extends AbstractNotebookDAO {

    private static final String PROPERTY_FILE_PATH = "mysql.properties";

    private static final String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS `notebook`.`users` (" +
            "  `id` INT NOT NULL AUTO_INCREMENT," +
            "  `surname` VARCHAR(45) NULL," +
            "  `name` VARCHAR(45) NULL," +
            "  `age` INT NULL," +
            "  `sex` VARCHAR(1) NULL," +
            "  `phone_number` VARCHAR(20) NULL," +
            "  PRIMARY KEY (`id`));";


    private static final String ADD_USER_QUERY = "INSERT INTO notebook.users (" +
            "surname, name, age, sex, phone_number) VALUES (?, ?, ?, ?, ?);";
    private static final String GET_USER_QUERY = "SELECT surname, name, age, sex, phone_number" +
            " FROM notebook.users WHERE id=?;";
    private static final String UPDATE_USER_QUERY = "UPDATE notebook.users" +
            " SET surname=?, name=?, age=?, sex=?, phone_number=? WHERE id=?;";
    private static final String DELETE_USER_QUERY = "DELETE FROM notebook.users WHERE id=?;";




    private static BasicDataSource dataSource; //TODO why apache? remake to plain JDBC

    @Override
    protected void initDataSource() {
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

    @Override
    protected Connection getConnection() throws SQLException {
        Connection conn = dataSource.getConnection();
        conn.setAutoCommit(false);
        return conn;
    }

    @Override
    public void addUser(User user) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(ADD_USER_QUERY)) {
                st.setString(1, user.getSurname());
                st.setString(2, user.getName());
                st.setInt(3,user.getAge());
                st.setString(4,String.valueOf(user.getSex()));
                st.setString(5,user.getPhoneNumber());
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail in adding user ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }

    @Override
    public User getUserById(int id) {
        User user = new User();
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(GET_USER_QUERY)) {
                st.setInt(1,id);
                ResultSet rs = st.executeQuery();
                while(rs.next()){
                    user.setId(id);
                    user.setSurname(rs.getString("surname"));
                    user.setName(rs.getString("name"));
                    user.setAge(rs.getInt("age"));
                    user.setSex(rs.getString("sex").charAt(0));
                }
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to retrieve user ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
        return user;
    }

    @Override
    public void updateUser(User user) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(UPDATE_USER_QUERY)) {
                st.setString(1, user.getSurname());
                st.setString(2, user.getName());
                st.setInt(3,user.getAge());
                st.setString(4,String.valueOf(user.getSex()));
                st.setString(5,user.getPhoneNumber());
                st.setInt(6,user.getId());
                st.executeUpdate();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to update user information ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }

    @Override
    public void deleteUser(User user) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(DELETE_USER_QUERY)) {
                st.setInt(1,user.getId());
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to delete user ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }
}
