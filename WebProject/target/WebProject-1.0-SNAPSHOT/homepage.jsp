<%--
  Created by IntelliJ IDEA.
  User: RIFAA
  Date: 2/5/2021
  Time: 11:27 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Online Testing for Students</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


        <style>
            *{
                margin: 0px;
                box-sizing: border-box;
            }

            #firstPart{
                height: auto;
            }

            #secondPart{
                /* height: 550px; */
                background-color: greenyellow;
            }
            #logo{
                background-color: green;
            }
            #logo, #loginForm{
                display: inline-block;
                width: 49%;
                padding: 1%;
            }

            /* #registration{
                background-color: hotpink;
                height: 100%;
            } */
            #leftPart, #registration{
                display: inline-block;
                width: 49%;
                height: 100%;
            }

            .col-auto{
                margin-top: 3.5%;
            }



        </style>

        <script>
            let screenHeight = screen.availHeight;

            $(document).ready(function(){
                console.log(screenHeight);
                $("body").css("height", screenHeight);
            });
        </script>
    </head>
    <body>
    <div id="firstPart">
        <div id="logo">

        </div>

        <form id="loginForm" method="POST" action="./loginServlet">
            <div class="row">
                <div class="col">
                    <label for="loginusername">Username</label>
                    <input id="loginusername" class="form-control" type="text" name="loginusername">
                </div>

                <div class="col">
                    <label for="loginpassword">Password</label>
                    <input id="loginpassword" class="form-control" type="password" name="loginpassword"/>
                </div>

                <div class="col-auto">
                    <button id="login" type="submit" class="btn btn-primary">Log In</button>
                </div>
            </div>

        </form>
    </div>

    <div id="secondPart">
        <div id="leftPart">
            Welcome to E-test.....
        </div>

        <!-- <div id="rightPart"> -->
        <form id="registration" method="POST" action="./registrationServlet">
            <div class="row mb-3">
                <div class="col-sm-10">
                    <label for="fullName">Full Name</label>
                    <input id="fullName" type="text" name="fullName" class="form-control">
                </div>

<%--                <div class="col-sm-10">--%>
<%--                    <label for="institution">Institution</label>--%>
<%--                    <input id="institution" type="text" name="institution" class="form-control"/>--%>
<%--                </div>--%>

<%--                <div class="col-sm-10">--%>
<%--                    <label for="studentID">Student ID (Institutional Student Number) </label>--%>
<%--                    <input id="studentID" type="number" name="studentID" class="form-control">--%>
<%--                </div>--%>

                <div class="col-sm-10">
                    <label for="username"> Username</label>
                    <span style="color: grey;
                                 font-size: small;">(Username should have at least 8 characters)</span>
                    <input id="username" type="text" name="username" minlength="8" class="form-control" minlength="8">
                </div>
                <a id="userNameAvailable"
                   style="color: brown;
                                  font-size: small;
                                  text-decoration: none;"
                   href="./userAvailability">Check Availability</a>

                <div class="col-sm-10">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" class="form-control">
                </div>

                <div class="col-sm-10">
                    <label for="password">Password</label>
                    <input id="password" type="password" name="password" class="form-control">
                </div>

                <div class="col-sm-10">
                    <label for="repassw">Re-type Password</label>
                    <input id="repassw" type="password" name="repassw" class="form-control"/>
                </div>
                <span id="passMismatch" style="color: #ff0000;
                                     font-size: small;
                                     display: none;">Passwords do not match!</span>
            </div>

            <div class="col-auto">
                <button id="register" type="submit" class="btn btn-primary">Register</button>
            </div>
        </form>
        <!-- </div> -->
    </div>

    <script>
        let reg = document.querySelector("#registration");

        reg.addEventListener("submit", function(event){

            //check if passwords match

            let pass = document.getElementById("password");
            let repass = document.getElementById("repassw");
            //console.log(pass.value);

            if((pass.value) !== (repass.value)){
                document.querySelector("#passMismatch").style.display="initial";
                event.preventDefault();
                //event.stopPropagation();
            }

        });
    </script>
    </body>
</html>
