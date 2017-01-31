<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>All users</title>
</head>
<body>
    <c:choose>
        <c:when test="${empty users}">
            <p>Ваша записная книжка пуста</p><br>
                <a href="${pageContext.request.contextPath}/user?action=create">Добавить пользователя</a>
        </c:when>
        <c:otherwise>
            <table>
                <caption>Все пользователи:</caption>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.name}</td>
                        <td>${user.surname}</td>
                        <td>${user.age}</td>
                        <td>${user.gender}</td>
                        <td>${user.phoneNumber}</td>
                        <td><a href="${pageContext.request.contextPath}/user?action=update&userId=${user.id}">Edit</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
