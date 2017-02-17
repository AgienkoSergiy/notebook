<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Пользователь</title>
</head>
<body>
    <h1>Записная книжка</h1>
    <p> <a href="${pageContext.request.contextPath}/users">Список всех пользователей</a></p>
    <p><a href="${pageContext.request.contextPath}/user?action=search">Поиск</a></p>
    <form name="contact_form" action="user?action=show_all" method="post" onsubmit="checkFields();">
        <table>
            <c:choose>
                <c:when test="${user==null || user.id==0}">
                    <caption>Заполните поля</caption>
                </c:when>
                <c:otherwise>
                    <caption>Редактирование информации</caption>
                    <p>
                        <a onclick="confirmDeletion();"
                          href="${pageContext.request.contextPath}/user?action=delete&userId=${user.id}">
                        Удалить пользователя
                        </a>
                    </p>
                </c:otherwise>
            </c:choose>
            <tr>
                <td align="right"><label for="surname">Фамилия:</label></td>
                <td><input id="surname" type="text" name="surname" size="20" value="${user.surname}" onchange="validSurname()"/></td>
                <td id="surname_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="name">Имя:</label></td>
                <td><input id="name" type="text" name="name" size="20" value="${user.name}" onchange="validName()" /></td>
                <td id="name_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="age">Возраст:</label></td>
                <td><input id="age" type="text" name="age" size="20" value="${user.age}" onchange="validAge()"/></td>
                <td id="age_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="gender">Пол:</label></td>
                <td>
                    <select id="gender" name="gender" onchange="validGender()">
                        <option disabled selected>Выберите пол:</option>
                        <option value="m" ${user.gender == 109 ? 'selected="selected"' : ''}>
                            Мужчина
                        </option>
                        <option value="f" ${user.gender == 102 ? 'selected="selected"' : ''}>
                            Женщина
                        </option>
                    </select>
                </td>
                <td id="gender_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="phone_number">Номер телефона в формате +380123456789:</label></td>
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

    <script id="validation">
        var isNameValid = false;
        var isSurnameValid = false;
        var isAgeValid = false;
        var isGenderValid = false;
        var isPhoneNumberValid = false;

        function confirmDeletion() {
            if(!confirm('Подтвердите удаление пользователя')){
                event.preventDefault();
            }
        }

        function validSurname(){
            var surname = document.getElementById("surname").value;
            var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
            var message;
            if(regex.test(surname)){
                message = "Ок";
                isSurnameValid = true;
            }
            else {
                message = "Ошибка! Поле принимает 2-20 букв";
                isSurnameValid = false;
            }
            document.getElementById("surname_valid").innerHTML = message;
        }

        function validName(){
            var message;
            var name = document.getElementById("name").value;
            var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
            if(regex.test(name)){
                message = "Ок";
                isNameValid = true;
            }
            else {
                message = "Ошибка! Поле принимает 2-20 букв";
                isNameValid = false;
            }
            document.getElementById("name_valid").innerHTML = message;
        }

        function validAge(){
            var message;
            var age = document.getElementById("age").value;
            if(age > 3 && age < 150){
                message = "Ок";
                isAgeValid = true;
            }
            else {
                message = "Ошибка! Введите правдоподобное число(от 4 до 150)";
                isAgeValid = false;
            }
            document.getElementById("age_valid").innerHTML = message;
        }

        function validGender(){
            var message;
            var gender = document.getElementById("gender").value;
            if(gender==="m"|| gender==="f"){
                message = "Ок";
                isGenderValid = true;
            }
            else {
                message = "Ошибка! Пол не выбран";
                isGenderValid = false;
            }
            document.getElementById("gender_valid").innerHTML = message;
        }

        function validPhoneNumber(){
            var message;
            var phoneNumber = document.getElementById("phone_number").value;
            var regex = new RegExp("^\\+\\d{12}$");
            if (regex.test(phoneNumber)){
                message = "Формат введен верно";
                isPhoneNumberValid = true;
            }
            else {
                message = "Ошибка! Неверный формат ввода, правильный пример: +380123456789";
                isPhoneNumberValid = false;
            }
            document.getElementById("phone_valid").innerHTML = message;
        }

        function checkFields(){
            validSurname();
            validName();
            validAge();
            validGender();
            validPhoneNumber();
            if(isSurnameValid && isNameValid &&  isAgeValid && isPhoneNumberValid&&isGenderValid){
                return true;
            }else{
                event.preventDefault();
                alert("Проверьте правильность заполнения полей!");
                return false;
            }
        }
    </script>
</body>
</html>
