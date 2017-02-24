var isNameValid = false;
var isSurnameValid = false;
var isAgeValid = false;
var isGenderValid = false;
var isPhoneNumberValid = false;

function confirmDeletion() {
    if(!confirm('Confirm user deletion')){
        event.preventDefault();
    }
}

function validSurname(){
    var surname = document.getElementById("surname").value;
    var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
    var message;
    if(regex.test(surname)){
        message = "Ok";
        isSurnameValid = true;
    }
    else {
        message = "Error! Field can take 2-20 letters";
        isSurnameValid = false;
    }
    document.getElementById("surname_valid").innerHTML = message;
}

function validName(){
    var message;
    var name = document.getElementById("name").value;
    var regex = new RegExp("^[а-яА-Я|a-zA-Z]{2,20}$");
    if(regex.test(name)){
        message = "Ок";
        isNameValid = true;
    }
    else {
        message = "Error! Field can take 2-20 letters";
        isNameValid = false;
    }
    document.getElementById("name_valid").innerHTML = message;
}

function validAge(){
    var message;
    var age = document.getElementById("age").value;
    if(age > 3 && age < 150){
        message = "Ok";
        isAgeValid = true;
    }
    else {
        message = "Error! Enter number in range 4-150";
        isAgeValid = false;
    }
    document.getElementById("age_valid").innerHTML = message;
}

function validGender(){
    var message;
    var gender = document.getElementById("gender").value;
    if(gender==="m"|| gender==="f"){
        message = "Ok";
        isGenderValid = true;
    }
    else {
        message = "Error gender is not set";
        isGenderValid = false;
    }
    document.getElementById("gender_valid").innerHTML = message;
}

function validPhoneNumber(){
    var message;
    var phoneNumber = document.getElementById("phone_number").value;
    var regex = new RegExp("^\\+\\d{12}$");
    if (regex.test(phoneNumber)){
        message = "Format is correct";
        isPhoneNumberValid = true;
    }
    else {
        message = "Error! Wrong number format. Correct example: +380123456789";
        isPhoneNumberValid = false;
    }
    document.getElementById("phone_valid").innerHTML = message;
}

function checkFields(){
    validSurname();
    validName();
    validAge();
    validGender();
    validPhoneNumber();
    if(isSurnameValid && isNameValid &&  isAgeValid && isPhoneNumberValid&&isGenderValid){
        return true;
    }else{
        event.preventDefault();
        alert("Check entered information!");
        return false;
    }
}