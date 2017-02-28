<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <c:set var="root" value="${pageContext.request.contextPath}" />
    <c:set var="isAddPage" value="${user==null || user.id==0}" />

    <link rel="icon" href="${root}/resources/favicon.ico">

    <title>User</title>

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
                    <li ${isAddPage ? 'class="active"' : ''}>
                        <a href="${root}/user?action=create">
                            <span class="glyphicon glyphicon-user"></span>
                            Add user
                        </a>
                    </li>
                    <li><a href="${root}/user?action=search">
                        <span class="glyphicon glyphicon-search"></span>
                        Search</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="col-md-6">
        <div class="container">
            <form name="contact_form" action="user?action=show_all" method="post" onsubmit="checkFields();">
                <table>
                    ${isAddPage?"<h2>Fill the fields</h2>":"<h2>Edit information</h2>"}
                    <tr>
                        <td align="right"><label for="surname">Surname:</label></td>
                        <td><input id="surname" type="text" name="surname" size="20" value="${user.surname}" onchange="validSurname()"/></td>
                        <td id="surname_valid"></td>
                    </tr>

                    <tr>
                        <td align="right"><label for="name">Name:</label></td>
                        <td><input id="name" type="text" name="name" size="20" value="${user.name}" onchange="validName()" /></td>
                        <td id="name_valid"></td>
                    </tr>

                    <tr>
                        <td align="right"><label for="age">Age:</label></td>
                        <td><input id="age" type="text" name="age" size="20" value="${user.age}" onchange="validAge()"/></td>
                        <td id="age_valid"></td>
                    </tr>

                    <tr>
                        <td align="right"><label for="gender">Gender:</label></td>
                        <td>
                            <select id="gender" name="gender" onchange="validGender()">
                                <option disabled selected>Select gender:</option>
                                <option value="m" ${user.gender == 109 ? 'selected="selected"' : ''}>
                                    Male
                                </option>
                                <option value="f" ${user.gender == 102 ? 'selected="selected"' : ''}>
                                    Female
                                </option>
                            </select>
                        </td>
                        <td id="gender_valid"></td>
                    </tr>

                    <tr>
                        <td align="right"><label for="phone_number">Phone number:</label></td>
                        <td><input id="phone_number" type="text" name="phone_number"
                                   placeholder="format:+380123456789" size="20" value="${user.phoneNumber}"
                                   onchange="validPhoneNumber();"/></td>
                        <td id="phone_valid"></td>
                    </tr>

                    <tr>
                        <td></td>
                        <c:if test="${!empty errors}">
                            <td><div class="alert alert-danger">${errors}</div></td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>
                            <c:if test="${!isAddPage}">
                                <a onclick="confirmDeletion();" href="${root}/user?action=delete&userId=${user.id}"
                                       class="btn btn-danger" role="button">
                                    <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"></span>
                                    Delete user
                                </a>
                            </c:if>
                        </td>
                        <td><button  id="ok_button" type="submit" class="btn btn-success">
                            <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
                            OK
                        </button></td>
                        <td><input type="hidden" name="userId" value="${user.id}"/></td>
                    </tr>
                </table>
            </form>

        </div>
    </div>

    <script id="validation" src="${root}/resources/js/validation.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="${root}/resources/js/bootstrap.min.js"></script>
</body>
</html>
