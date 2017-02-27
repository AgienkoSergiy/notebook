<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

    <title>Users list</title>

    <c:set var="root" value="${pageContext.request.contextPath}" />
    <!-- Bootstrap core CSS -->
    <link href="${root}/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap theme -->
    <%--<link href="${root}/resources/css/bootstrap-theme.min.css" rel="stylesheet">--%>
    <!-- Custom styles for this template -->
    <link href="${root}/resources/css/style.css" rel="stylesheet">

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
                <a class="navbar-brand" href="${root}/user?action=show_all"><span class="glyphicon glyphicon-list-alt"></span> Notebook</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="${root}/user?action=create">
                        <span class="glyphicon glyphicon-user"></span>
                         Add user</a>
                    </li>
                    <li><a href="${root}/user?action=search">
                            <span class="glyphicon glyphicon-search"></span>
                             Search</a>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </nav>
    <div class="container">
        <c:choose>
            <c:when test="${empty users}">
                <p>Your notebook is empty</p>
            </c:when>
            <c:otherwise>

            <form name="search_form" method="get">
                <div class="form-group">
                    <div class="input-group">
                        <input type="hidden" name="action" value="show_filtered"/>
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">
                                <span class="glyphicon glyphicon-search"></span> Go!
                            </button>
                        </span>
                        <input type="text" class="form-control" name="filter" placeholder="Search for...">
                    </div>
                </div>
            </form>

            <div class="col-md-6">
                <table class="table table-striped">
                    <h1 class="text-center">All users:</h1>
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
    </div>
        </c:otherwise>
    </c:choose>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="${root}/resources/js/bootstrap.min.js"></script>
</body>
</html>
