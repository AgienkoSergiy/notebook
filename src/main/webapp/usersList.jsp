<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Users list</title>
</head>
<body>
    <h1>Notebook</h1>
    <p><a href="${pageContext.request.contextPath}/user?action=create">Add user</a></p>
    <p><a href="${pageContext.request.contextPath}/user?action=search">Search</a></p>
    <c:choose>
        <c:when test="${empty users}">
            <p>Your notebook is empty</p>
        </c:when>
        <c:otherwise>
            <table border="1" cellspacing="0" cellpadding="3">
                <caption>All users:</caption>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.surname}  </td>
                        <td>${user.name}  </td>
                        <td>${user.age}  </td>
                        <td>${user.gender}  </td>
                        <td>${user.phoneNumber}  </td>
                        <td><a href="${pageContext.request.contextPath}/user?action=update&userId=${user.id}">Edit</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
