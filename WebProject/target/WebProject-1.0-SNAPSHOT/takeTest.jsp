<%--
  Created by IntelliJ IDEA.
  User: RIFAA
  Date: 2/13/2021
  Time: 8:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Take a test</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <style>
            *{
                margin: 0px;
                box-sizing: border-box;
            }
        </style>

    </head>
    <body>
        <form id="test">
            <input type="text" name="quizCode" placeholder="Enter Quiz Code..." class="form-control">
            <button type="submit" class="btn btn-success">Submit</button>
        </form>

        <script>
            $("button").click(function (e){
                e.preventDefault();
                let quizCode = $("input").val();
                $.post("takeTestController",
                    {
                        quizCode:quizCode
                    },
                    function (result,status){
                        // let confirmation = $("<p></p>").text(result);
                        // $("body").append(confirmation);
                        let res = JSON.parse(result);
                        let test = $("#test").append($("<p></p>").html(res));
                        console.log(res[0].option);
                    }
                );
            });
        </script>

    </body>
</html>
