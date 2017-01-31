package com.softindustry.controller;

import com.softindustry.model.User;
import com.softindustry.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by skyrvr on 27.01.17.
 */
@WebServlet(name = "UserController")
public class UserController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static String ADD_OR_UPDATE = "/WEB-INF/views/user.jsp";
    private static String LIST_USER = "/WEB-INF/views/usersList.jsp";
    private static String SEARCH = "/WEB-INF/views/search.jsp";

    private UserService userService;

    public UserController() {
        super();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String forward;
        String action = request.getParameter("action");

        switch (action){
            case "create":
                forward = ADD_OR_UPDATE;
                break;
            case "update":
                forward = ADD_OR_UPDATE;
                int userId = Integer.parseInt(request.getParameter("userId"));
                request.setAttribute("user",userService.getUserById(userId));
                break;
            case "delete":
                userId = Integer.parseInt(request.getParameter("userId"));
                userService.deleteUser(userId);
                forward = LIST_USER;
                request.setAttribute("users", userService.getAllUsers());
                break;
            case "search":
                forward = SEARCH;
                break;
            default: forward = LIST_USER;
                request.setAttribute("users", userService.getAllUsers());
        }
        RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setSurname(request.getParameter("surname"));
        user.setAge(Integer.parseInt(request.getParameter("age")));
        user.setGender(request.getParameter("gender").charAt(0));
        user.setPhoneNumber(request.getParameter("phone_number"));
        String userId = request.getParameter("userId");
        if(userId == null || userId.isEmpty())
        {
            userService.addUser(user);
        }
        else
        {
            user.setId(Integer.parseInt(userId));
            userService.updateUser(user);
        }
        RequestDispatcher view = request.getRequestDispatcher(LIST_USER);
        request.setAttribute("users", userService.getAllUsers());
        view.forward(request, response);
    }
}
