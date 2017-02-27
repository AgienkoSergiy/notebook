<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="../../favicon.ico"> <%--TODO favicon--%>

    <title>Search</title>

    <c:set var="root" value="${pageContext.request.contextPath}" />
    <link href="${root}/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${root}/resources/css/style.css" rel="stylesheet">
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
                <a class="navbar-brand" href="${root}/user?action=show_all"><span class="glyphicon glyphicon-list-alt"></span> Notebook</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="${root}/user?action=create">
                        <span class="glyphicon glyphicon-user"></span>
                        Add user</a>
                    </li>
                    <li class="active"><a href="${root}/user?action=search">
                        <span class="glyphicon glyphicon-search"></span>
                        Search</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="col-md-6">
        <div class="container">
            <form name="search_form" action="search" method="get">
                <table>
                    <h2>Enter search criteria</h2>
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
                        <td align="right"><label for="phone_number">Phone number:</label></td>
                        <td><input id="phone_number" type="text" name="phone_number" size="20" value="${param.phone_number}"/></td>
                        <td id="phone_valid"></td>
                    </tr>
                    <tr>
                        <td><input type="hidden" name="action" value="get_results"/></td>
                        <td><button  id="ok_button" type="submit" class="btn btn-primary">
                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            Search
                        </button></td>
                    </tr>
                </table>

            </form>
        </div>
    </div>



    <c:choose>
        <c:when test="${empty users}">
            <p>No search results yet</p>
        </c:when>
        <c:otherwise>
            <div class="col-md-6">
                <table class="table table-striped">
                    <h1 class="text-center">Search results:</h1>
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
                            <td>${loop.index+1}</td>
                            <td>${user.surname}  </td>
                            <td>${user.name}  </td>
                            <td>${user.age}  </td>
                            <td>${user.gender}  </td>
                            <td>${user.phoneNumber}  </td>
                            <td><a href="${root}/user?action=update&userId=${user.id}" class="btn btn-primary" role="button">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                Edit
                            </a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="${root}/resources/js/bootstrap.min.js"></script>
</body>
</html>
