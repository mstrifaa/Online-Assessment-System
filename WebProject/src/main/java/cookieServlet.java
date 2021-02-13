import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;



public class cookieServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        //session.invalidate();
        if(request.getSession().isNew())
        {
            System.out.println("New session");
        }
        else
        {
            System.out.println("Old session");
        }
        System.out.println(request.getParameter("create"));
        if(request.getSession().isNew()) {
            //Go to Homepage
            RequestDispatcher rd0 = request.getRequestDispatcher("homepage.jsp");
            rd0.forward(request, response);
        }
        else {
            String name = session.getAttribute("currentUser").toString();
            if (!name.equals("") || name != null)
            {
                if (request.getParameter("create").equals("Manage Tests"))
                {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("addTest.jsp");
                    dispatcher.forward(request, response);
                }
//               else if (request.getRequestURI().equals(applicationContextPath + "/takeTest")) {
//                    request.getSession().setAttribute("currentExam", null);
//
//                    String exam = request.getParameter("test");
//                    request.getSession().setAttribute("exam", exam);
//
//                    System.out.println(request.getSession().getAttribute("user"));
//                    if (request.getSession().getAttribute("user") == null) {
//                        request.getRequestDispatcher("/login").forward(request,
//                                response);
//
//                    } else {
//                        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/quizDetails.jsp");
//                        dispatcher.forward(request, response);
//                    }
//                }
//            else if (request.getRequestURI().equals(applicationContextPath + "/logout"))
//            {
//                    request.getSession().invalidate();
//                    RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsps/home.jsp");
//                    dispatcher.forward(request, response);
//            }

            }
            else
            {
                response.sendRedirect("homepage.jsp");
            }
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

}