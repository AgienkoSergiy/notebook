<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Список пользователей</title>
</head>
<body>
    <p>
        <a href="${pageContext.request.contextPath}/user?action=create">Добавить пользователя </a>
        <a href="${pageContext.request.contextPath}/user?action=search">Поиск </a>
    </p>
    <c:choose>
        <c:when test="${empty users}">
            <p>Ваша записная книжка пуста</p>
        </c:when>
        <c:otherwise>
            <table border="1" cellspacing="0" cellpadding="3">
                <caption>Все пользователи:</caption>
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
