package servlet;

import dao.CourseDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SelectCourseServlet",urlPatterns = "/servlet/SelectCourseServlet")
public class SelectCourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CourseDao cd = new CourseDao();
        String stuId = request.getSession().getAttribute("stuId").toString();

        String[] couserIds = request.getParameterValues("courseId");
        String[] selectedCourses = request.getParameterValues("selectCourse");
        try {
            for (int i = 0; i < selectedCourses.length; i++) {
                if (selectedCourses[i].equals("1")) {
                    cd.setSelectedCourse(couserIds[i], stuId);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("/student/student_select_course.jsp");
            return;
        }


        response.sendRedirect(request.getHeader("Referer"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
