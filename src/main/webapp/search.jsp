<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User</title>
</head>
<body>
<p>
    <a href="${pageContext.request.contextPath}/users">Весь список</a>
    <a href="${pageContext.request.contextPath}/user?action=create">Добавить пользователя </a>
</p>
<form name="search_form" action="search" method="get">
    <table>
        <caption>Введите критерии поиска</caption>
        <tr>
            <td align="right"><label for="surname">Фамилия (только кириллица):</label></td>
            <td><input id="surname" type="text" name="surname" size="20"  value="${param.surname}"/></td>
            <td id="surname_valid"></td>
        </tr>
        <tr>
            <td align="right"><label for="name">Имя (только кириллица):</label></td>
            <td><input id="name" type="text" name="name" size="20" value="${param.name}" /></td>
            <td id="name_valid"></td>
        </tr>
        <tr>
            <td align="right"><label for="age">Возраст:</label></td>
            <td><input id="age" type="text" name="age" size="20" value="${param.age}"/></td>
            <td id="age_valid"></td>
        </tr>
        <tr>
            <td align="right"><label for="gender">Пол:</label></td>
            <td>
                <select id="gender" name="gender">
                    <option disabled selected>Выберите пол:</option>
                    <option value="м">Мужчина</option>
                    <option value="ж">Женщина</option>
                </select>
            </td>
            <td id="gender_valid"></td>
        </tr>
        <tr>
            <td align="right"><label for="phone_number">Номер телефона в формате +хх(ххх)ххх-хх-хх:</label></td>
            <td><input id="phone_number" type="text" name="phone_number" size="20" value="${param.phone_number}"/></td>
            <td id="phone_valid"></td>
        </tr>
    </table>
    <p>
        <input type="hidden" name="action" value="get_results"/>
        <input id="ok_button" type="submit" value="Поиск"/>
    </p>
</form>

<c:choose>
    <c:when test="${empty users}">
        <p>Поиск пока не дал результатов</p>
    </c:when>
    <c:otherwise>
        <table border="1" cellspacing="0" cellpadding="3">
            <caption>Результаты поиска:</caption>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.surname}  </td>
                    <td>${user.name}  </td>
                    <td>${user.age}  </td>
                    <td>${user.gender}  </td>
                    <td>${user.phoneNumber}  </td>
                    <td><a href="${pageContext.request.contextPath}/user?action=update&userId=${user.id}">Редактировать</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise>
</c:choose>

</body>
</html>
