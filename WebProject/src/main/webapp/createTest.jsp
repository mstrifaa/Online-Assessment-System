<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: RIFAA
  Date: 2/8/2021
  Time: 5:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%if (session.getAttribute("userName")==null){--%>
<%--    response.setContentType("text/html");--%>
<%--    //PrintWriter result = response.getWriter();--%>
<%--    out.print("You are not logged in.");--%>
<%--    response.sendRedirect("homepage.jsp");--%>
<%--}%>--%>
<html>
    <head>
        <title>Create A Test</title>

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


                #userName{
                    float: right;
                    background-color: rosybrown;
                }
                #questions, p{
                    width: 70%;
                    display: block;
                    margin: auto;
                    border: 1px solid rgb(196, 193, 193);
                    border-radius: 2rem;
                    margin-top: 1rem;
                    padding: 2rem 1rem;
                }

                button{
                    margin: auto;
                }
                .question{
                    color: black;
                    font-weight: bold;
                    margin-top: 2px;
                }
                input[type="radio"]{
                    /* display: block; */

                }

                #addQuestion{
                    margin: 1rem 40%;

                }

                #testTitle{
                    margin: auto;
                }
                .options{
                    /* display: inline; */
                }

                span{
                    display: inline-block;
                    margin-left:0.5rem;
                    color:rgb(145, 140, 140);
                    cursor: pointer;;
                }
                span:hover{
                    background-color: rgb(238, 236, 236);
                }
            </style>

        </head>
    <body>
    <div id="topPart">
        <div id="logo">
            Create a Test
        </div>
        <div id="userName">
            <%=session.getAttribute("currentUser")%>
        </div>
    </div>

    <form id="questions" method="post" >
        <label for="testTitle" style="margin: 1rem 40%;
                                          font-size: 1.2rem;
                                          font-weight: bold;">Title</label>
        <input type="text" name="testTitle" id="testTitle" class="form-control">

        <label for="testDescription" style="margin: 1rem 35%;
                                                font-size: 1.2rem;
                                                font-weight: bold;">Description of Test</label>
        <textarea id="testDescription" name="testDescription" placeholder="Add a description..." class="form-control"></textarea>

        <button type="submit" id="save" style="display: none;margin: 1rem 40%;" class="btn btn-success">Save</button>
    </form>

    <button type="button" class="btn btn-outline-primary" id="addQuestion">Add a Question</button>

    <script>
        const theTest = document.querySelector("#questions");
        const addButton = document.querySelector("#addQuestion");
        let nQuestion = 0;
        const saveButton = document.querySelector("#save");


        // ADDING A QUESTION
        addButton.addEventListener("click", function (event){

            nQuestion++;
            let question = document.createElement("div");
            question.setAttribute("id", "question"+nQuestion.toString());
            question.setAttribute("class", "question mb-3");
            question.setAttribute("style", "height: auto;");

            let text = document.createTextNode("Question");
            question.appendChild(text);

            let removeQues = document.createElement("span");
            removeQues.setAttribute("style", "background-color: rgb(235, 229, 229); font-weight: 600");
            removeQues.appendChild(document.createTextNode("X"));
            question.appendChild(removeQues);
            question.appendChild(document.createElement("br"));

            removeQues.addEventListener("click", function(e){
                let ques = this.parentNode;
                theTest.removeChild(ques);
                nQuestion--;

                if(nQuestion==0) {
                    saveButton.style.display = "none";
                }

            });

            let inputField = document.createElement("input");
            inputField.setAttribute("type", "text");
            inputField.setAttribute("name", nQuestion.toString());
            inputField.setAttribute("class", "form-control");
            inputField.setAttribute("style", "width:60%; display: inline-block;");
            question.appendChild(inputField);

            let required = true;

            let correctAnswer = document.createElement("input");
            correctAnswer.setAttribute("type", "text");
            correctAnswer.setAttribute("name", "correctAnswer");
            correctAnswer.setAttribute("class", "answer form-control");
            correctAnswer.setAttribute("style", "width:38%; display: inline-block;");
            correctAnswer.setAttribute("placeholder", "Correct Answer...");
            correctAnswer.setAttribute("required","true");
            question.appendChild(correctAnswer);
            question.appendChild(document.createElement("br"));




            //  adding OPTIONS

            const addOption = document.createElement("button");
            addOption.setAttribute("class", "btn btn-light btn-sm");

            addOption.appendChild(document.createTextNode("Add an option"));
            question.appendChild(addOption);

            addOption.addEventListener("click", function(event){
                event.preventDefault();
                console.log(event.target);
                let option = document.createElement("input");
                option.setAttribute("type", "radio");
                option.setAttribute("name", "Q"+nQuestion);
                option.setAttribute("class", "form-check-input option");
                question.insertBefore(option, addOption);

                //adding an option's value
                let optionValue = document.createElement("input");
                optionValue.setAttribute("type", "text");
                optionValue.setAttribute("style", "border:none; border-bottom: 1px solid grey")
                optionValue.setAttribute("name", "valueOfQ"+nQuestion);
                question.insertBefore(optionValue, addOption);

                optionValue.addEventListener("keyup", function(e){
                    let value = e.target.value;
                    option.setAttribute("value", value);

                });

                // removing an option
                let remove = document.createElement("span");
                remove.setAttribute("style", "background-color: rgb(235, 229, 229);")
                remove.appendChild(document.createTextNode("Remove"));
                question.insertBefore(remove, addOption);
                question.insertBefore(document.createElement("br"),addOption);

                remove.addEventListener("click", function(e){
                    let optionVal=this.previousSibling;
                    let opt= optionVal.previousSibling;
                    let node=this.parentNode;
                    let br = this.nextSibling;
                    node.removeChild(optionVal);
                    node.removeChild(opt);
                    node.removeChild(br);
                    node.removeChild(this);
                    console.log(this.parentNode);

                });


            });

            if(nQuestion>0) {
                theTest.insertBefore(question, saveButton);
                saveButton.style.display = "initial";
            }


        });


        // SAVING AND MAKING THE QUIZ FORM
        saveButton.addEventListener("click", function (event){
            event.preventDefault();

            let testTitle = document.querySelector("#testTitle").value;
            let testDesc = document.querySelector("#testDescription").value;
            //console.log(testTitle);
            let ques = document.querySelectorAll(".question");
            let answers = document.querySelectorAll(".answer");

            const quizForm = {
                title: testTitle,
                description: testDesc,
                questions:[],
                answers: []
            };
            let qs = [];
            let anss = [];

            // collecting qustions and their options
            for(let i=0; i<ques.length; i++)
            {
                let children = ques[i].children;

                let qstn = children[2].value;

                let opts = [];
                for(let j=6; j<children.length; j = j+4)
                {
                    opts.push(children[j].value);
                }

                let q = {
                    question: qstn,
                    option: opts
                };

                console.log(q);

                quizForm["questions"].push(q);
                qs.push(q);
            }

            // collecting answers
            for(let i=0; i<answers.length; i++){
                anss.push(answers[i].value);
                quizForm["answers"].push(answers[i].value);
            }
            console.log(qs);

            const qss = JSON.stringify(qs);
            const ans = JSON.stringify(anss);

            //const quiz = JSON.stringify(quizForm);

            //console.log(quiz);

            $.post('quizController',
                {
                    title: testTitle,
                    description: testDesc,
                    questions: qss,
                    answers: ans

                },

                 function(result, status){

                    $("form").css("display", "none");
                    $("#addQuestion").css("display", "none");
                    let confirmation = $("<p></p>").text(result);
                    $("body").append(confirmation);

                }
            );

        });

    </script>
    </body>
</html>
