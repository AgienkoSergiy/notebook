package com.softindustry.model.dao;

import com.softindustry.model.entity.User;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Created by konstr6 on 27.01.2017.
 */

    abstract class AbstractNotebookDAO {

    protected abstract void initDataSource();
    protected abstract Connection getConnection() throws SQLException;

    public abstract void addUser(User user);
    public abstract User getUserById(int id);
    public abstract void updateUser(User user);
    public abstract void deleteUser(User user); //TODO Explain adding delete method in readme file

}
