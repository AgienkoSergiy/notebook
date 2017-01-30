package com.softindustry.dao;

import com.softindustry.model.User;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by konstr6 on 27.01.2017.
 */

    public interface UserDAO {

    void addUser(User user);
    User getUserById(int userId);
    void updateUser(User user);
    void deleteUser(int userId); //TODO Explain adding delete method in readme file

}
