var isNameValid = false;
var isSurnameValid = false;
var isAgeValid = false;
var isPhoneNumberValid = false;




function validSurname(){
    alert("go");
    var surname = document.getElementById("surname").value;
    var regex = new RegExp("^[A-Za-z]{3,20}|[а-яА-Я]{3,20}$");
    isSurnameValid = regex.test(surname);
    makeButtonDisable();
}

function validName(){
    document.getElementById("demo").innerHTML = "fffff";
    var name = document.getElementById("name").value;
    var regex = new RegExp("^[A-Za-z]{3,20}|[а-яА-Я]{3,20}$");
    if(regex.test(name)){
        isNameValid = true;
    }
    else {
        isNameValid = false;
    }
    makeButtonDisable();
}

function validAge(){
    alert("go2");
    var age = document.getElementById("age").value;
    isAgeValid = (age > 3 && age < 150);
    makeButtonDisable();
}

function validPhoneNumber(){
    var phoneNumber = document.getElementById("phone_number").value;
    var regex = new RegExp("^\+\d{2}\(\d{3}\)\s\d{3}-\d{2}-\d{2}");
    isPhoneNumberValid = regex.test(phoneNumber);
    makeButtonDisable();
}

function makeButtonDisable(){
    if(isNameValid && isSurnameValid && isAgeValid && isPhoneNumberValid){
        document.getElementById("ok_button").disabled = false;
    }else{
        document.getElementById("ok_button").disabled = true;
    }
}