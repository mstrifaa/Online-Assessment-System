import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class quizController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String questions = request.getParameter("questions");
            String answers = request.getParameter("answers");
            System.out.println(questions);


//            int i, j=0;
//            char theQuestion[]= new char[1000];
//
//            char[] quess = questions.toCharArray();
//            boolean apos = false;
//            for(i=13; i<questions.length(); i++){
//                apos=true;
//                do{
//                    theQuestion[j]=quess[i];
//                    j++;
//                }while (quess[i]!=34);
//            }

            //String ques = theQuestion.toString();  /**store this in db*/

//            i = i+11;
//            j = 0;
//            char option[] = new char[1000];
//
////            do {
////                option[j] = quess[i];
////            }while(quess[i]!=93);
////            do{
////                if(quess[i]<65 || (quess[i]>90 && quess[i]<97) || quess[i]>122)
////                    i++;
////                else{
////                    option[j] = quess[i];
////                    j++;
////                    i++;
////                }
////            } while (quess[i]!=93);
//
//
//            //take answers
//
//            char[] anss = answers.toCharArray();
//
//            String[] ans ; // put each answer in a string



//            response.setContentType("text/plain");
//            PrintWriter result = response.getWriter();
//            result.print(questions);

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","Rifaa023");

            PreparedStatement selectUser = connection.prepareStatement("select id from users where username=?");

            selectUser.setString(1, request.getSession().getAttribute("currentUser").toString());


            ResultSet rs = selectUser.executeQuery();
            rs.next();
            int userId = rs.getInt(1);

            //the questions are to be passed in JSON format
            // in an AJAX request from the students page.
            // using JavaScript, the questions are to be rendered in input fields.

            PreparedStatement quiz = connection.prepareStatement("insert into quiz values (seq_quiz.nextval, ?,?,?,?,?)");
            quiz.setString(1, title);
            quiz.setString(2, description);
            quiz.setString(3, questions);
            quiz.setString(4, answers);
            quiz.setInt(5, userId);

            int rowsInserted = quiz.executeUpdate();

            //quiz = connection.prepareStatement("select quizCode from quiz where ");

            connection.close();


        }catch (Exception e){
            System.out.println("ERROR:  " + e.toString());
            PrintWriter error = response.getWriter();
            error.print("ERROR:  " + e.toString());
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
