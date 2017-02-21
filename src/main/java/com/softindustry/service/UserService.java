package com.softindustry.service;

import com.softindustry.dao.UserDAO;
import com.softindustry.model.User;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class UserService {

    private UserDAO userDAO;

    public UserService() {
        super();
        userDAO = UserDAO.getInstance();
    }

    public void addUser(User user) {
        userDAO.addUser(user);
    }

    public User getUserById(int userId){
        return userDAO.getUserById(userId);
    }

    public void updateUser(User user){
        userDAO.updateUser(user);
    }

    public void deleteUser(int userId){
        userDAO.deleteUser(userId);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public List<User> getSearchResults(HttpServletRequest request){
        Map<String,String> searchParameters = new HashMap<>();
        for(String parameterKey:request.getParameterMap().keySet()){
            String parameterValue = request.getParameter(parameterKey);
            if(parameterValue!=null && !parameterValue.isEmpty()&& !parameterKey.equals("action")){
                searchParameters.put(parameterKey,parameterValue);
            }
        }
        if(searchParameters.isEmpty()){
            return null;
        }
        return userDAO.getUsersByQuery(getSearchQuery(searchParameters));
    }

    private String getSearchQuery(Map<String,String> searchParameters){
        String query = "SELECT * FROM notebook.users WHERE";
        int parametersCount=searchParameters.size();
        int index = 1;
        for(String parameterKey:searchParameters.keySet()){
            String parameterValue = searchParameters.get(parameterKey);
            query+=" "+parameterKey+ " LIKE '%"+parameterValue+"%'";
            if(index<parametersCount){
                query+=" AND";
            }
            index++;
        }
        return query;
    }

    public String getDataEntryErrors(HttpServletRequest request){
        String errors = "";
        String userId = request.getParameter("userId");
        String surname = request.getParameter("surname");
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String phoneNumber = request.getParameter("phone_number");

        if(surname==null || surname.isEmpty()|| !matchesRegex(surname,"^[а-яА-Я|a-zA-Z]{2,20}$")){
            errors+="Surname field must be filled with 2-20 letters<br/>";
        }
        if(name==null || name.isEmpty()|| !matchesRegex(name,"^[а-яА-Я|a-zA-Z]{2,20}$")){
            errors+="Name field must be filled with 2-20 letter<br/>";
        }
        if(age==null || age.isEmpty()|| !matchesRegex(age,"^([4-9]|[1-8][0-9]|9[0-9]|1[0-4][0-9]|150)$")){
            errors+="Age must be in 4-150 range<br/>";
        }
        if(gender==null || !matchesRegex(gender,"^[m,f]$")){
            errors+="Gender is not set<br/>";
        }
        if(phoneNumber==null || phoneNumber.isEmpty()||
                !matchesRegex(phoneNumber,"^\\+\\d{12}$")){
            errors+="Wrong number format<br/>";
        }
        String fullNameByPhone = userDAO.getFullNameByPhone(phoneNumber);
        System.out.println(userId);
        if((userId==null || userId.isEmpty() || userId=="0")&&fullNameByPhone!=null){
            errors+="Phone number is already stored in notebook as " + fullNameByPhone + "<br/>";
        }
        return errors;
    }

    private boolean matchesRegex(String string, String regex){
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(string);
        return m.matches();
    }
}
