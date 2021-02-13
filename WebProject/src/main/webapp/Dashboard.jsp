<%--
  Created by IntelliJ IDEA.
  User: RIFAA
  Date: 2/5/2021
  Time: 11:48 PM
  To change this template use File | Settings | File Templates.
--%>
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
            float: right;
            background-color: coral;
        }
    </style>
</head>
<body>
<h3>Online Testing System</h3>
<form method="post" action="cookieServlet" >
    <div class="logout">
        <%=session.getAttribute("currentUser")%>
    </div>
<div class="centreBox">
    <input type="submit" name="create" value="Create Test"/>
</div>
</form>
<form method="post" action="./homepage.jsp">
    <div class="centreBox">
        <input type="submit" name="take" value="Take a quiz"/>
    </div>

</form>
</body>
</html>


