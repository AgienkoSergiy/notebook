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

/**
 * Created by konstr6 on 27.01.2017.
 */
public class MySQLUserDAO implements UserDAO {

    private static final String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS `notebook`.`users` (" +
            "  `id` INT NOT NULL AUTO_INCREMENT," +
            "  `surname` VARCHAR(45) NULL," +
            "  `name` VARCHAR(45) NULL," +
            "  `age` INT NULL," +
            "  `gender` VARCHAR(1) NULL," +
            "  `phone_number` VARCHAR(20) NULL," +
            "  PRIMARY KEY (`id`));";
    private static final String FILL_TABLE_QUERY = "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Кравцов', 'Иван', '25', 'м', '123456');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, ``, `phone_number`) VALUES ('Авдеев', 'Николай', '23', 'м', '12345');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Лавкрафт', 'Говард', '64', 'м', '123456');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Ахматова', 'Анна', '35', 'ж', '1234');" +
            "INSERT INTO `notebook`.`users` (`surname`, `name`, `age`, `gender`, `phone_number`) VALUES ('Заюшкина', 'Даниэлла', '31', 'ж', '123456');";

    private static final String ADD_USER_QUERY = "INSERT INTO notebook.users (" +
            "surname, name, age, gender, phone_number) VALUES (?, ?, ?, ?, ?);";
    private static final String GET_USER_QUERY = "SELECT surname, name, age, gender, phone_number" +
            " FROM notebook.users WHERE id=?;";
    private static final String UPDATE_USER_QUERY = "UPDATE notebook.users" +
            " SET surname=?, name=?, age=?, gender=?, phone_number=? WHERE id=?;";
    private static final String DELETE_USER_QUERY = "DELETE FROM notebook.users WHERE id=?;";
    private static final String GET_ALL_QUERY = "SELECT * FROM notebook.users;";

    DBUtil dbUtil;

    public MySQLUserDAO() {
        dbUtil = new DBUtil();
        createTable();
        //fillTable();
    }

    @Override
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

    @Override
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

    @Override
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

    @Override
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

    @Override
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

    /*
    * Creating table and filling it with test data
    * */

    private void createTable(){  //todo try batch solution
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(CREATE_TABLE_QUERY)) {
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to create a table", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }

    private void fillTable(){
        try (Connection conn = getConnection()) {
            try (PreparedStatement st = conn.prepareStatement(FILL_TABLE_QUERY)) {
                st.execute();
                conn.commit();
            } catch (SQLException e) {
                conn.rollback();
                throw new RuntimeException("Fail to fill a table", e);
            }
        } catch (SQLException e1) {
            throw new RuntimeException("A problem with connection", e1);
        }
    }
}
