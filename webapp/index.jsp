<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<h1>Hello world!</h1>
<a href="${pageContext.request.contextPath}/user?action=create">Create user</a>
<a href="${pageContext.request.contextPath}/user?action=search">Search user</a>
<a href="${pageContext.request.contextPath}/user?action=getAllUsers">View all users</a>
</body>
</html>
