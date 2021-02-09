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

public class logoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session!=null){
            try{
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","password");
                String username = session.getAttribute("currentUser").toString();

                System.out.println(username);

                PreparedStatement selectUser = connection.prepareStatement("select userId from loggedInUsers where userName=?");
                selectUser.setString(1, username);
                ResultSet rs = selectUser.executeQuery();
                rs.next();
                int userId = rs.getInt(1);
                System.out.println(userId);

                PreparedStatement deleteSession = connection.prepareStatement("delete from loggedInUsers where userId=?");
                deleteSession.setInt(1, userId);
                //deleteSession.setInt(2,userId);
                System.out.println("after preparing statemnet...");
                int deletedSession = deleteSession.executeUpdate();

                System.out.println(deletedSession+" rows deleted");

                session.invalidate();

                connection.close();

            }catch(Exception e){
                System.out.println(e.toString());
            }
            //response.setContentType("text/html");
            response.sendRedirect("hoempage.jsp");
        }
    }
}
