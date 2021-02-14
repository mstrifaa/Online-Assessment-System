<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
    <style>
        *{
            margin: 50px 50px 50px 50px;
            box-sizing: border-box;
            background-color: lightgoldenrodyellow;
        }
        .centreBox{
            padding-top: 50px;
            padding-left: 50px;
            padding-right: 50px;
            background-color: burlywood;
            font-size: 1.3rem;
        }
        .logout{
            float: top;
            background-color: coral;
        }
    </style>
</head>
<body>
<h3>Online Testing System</h3>
<form method="post" action="createTest.jsp" >
    <div class="logout">
         Username: <%=session.getAttribute("currentUser")%>
    </div>
<div class="centreBox">
    <input  type="submit" name="create" value="Manage Tests"/>
</div>
</form>
<form method="post" action="./homepage.jsp">
    <div class="centreBox">
        <input type="submit" name="take" value="Take a quiz"/>
    </div>

</form>
</body>
</html>

