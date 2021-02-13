import javax.lang.model.element.NestingKind;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class takeTestController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","Rifaa023");

            PreparedStatement selectQuiz = connection.prepareStatement("select questions from quiz");

            //selectUser.setString(1, request.getSession().getAttribute("currentUser").toString());

            ResultSet rs = selectQuiz.executeQuery();

            rs.next();
            String questions = rs.getString(1);
            System.out.println(questions);

            response.getWriter().print(questions);

            System.out.println("questions sent");

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
