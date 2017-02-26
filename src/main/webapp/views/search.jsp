<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Search</title>

    <c:set var="root" value="${pageContext.request.contextPath}" />
    <!-- Bootstrap core CSS -->
    <link href="${root}/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <link href="${root}/resources/css/bootstrap-theme.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="${root}/resources/css/theme.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

    <nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Notebook</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li><a href="${root}/user?action=show_all">Users list</a></li>
                <li><a href="${root}/user?action=create">Add user</a></li>
            </ul>
        </div><!--/.nav-collapse -->
    </div>
</nav>

    <form name="search_form" action="search" method="get">
        <table>
            <caption>Enter search criteria</caption>
            <tr>
                <td align="right"><label for="surname">Surname:</label></td>
                <td><input id="surname" type="text" name="surname" size="20"  value="${param.surname}"/></td>
                <td id="surname_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="name">Name:</label></td>
                <td><input id="name" type="text" name="name" size="20" value="${param.name}" /></td>
                <td id="name_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="age">Age:</label></td>
                <td><input id="age" type="text" name="age" size="20" value="${param.age}"/></td>
                <td id="age_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="gender">Gender:</label></td>
                <td>
                    <select id="gender" name="gender">
                        <option selected value="" >Select gender:</option>
                        <option value="m" ${param.gender == 'm' ? 'selected="selected"' : ''}>
                            Male
                        </option>
                        <option value="f" ${param.gender == 'f' ? 'selected="selected"' : ''}>
                            Female
                        </option>
                    </select>
                </td>
                <td id="gender_valid"></td>
            </tr>
            <tr>
                <td align="right"><label for="phone_number">Phone number +380123456789:</label></td>
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
            <p>No search results yet</p>
        </c:when>
        <c:otherwise>
            <div class="col-md-6">
                <table class="table table-striped">
                    <caption>All users:</caption>
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Surname</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Phone Number</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${users}" var="user" varStatus="loop">
                        <tr>
                            <td>${loop.index}</td>
                            <td>${user.surname}  </td>
                            <td>${user.name}  </td>
                            <td>${user.age}  </td>
                            <td>${user.gender}  </td>
                            <td>${user.phoneNumber}  </td>
                            <td><a href="${pageContext.request.contextPath}/user?action=update&userId=${user.id}">Edit</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

</body>
</html>
