import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("loginusername");
        request.getParameterValues("loginusername");
        String password = request.getParameter("loginpassword");


        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","Rifaa023");

            PreparedStatement verifyUser = connection.prepareStatement("select username from users where username=? and password=?");

            verifyUser.setString(1, username);
            verifyUser.setString(2, password);

            ResultSet isVerified = verifyUser.executeQuery();
            if(!isVerified.next()){
                response.getWriter().print("Username and/or password is incorrect.");
                RequestDispatcher rd1 = request.getRequestDispatcher("homepage.jsp");
                rd1.forward(request, response);

            }else {
                // login the user and start the session
                HttpSession sessionL = request.getSession(); //will create a new session
                sessionL.setAttribute("currentUser",username); //check it later
                sessionL.setMaxInactiveInterval(86400);

                PreparedStatement selectUser = connection.prepareStatement("select id from users where username=?");

                selectUser.setString(1, username);


                ResultSet rs = selectUser.executeQuery();
                rs.next();
                int userId = rs.getInt(1);
                System.out.println(userId + " rows selected");

                //insert date and time of log in also
                PreparedStatement updateLoggedIn = connection.prepareStatement("insert into loggedInUsers values(?,?)");

                updateLoggedIn.setInt(1, userId);
                updateLoggedIn.setString(2, username);
                int updateLogIn = updateLoggedIn.executeUpdate();


                request.setAttribute("toastmsg","logged in successfully");
//               response.sendRedirect("Products.jsp");

                RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
                rd.forward(request, response);
            }

            connection.close();

        }catch(Exception e){
            System.err.printf(e.toString());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
