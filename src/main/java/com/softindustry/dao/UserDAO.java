package com.softindustry.dao;

import com.softindustry.model.User;
import com.softindustry.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.softindustry.util.DBUtil.getConnection;


public class UserDAO {

    //tomcat debug section


    private static final String TEMP_START_QUERY_3 = "CREATE SCHEMA IF NOT EXISTS `notebook`;";

    private static final String TEMP_START_QUERY_1 = "CREATE TABLE IF NOT EXISTS `notebook`.`users` (" +
            "  `id` INT NOT NULL AUTO_INCREMENT," +
            "  `surname` VARCHAR(45) NULL," +
            "  `name` VARCHAR(45) NULL," +
            "  `age` INT NULL," +
            "  `gender` VARCHAR(1) NULL," +
            "  `phone_number` VARCHAR(20) NULL," +
            "  PRIMARY KEY (`id`));";

    private static final String TEMP_START_QUERY_2 = "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('King', 'Stephen', '69', 'm', '+380934440591');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Lovecraft', 'Howard', '46', 'm', '+380734320141');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Hemingway', 'Ernest', '61', 'm', '+380735230593');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Einstein', 'Albert', '76', 'm', '+380933691593');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Tesla', 'Nikola', '86', 'm', '+380731550712');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Orlova', 'Alina', '32', 'f', '+380639511425');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Winehouse', 'Amy', '27', 'f', '+380665550744');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Yorke', 'Thomas', '48', 'm', '+380664547891');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Mercury', 'Freddie', '45', 'm', '+380736570793');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Palmer', 'Amanda', '32', 'f', '+380952214190');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Adkins', 'Adele', '25', 'f', '+380934177559');";


    //end tomcat debug section

    private static final String ADD_USER_QUERY = "INSERT INTO notebook.users (" +
            "surname, name, age, gender, phone_number) VALUES (?, ?, ?, ?, ?);";
    private static final String GET_USER_QUERY = "SELECT surname, name, age, gender, phone_number" +
            " FROM notebook.users WHERE id=?;";
    private static final String UPDATE_USER_QUERY = "UPDATE notebook.users" +
            " SET surname=?, name=?, age=?, gender=?, phone_number=? WHERE id=?;";
    private static final String DELETE_USER_QUERY = "DELETE FROM notebook.users WHERE id=?;";
    private static final String GET_ALL_QUERY = "SELECT * FROM notebook.users;";
    private static final String GET_USERS_BY_FILTER_QUERY = "SELECT DISTINCT * FROM notebook.users WHERE" +
            " surname LIKE ? OR name LIKE ? OR phone_number LIKE ?;";
    private static final String GET_USER_ID_BY_PHONE = "SELECT id FROM notebook.users WHERE phone_number = ?;";

    private static UserDAO instance = null;

    private UserDAO() {
        DBUtil.getInstance();
        init();
    }

    //tomcat debug section

    private void init(){
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(TEMP_START_QUERY_3)) {
                st.executeUpdate();

            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to create schema ", e);
            }
            try (PreparedStatement st = conn.prepareStatement(TEMP_START_QUERY_1)) {
                st.executeUpdate();

            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to create table ", e);
            }
            try (PreparedStatement st = conn.prepareStatement(TEMP_START_QUERY_2)) {
                st.executeUpdate();

            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to fill table ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }
    //end tomcat debug section

    public static UserDAO getInstance(){
        if (instance == null) {
            synchronized (UserDAO.class) {
                if (instance == null) {
                    instance = new UserDAO();
                }
            }
        }
        return instance;
    }

    public void addUser(User user) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(ADD_USER_QUERY)) {
                st.setString(1, user.getSurname());
                st.setString(2, user.getName());
                st.setInt(3,user.getAge());
                st.setString(4,String.valueOf(user.getGender()));
                st.setString(5,user.getPhoneNumber());
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to add user ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }

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
                    user.setGender(rs.getString("gender").charAt(0));
                    user.setPhoneNumber(rs.getString("phone_number"));
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

    public void updateUser(User user) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(UPDATE_USER_QUERY)) {
                st.setString(1, user.getSurname());
                st.setString(2, user.getName());
                st.setInt(3,user.getAge());
                st.setString(4,String.valueOf(user.getGender()));
                st.setString(5,user.getPhoneNumber());
                st.setInt(6,user.getId());
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to update user information ", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("Connection problem occurred ", e1);
        }
    }

    public void deleteUser(int userId) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(DELETE_USER_QUERY)) {
                st.setInt(1,userId);
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

    public List<User> getAllUsers() {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(GET_ALL_QUERY)) {
                ResultSet rs = st.executeQuery();
                return getUsersList(rs);
            } catch (SQLException e) {
                throw new RuntimeException("Fail to get all users", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }

    public List<User> getUsersByQuery(String query) {
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(query)) {
                ResultSet rs = st.executeQuery();
                return getUsersList(rs);
            } catch (SQLException e) {
                throw new RuntimeException("Fail to search users", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }

    public List<User> getUsersByFilter(String parameter){
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(GET_USERS_BY_FILTER_QUERY)) {
                st.setString(1, "%" + parameter + "%");
                st.setString(2, "%" + parameter + "%");
                st.setString(3, "%" + parameter + "%");
                ResultSet rs = st.executeQuery();
                return getUsersList(rs);
            } catch (SQLException e) {
                throw new RuntimeException("Fail to get users by filter", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }

    public User getUserByPhone(String number){
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(GET_USER_ID_BY_PHONE)) {
                st.setString(1,number);
                ResultSet rs = st.executeQuery();
                if(!rs.next()){
                    return null;
                }
                return getUserById(Integer.parseInt(rs.getString("id")));
            } catch (SQLException e) {
                throw new RuntimeException("Fail to search users by phone number", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }

    private List<User> getUsersList(ResultSet rs)throws SQLException {
        List<User> list = new ArrayList<>();
        while(rs.next()) {
            User user = new User();
            user.setId(Integer.parseInt(rs.getString("id")));
            user.setSurname(rs.getString("surname"));
            user.setName(rs.getString("name"));
            user.setAge(rs.getInt("age"));
            user.setGender(rs.getString("gender").charAt(0));
            user.setPhoneNumber(rs.getString("phone_number"));
            list.add(user);
        }
        return list;
    }
}
