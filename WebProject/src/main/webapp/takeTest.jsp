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
        #topPart{
            background-color:rebeccapurple;
        }
        #logo, #userName{
            display: inline-block;
            height: 50px;
            margin: 1rem;
        }
        #logo{
            background-color: salmon;
            font-size: 1.3rem;
            color: white;
        }
        /*div{*/
        /*    font-weight: 600;*/
        /*}*/

        b{
            font-size: 1.3rem;
        }

        #userName{
            float: right;
            background-color: rosybrown;
        }
        #test, #quizCode{
            width: 70%;
            display: block;
            margin: auto;
            border: 1px solid rgb(196, 193, 193);
            border-radius: 2rem;
            margin-top: 1rem;
            padding: 2rem 1rem;
        }

        #test{
            display: none;
        }

        button{
            margin: 1rem 40%;
        }

        input{
            margin-right: 0.5rem;
        }

        #title{
            font-weight: bold;
            width: fit-content;
            font-size: 1.3rem;
        }


    </style>

</head>
<body>
<div id="topPart">
    <div id="logo">
        Take a Test
    </div>
    <div id="userName">
        <%=session.getAttribute("currentUser")%>
    </div>
</div>

<form id="quizCode">
    <input type="text" name="quizCode" placeholder="Enter Quiz Code..." class="form-control">
    <button type="submit" class="btn btn-success" id="code">Submit</button>
</form>

<form id="test" action= "./takeTestController">
    <button type="submit" id="submit" class="btn btn-success"> Submit </button>
</form>

<script>
    $("#code").click(function (e){
        e.preventDefault();
        let quizCode = $("input").val();
        $.post("takeTestController",
            {
                quizCode:quizCode
            },
            function (result,status){
                $("#quizCode").css("display", "none");

                let submitBtn = $("#submit");
                let res = JSON.parse(result);


                let title = res.title;

                let t = $("<p>");
                t.attr("id", "title");
                t.html(title+ "<br>")
                submitBtn.before(t);

                let desc = res.description;
                let description = $("<p>");
                description.attr("id", "description");
                description.html(desc+ "<br>")
                submitBtn.before(description);

                let quess = res.questions;

                for(let i=0; i<quess.length; i++){
                    let question = quess[i].question;
                    let options = quess[i].options;

                    let quesDiv = $("<div>");
                    quesDiv.attr("class", "question");
                    quesDiv.html("<b>Question<b> " + i+1+"<br><br>");
                    quesDiv.append(question);
                    quesDiv.append($("<br>"));

                    for(let j=0; j<options.length; j++){
                        let opt = document.createElement("input");
                        opt.setAttribute("type", "radio");
                        opt.setAttribute("value", options[j]);
                        opt.setAttribute("name", "question"+i);
                        opt.setAttribute("class", "form-check-input");
                        quesDiv.append(opt);
                        quesDiv.append(document.createTextNode(options[j]));
                        quesDiv.append($("<br>"));
                    }

                    quesDiv.append($("<br>"));

                    submitBtn.before(quesDiv);

                }

                $("#test").css("display", "block");

            }
        );
    });
</script>

</body>
</html>
