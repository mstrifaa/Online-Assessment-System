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

        try{
            int quizCode = Integer.parseInt(request.getParameter("quizCode"));
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","Rifaa023");

            PreparedStatement selectQuiz = connection.prepareStatement("select quiz from quiz where quizCode=?");

            selectQuiz.setInt(1, quizCode);

            //selectUser.setString(1, request.getSession().getAttribute("currentUser").toString());

            ResultSet rs = selectQuiz.executeQuery();

            rs.next();
            String quiz = rs.getString(1);
            System.out.println(quiz);

            response.getWriter().print(quiz);

            System.out.println("questions sent");

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
