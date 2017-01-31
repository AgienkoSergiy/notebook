<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User</title>
</head>
<body>

<form name="contact_form" action="save" method="post">
    <table>
        <c:choose>
            <c:when test="${user==null}">
                <caption>Заполнить поля</caption>
            </c:when>
            <c:otherwise>
                <caption>Редактирование информации</caption>
                    <a href="${pageContext.request.contextPath}/user?action=delete&userId=${user.id}">Удалить пользователя</a>

                 <%--TODO js confirmation--%>
            </c:otherwise>
        </c:choose>
        <tr>
            <td align="right"><label for="surname">Фамилия:</label></td>
            <td><input type="text" name="surname" size="50" value="${user.surname}"/></td>
        </tr>
        <tr>
            <td align="right"><label for="name">Имя:</label></td>
            <td><input type="text" name="name" size="50" value="${user.name}" /></td>
        </tr>
        <tr>
            <td align="right"><label for="age">Возраст:</label></td>
            <td><input type="text" name="age" size="50" value="${user.age}"/></td>
        </tr>
        <tr>
            <td align="right"><label for="gender">Пол:</label></td>
            <td>
                <select name="gender">
                    <option value=""></option>
                    <option value="м">Мужчина</option>
                    <option value="ж">Женщина</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right"><label for="phone_number">Номер телефона:</label></td>
            <td><input type="text" name="phone_number" size="50" value="${user.phoneNumber}"/></td>
        </tr>
    </table>
    <p>
        <input type="hidden" name="userId" value="${user.id}" />
        <input type="submit" value="OK" />
        <input type="reset" value="Очистить"/>
    </p>
</form>
</body>
</html>
