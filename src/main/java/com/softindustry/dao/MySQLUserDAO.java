package com.softindustry.dao;

import com.softindustry.model.User;
import com.softindustry.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import static com.softindustry.util.DBUtil.getConnection;

/**
 * Created by konstr6 on 27.01.2017.
 */
public class MySQLUserDAO implements UserDAO {

    private static final String ADD_USER_QUERY = "INSERT INTO notebook.users (" +
            "surname, name, age, sex, phone_number) VALUES (?, ?, ?, ?, ?);";
    private static final String GET_USER_QUERY = "SELECT surname, name, age, sex, phone_number" +
            " FROM notebook.users WHERE id=?;";
    private static final String UPDATE_USER_QUERY = "UPDATE notebook.users" +
            " SET surname=?, name=?, age=?, sex=?, phone_number=? WHERE id=?;";
    private static final String DELETE_USER_QUERY = "DELETE FROM notebook.users WHERE id=?;";

    private static final String CREATE_TABLE_QUERY = "CREATE TABLE IF NOT EXISTS `notebook`.`users` (" +
            "  `id` INT NOT NULL AUTO_INCREMENT," +
            "  `surname` VARCHAR(45) NULL," +
            "  `name` VARCHAR(45) NULL," +
            "  `age` INT NULL," +
            "  `sex` VARCHAR(1) NULL," +
            "  `phone_number` VARCHAR(20) NULL," +
            "  PRIMARY KEY (`id`));";
    private static final String FILL_TABLE_QUERY = "";


    public MySQLUserDAO() {
        new DBUtil();
        createTable();
        fillTable();
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
                    user.setGender(rs.getString("sex").charAt(0));
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
