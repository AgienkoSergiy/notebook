<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <c:set var="root" value="${pageContext.request.contextPath}" />

    <link rel="icon" href="${root}/resources/favicon.ico">

    <title>Users list</title>

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
                    <li><a href="${root}/user?action=search">
                            <span class="glyphicon glyphicon-search"></span>
                             Search</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">
        <h3>Quick search:</h3>
        <form name="search_form" action="user" method="get">
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
    </div>

    <div class="container">

            <c:if test="${!empty users}">

                <div class="col-md-6">
                    <table class="table table-striped">
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
                                    <td><a href="${root}/user?action=update&userId=${user.id}"
                                           class="btn btn-primary" role="button">
                                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                            Edit
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="${root}/resources/js/bootstrap.min.js"></script>
</body>
</html>
