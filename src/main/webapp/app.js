
var xmlhttp = new XMLHttpRequest();

var URI ="https://avi60182adc.nw.r.appspot.com";
var BUCKET = "avi60182adc.appspot.com";
var HOME = "/homepage.html";
var KEY = "usedKEY";
var STORAGE = "https://storage.googleapis.com/avi60182adc.appspot.com/"


function processLoginInput() {
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function () {
            let roleUser;
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                roleUser = JSON.parse(xmlhttp.responseText);
                localStorage.setItem('username', username);
                localStorage.setItem('role', roleUser);
                window.location.replace(URI + HOME)
            }
        }

        username = new String(document.getElementById("username").value);
        password = new String(document.getElementById("password").value);

        var obj = JSON.stringify({
            "username": username,
            "password": password
        });

        xmlhttp.open("POST", URI + "/rest/login/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);
    }
}

function showUserInfo(){
    console.log("Loading info")
    let userID = localStorage.getItem("username");
    let receiveObj = localStorage.getItem('role');
    const imgLink = STORAGE + userID;
    console.log(imgLink)
    document.getElementById("userID").textContent = userID;
    document.getElementById("userRole").textContent = receiveObj;
    const profileImg = document.getElementById("profileImg");
    profileImg.src = imgLink;
}

function showKey(){
    let key = localStorage.getItem(KEY);
    document.getElementById("showKey").textContent = key;
}

function processInputListUser(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function () {
            let list;
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                list = JSON.parse(xmlhttp.responseText);
                localStorage.setItem(KEY, list);
                window.location.replace(URI + "/listUsers.html")
            }
        }

        let username = localStorage.getItem("username");;

        var obj = JSON.stringify({
            "username": username,
        });

        xmlhttp.open("POST", URI + "/rest/list/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);
    }
}

function processInputShowToken(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function () {
            let token;
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                token = JSON.parse(xmlhttp.responseText);
                localStorage.setItem(KEY, token);
                window.location.replace(URI + "/showToken.html")
            }
        }

        let username = localStorage.getItem("username");;

        var obj = JSON.stringify({
            "username": username,
        });

        console.log(URI + "/rest/token/");
        xmlhttp.open("POST", URI + "/rest/token/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);
    }

}

function processInputShowProfile(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function () {
            let profile;
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                profile = JSON.parse(xmlhttp.responseText);
                localStorage.setItem(KEY, profile);
                window.location.replace(URI + "/showProfile.html")
            }
        }

        let username = localStorage.getItem("username");;

        var obj = JSON.stringify({
            "username": username,
        });

        xmlhttp.open("POST", URI + "/rest/profile/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);
    }
}

function processInputHome(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI + HOME)
                localStorage.removeItem(KEY);
            }
        }
        let username = localStorage.getItem("username")
        var obj = JSON.stringify({ "username": username });
        xmlhttp.open("POST", URI + "/rest/home/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);

    }
}

function processInputLogout(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI)
                localStorage.clear();
            }
        }
        let username = localStorage.getItem("username")
        var obj = JSON.stringify({ "username": username });

        xmlhttp.open("POST", URI + "/rest/logout/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);

    }
}

function modifyUser(){
    if (xmlhttp) {

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                if(file != undefined){
                    loadImageM(file, modUserName)
                }else{
                    window.location.replace(URI + HOME)
                }
            }
        }
        let username = localStorage.getItem("username")
        modUserName = new String(document.getElementById("username").value);
        modPassword = new String(document.getElementById("psw").value);
        modEmail = new String(document.getElementById("email").value);
        modName = new String(document.getElementById("fName").value);
        modProfile = new String(document.getElementById("profile").value);
        modState = new String(document.getElementById("state").value);
        modRole = new String(document.getElementById("role").value);
        modCellPhone = new String(document.getElementById("cellPhone").value);
        if (modCellPhone == "")
            modCellPhone = "UNDEFINED";
        modFixPhone = new String(document.getElementById("fixPhone").value);
        if (modFixPhone == "")
            modFixPhone = "UNDEFINED";
        modOccupation = new String(document.getElementById("occupation").value);
        if (modOccupation == "")
            modOccupation = "UNDEFINED";
        modWorkplace = new String(document.getElementById("workplace").value);
        if (modWorkplace == "")
            modWorkplace = "UNDEFINED";
        modAddress1 = new String(document.getElementById("address1").value);
        if (modAddress1 == "")
            modAddress1 = "UNDEFINED";
        modAddress2 = new String(document.getElementById("address2").value);
        if (modAddress2 == "")
            modAddress2 = "UNDEFINED";
        modCity = new String(document.getElementById("city").value);
        if (modCity == "")
            modCity = "UNDEFINED";
        modOutCode = new String(document.getElementById("outCode").value);
        if (modOutCode == "")
            modOutCode = "UNDEFINED";
        modInCode = new String(document.getElementById("inCode").value);
        if (modInCode == "")
            modInCode = "UNDEFINED";
        modNIF = new String(document.getElementById("nif").value);
        if (modNIF == "") {
            modNIF = "UNDEFINED";
        }
        fileInput = document.getElementById("imgProfile");
        file = fileInput.files[0];
        
        var obj = JSON.stringify({
            "username": username,
            "modUsername": modUserName,
            "state": modState,
            "role": modRole,
            "email": modEmail,
            "name": modName,
            "password": modPassword,
            "profile": modProfile,
            "cellPhone": modCellPhone,
            "fixPhone": modFixPhone,
            "occupation": modOccupation,
            "workplace": modWorkplace,
            "address1": modAddress1,
            "address2": modAddress2,
            "city": modCity,
            "outCode": modOutCode,
            "inCode": modInCode,
            "NIF": modNIF,
        });

        xmlhttp.open("POST", URI + "/rest/modify/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);

    }

}

function createUser() {
    if (xmlhttp) {

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                if(file != undefined){
                    loadImageC(file, newUserName)
                }else{
                    window.location.replace(URI)
                }
            }
        }
        newUserName = new String(document.getElementById("username").value);
        newEmail = new String(document.getElementById("email").value);
        newName = new String(document.getElementById("fName").value);
        newPsw = new String(document.getElementById("psw").value)
        newConfPsw = new String(document.getElementById("confPsw").value);
        newProfile = new String(document.getElementById("profile").value);
        newCellPhone = new String(document.getElementById("cellPhone").value);
        if (newCellPhone == "")
            newCellPhone = "UNDEFINED";
        newFixPhone = new String(document.getElementById("fixPhone").value);
        if (newFixPhone == "")
            newFixPhone = "UNDEFINED";
        newOccupation = new String(document.getElementById("occupation").value);
        if (newOccupation == "")
            newOccupation = "UNDEFINED";
        newWorkplace = new String(document.getElementById("workplace").value);
        if (newWorkplace == "")
            newWorkplace = "UNDEFINED";
        newAddress1 = new String(document.getElementById("address1").value);
        if (newAddress1 == "")
            newAddress1 = "UNDEFINED";
        newAddress2 = new String(document.getElementById("address2").value);
        if (newAddress2 == "")
            newAddress2 = "UNDEFINED";
        newCity = new String(document.getElementById("city").value);
        if (newCity == "")
            newCity = "UNDEFINED";
        newOutCode = new String(document.getElementById("outCode").value);
        if (newOutCode == "")
            newOutCode = "UNDEFINED";
        newInCode = new String(document.getElementById("inCode").value);
        if (newInCode == "")
            newInCode = "UNDEFINED";
        newNIF = new String(document.getElementById("nif").value);
        if (newNIF == "")
            newNIF = "UNDEFINED";

        fileInput = document.getElementById("imgProfile");
        file = fileInput.files[0];

        var obj =   JSON.stringify({
            "username": newUserName,
            "email": newEmail,
            "name": newName,
            "pwd": newPsw,
            "confPwd": newConfPsw,
            "profile": newProfile,
            "cellPhone": newCellPhone,
            "fixPhone": newFixPhone,
            "occupation": newOccupation,
            "workplace": newWorkplace,
            "address1": newAddress1,
            "address2": newAddress2,
            "city": newCity,
            "outCode": newOutCode,
            "inCode": newInCode,
            "NIF": newNIF,
        });
      
        xmlhttp.open("POST", URI + "/rest/register/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);
    }
}

function loadImageC(file, newUserName){
    console.log("Loading profile image")
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI)
            }
        }
        xmlhttp.open("POST", "gcs/" + BUCKET + "/" + newUserName, false);
        xmlhttp.setRequestHeader("Content-Type", file.type);
        xmlhttp.send(file);
    }
}

function loadImageM(file, newUserName){
    console.log("Loading profile image")
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI + HOME)
            }
        }
        xmlhttp.open("POST", "gcs/" + BUCKET + "/" + newUserName, false);
        xmlhttp.setRequestHeader("Content-Type", file.type);
        xmlhttp.send(file);
    }
}

function processInputChangePwd(){
    if (xmlhttp) {
        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI + HOME);
            }
        }
        let username = localStorage.getItem("username")
        password = new String(document.getElementById("password").value);
        newpwd = new String(document.getElementById("newPwd").value);
        confirmation = new String(document.getElementById("confPwd").value);
        var obj = JSON.stringify({
            "username": username,
            "password": password,
            "newPwd": newpwd,
            "confNewPwd": confirmation
        });
        xmlhttp.open("POST", URI + "/rest/changePwd/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);

    }
}

function removeUser() {
    if (xmlhttp) {

        xmlhttp.onreadystatechange = function() {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                window.location.replace(URI)
                localStorage.clear();
            }
        }
        let username = localStorage.getItem("username")
        password = new String(document.getElementById("password").value);
        userRem = new String(document.getElementById("username").value);


        var obj = JSON.stringify({
            "username": username,
            "password": password,
            "userRem": userRem
        });

        xmlhttp.open("POST", URI + "/rest/remove/");
        xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        xmlhttp.send(obj);

    }
}

