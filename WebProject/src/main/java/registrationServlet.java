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

public class registrationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
//        String institution = request.getParameter("institution");
//        String studentId = request.getParameter("studentID");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","Rifaa023");

            //first, check that the username is not present in the db users table

            //Statement statement = connection.createStatement();

            PreparedStatement usernameTaken = connection.prepareStatement("select * from users where username=?");
            usernameTaken.setString(1, username);
            ResultSet isTaken = usernameTaken.executeQuery();

            if(isTaken.next()){

                request.setAttribute("usernameTaken", "Username already taken");
                RequestDispatcher rd2 = request.getRequestDispatcher("homepage.jsp");
                rd2.forward(request, response);

            }else{
                PreparedStatement registerUser = connection.prepareStatement("insert into users values(seq_user.nextval,?,?,?,?)");

                //registerUser.setInt(1,1);
                registerUser.setString(1, fullName);
                registerUser.setString(2, username);
                registerUser.setString(3, email);
                registerUser.setString(4, password);

                int isRegistered = registerUser.executeUpdate(); //for update statements, returns how many rows are affected
                System.out.println(isRegistered + " rows affected");


                // after registering, login the user and start the session

                HttpSession sessionR = request.getSession(); //will create a new session
                sessionR.setAttribute("currentUser",username); //check it later
                sessionR.setMaxInactiveInterval(86400);

                PreparedStatement preparedQuery = connection.prepareStatement("select id from users where username=?");
                preparedQuery.setString(1, username);
                ResultSet rs = preparedQuery.executeQuery();
                rs.next();
                int userId = rs.getInt(1);

                PreparedStatement updateLoggedIn = connection.prepareStatement("insert into loggedInUsers values(?,?)");
                updateLoggedIn.setInt(1, userId);
                updateLoggedIn.setString(2, username);
                int updateLogIn = updateLoggedIn.executeUpdate();
                response.sendRedirect("Dashboard.jsp");
            }

            connection.close();

        }catch(Exception e){
            System.err.print(e.toString());
            response.sendRedirect("homepage.jsp");

        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
