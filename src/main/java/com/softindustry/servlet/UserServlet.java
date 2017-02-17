package com.softindustry.servlet;

import com.softindustry.model.User;
import com.softindustry.service.UserService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "UserServlet", urlPatterns = {"/"})
public class UserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static String ADD_OR_UPDATE = "/user.jsp";
    private static String LIST_USER = "/usersList.jsp";
    private static String SEARCH = "/search.jsp";

    private UserService userService;

    public UserServlet() {
        super();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action==null){
            action="show_all";
        }

        RequestDispatcher view = getView(request,action);
        view.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String dataEntryErrors=userService.getDataEntryErrors(request);
        User user = getUserFromParams(request);
        String userId = request.getParameter("userId");
        if(dataEntryErrors.isEmpty()){
            if(userId == null || userId.isEmpty() || userId.equals("0")){
                userService.addUser(user);
            }
            else{
                user.setId(Integer.parseInt(userId));
                userService.updateUser(user);
            }
            response.sendRedirect("users");
        }
        else{
            request.setAttribute("user",user);
            request.setAttribute("errors",dataEntryErrors);
            RequestDispatcher view = request.getRequestDispatcher(ADD_OR_UPDATE);
            view.forward(request, response);
        }
    }

    private RequestDispatcher getView(HttpServletRequest request, String action){
        String forward;
        switch (action){
            case "create":
                forward = ADD_OR_UPDATE;
                break;
            case "update":
                int userId = Integer.parseInt(request.getParameter("userId"));
                request.setAttribute("user",userService.getUserById(userId));
                forward = ADD_OR_UPDATE;
                break;
            case "delete":
                userId = Integer.parseInt(request.getParameter("userId"));
                userService.deleteUser(userId);
                request.setAttribute("users", userService.getAllUsers());
                forward = LIST_USER;
                break;
            case "search":
                forward = SEARCH;
                break;
            case "get_results":
                request.setAttribute("users", userService.getSearchResults(request));
                forward = SEARCH;
                break;
            case "show_all":
                request.setAttribute("users", userService.getAllUsers());
                forward = LIST_USER;
                break;
            default:
                request.setAttribute("users", userService.getAllUsers());
                forward = LIST_USER;
        }
        return request.getRequestDispatcher(forward);
    }

    private User getUserFromParams(HttpServletRequest request){
        User user = new User();
        user.setName(request.getParameter("name"));
        user.setSurname(request.getParameter("surname"));
        user.setAge(Integer.parseInt(request.getParameter("age")));
        user.setGender(request.getParameter("gender").charAt(0));
        user.setPhoneNumber(request.getParameter("phone_number"));
        return user;
    }
}
