package com.softindustry.service;

import com.softindustry.dao.MySQLUserDAO;
import com.softindustry.dao.UserDAO;
import com.softindustry.model.User;

/**
 * Created by skyrvr on 28.01.17.
 */
public class UserService {

    private UserDAO userDAO;

    public UserService() {
        super();
        userDAO = new MySQLUserDAO();
    }

    public void addUser(User user){
        userDAO.addUser(user);
    }

    User getUserById(int userId){
        return userDAO.getUserById(userId);
    }

    public void updateUser(User user){
        userDAO.updateUser(user);
    }

    public void deleteUser(int userId){
        userDAO.deleteUser(userId);
    }
}
