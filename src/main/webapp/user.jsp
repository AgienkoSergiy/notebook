<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User</title>
</head>
<body>
    <h1>Notebook</h1>
    <p> <a href="${pageContext.request.contextPath}/users">Users list</a></p>
    <p><a href="${pageContext.request.contextPath}/user?action=search">Search</a></p>
    <form name="contact_form" action="user?action=show_all" method="post" onsubmit="checkFields();">
        <table>
            <c:choose>
                <c:when test="${user==null || user.id==0}">
                    <caption>Fill the fields</caption>
                </c:when>
                <c:otherwise>
                    <caption>Edit information</caption>
                    <p>
                        <a onclick="confirmDeletion();"
                          href="${pageContext.request.contextPath}/user?action=delete&userId=${user.id}">
                        Delete user
                        </a>
                    </p>
                </c:otherwise>
            </c:choose>
            <tr>
                <td align="right"><label for="surname">Surname:</label></td>
                <td><input id="surname" type="text" name="surname" size="20" value="${user.surname}" onchange="validSurname()"/></td>
                <td id="surname_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="name">Name:</label></td>
                <td><input id="name" type="text" name="name" size="20" value="${user.name}" onchange="validName()" /></td>
                <td id="name_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="age">Age:</label></td>
                <td><input id="age" type="text" name="age" size="20" value="${user.age}" onchange="validAge()"/></td>
                <td id="age_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="gender">Gender:</label></td>
                <td>
                    <select id="gender" name="gender" onchange="validGender()">
                        <option disabled selected>Select gender:</option>
                        <option value="m" ${user.gender == 109 ? 'selected="selected"' : ''}>
                            Male
                        </option>
                        <option value="f" ${user.gender == 102 ? 'selected="selected"' : ''}>
                            Female
                        </option>
                    </select>
                </td>
                <td id="gender_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="phone_number">Phone number in format +380123456789:</label></td>
                <td><input id="phone_number" type="text" name="phone_number" size="20" value="${user.phoneNumber}" onchange="validPhoneNumber()"/></td>
                <td id="phone_valid"></td>
            </tr>
        </table>
        <p>${errors}</p>
        <p>
            <input type="hidden" name="userId" value="${user.id}" />
            <input id="ok_button" type="submit" value="OK"/>
        </p>
    </form>

    <script id="validation" src="${pageContext.request.contextPath}/resources/js/validation.js">
//        var isNameValid = false;
//        var isSurnameValid = false;
//        var isAgeValid = false;
//        var isGenderValid = false;
//        var isPhoneNumberValid = false;
//
//        function confirmDeletion() {
//            if(!confirm('Confirm user deletion')){
//                event.preventDefault();
//            }
//        }
//
//        function validSurname(){
//            var surname = document.getElementById("surname").value;
//            var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
//            var message;
//            if(regex.test(surname)){
//                message = "Ok";
//                isSurnameValid = true;
//            }
//            else {
//                message = "Error! Field can take 2-20 letters";
//                isSurnameValid = false;
//            }
//            document.getElementById("surname_valid").innerHTML = message;
//        }
//
//        function validName(){
//            var message;
//            var name = document.getElementById("name").value;
//            var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
//            if(regex.test(name)){
//                message = "Ок";
//                isNameValid = true;
//            }
//            else {
//                message = "Error! Field can take 2-20 letters";
//                isNameValid = false;
//            }
//            document.getElementById("name_valid").innerHTML = message;
//        }
//
//        function validAge(){
//            var message;
//            var age = document.getElementById("age").value;
//            if(age > 3 && age < 150){
//                message = "Ok";
//                isAgeValid = true;
//            }
//            else {
//                message = "Error! Enter number in range 4-150";
//                isAgeValid = false;
//            }
//            document.getElementById("age_valid").innerHTML = message;
//        }
//
//        function validGender(){
//            var message;
//            var gender = document.getElementById("gender").value;
//            if(gender==="m"|| gender==="f"){
//                message = "Ok";
//                isGenderValid = true;
//            }
//            else {
//                message = "Error gender is not set";
//                isGenderValid = false;
//            }
//            document.getElementById("gender_valid").innerHTML = message;
//        }
//
//        function validPhoneNumber(){
//            var message;
//            var phoneNumber = document.getElementById("phone_number").value;
//            var regex = new RegExp("^\\+\\d{12}$");
//            if (regex.test(phoneNumber)){
//                message = "Format is correct";
//                isPhoneNumberValid = true;
//            }
//            else {
//                message = "Error! Wrong number format. Correct example: +380123456789";
//                isPhoneNumberValid = false;
//            }
//            document.getElementById("phone_valid").innerHTML = message;
//        }
//
//        function checkFields(){
//            validSurname();
//            validName();
//            validAge();
//            validGender();
//            validPhoneNumber();
//            if(isSurnameValid && isNameValid &&  isAgeValid && isPhoneNumberValid&&isGenderValid){
//                return true;
//            }else{
//                event.preventDefault();
//                alert("Check entered information!");
//                return false;
//            }
//        }
    </script>
</body>
</html>
