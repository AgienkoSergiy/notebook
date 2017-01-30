<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User</title>
</head>
<body>

<form name="contact_form" action="save" method="post" onsubmit="return validate_form(contact_form);">
    <table>
        <caption>Заполнить поля</caption>
        <tr>
            <td align="right"><label for="name">Имя:</label></td>
            <td><input type="text" name="name" size="50" /></td>
        </tr>
        <tr>
            <td align="right"><label for="surname">Фамилия:</label></td>
            <td><input type="text" name="surname" size="50" /></td>
        </tr>
        <tr>
            <td align="right"><label for="age">Фамилия:</label></td>
            <td><input type="text" name="age" size="50" /></td>
        </tr>
        <tr>
            <td align="right"><label for="phone_number">Номер телефона:</label></td>
            <td><input type="text" name="phone_number" size="50" /></td>
        </tr>
        <tr>
            <td align="right"><label for="gender">Пол:</label></td>
            <td><input type="text" name="gender" size="50" /></td>
            <td>
                <select name="gender">
                    <option value="м">Мужчина</option>
                    <option value="ж">Женщина</option>
                </select>
            </td>
        </tr>
    </table>
    <p align="center">
        <input type="submit" value="OK" />
        <input type="reset" value="Очистить" />
    </p>
</form>
</body>
</html>
