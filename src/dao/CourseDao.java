package dao;

import bean.CourseBean;
import util.DBUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class CourseDao {

    //根据教工号查询对应课程
    public List getCourseByteaId(String teaId){
        List<CourseBean> courseList = new ArrayList<>();
        Connection conn = DBUtil.getConn();
        Statement state = null;
        ResultSet rs = null;
        try{
            String sql = "select * from course where teaId='"+teaId+"'";
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()){
                CourseBean course = new CourseBean();
                course.setCourseId(rs.getString("courseId"));
                course.setCredit(rs.getFloat("credit"));
                course.setName(rs.getString("courseName"));
                course.setTeaId(rs.getString("teaId"));
                courseList.add(course);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs, state, conn);
        }
        return courseList;
    }

    //根据学号查询对应课程
    public List getCourseBystuId(String stuId){
        List<CourseBean> courseList = new ArrayList<>();
        Connection conn = DBUtil.getConn();
        Statement state = null;
        ResultSet rs = null;
        try{
            String sql = "select course.courseId,course.credit,course.courseName,teacher.teaName,course.teaId " +
                    "from course,score,teacher " +
                    "where course.courseId=score.courseId and course.teaId=teacher.teaId and score.stuId='"+stuId+"'";
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()){
                CourseBean courseTmp = new CourseBean();
                courseTmp.setCourseId(rs.getString("courseId"));
                courseTmp.setCredit(rs.getFloat("credit"));
                courseTmp.setName(rs.getString("courseName"));
                courseTmp.setTeaId(rs.getString("teaId"));
                courseTmp.setTeaName(rs.getString("teaName"));
                courseList.add(courseTmp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs, state, conn);
        }
        return courseList;
    }

    //查询所有未选课程
    public List getAllCourseNotSelected(String stuId){
        List<CourseBean> courseList = new ArrayList<>();
        Connection conn = DBUtil.getConn();
        Statement state = null;
        ResultSet rs = null;
        try{
            String sql = "select distinct course.*,teacher.teaName " +
                    "from course,teacher " +
                    "where course.courseId " +
                    "not in (select distinct course.courseId from course,teacher,score where course.teaId=teacher.teaId and score.stuId='"+stuId+"' and score.courseId=course.courseId) " +
                    "and course.teaId=teacher.teaId";
            //System.out.println(stuId);
            //System.out.println(sql);
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()) {
                CourseBean courseTmp = new CourseBean();
                courseTmp.setCourseId(rs.getString("courseId"));
                courseTmp.setCredit(rs.getFloat("credit"));
                courseTmp.setName(rs.getString("courseName"));
                courseTmp.setTeaId(rs.getString("teaId"));
                courseTmp.setTeaName(rs.getString("teaName"));
                courseList.add(courseTmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs, state, conn);
        }
        return courseList;
    }

    //根据课程号和学号选课
    public void setSelectedCourse(String courseId,String stuId){
        Connection conn = DBUtil.getConn();
        Statement state = null;
        String sql ="insert into score (courseId,stuId) values ('"+courseId+"','"+stuId+"')";
        //System.out.println(sql);
        try{
            state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(state, conn);
        }
    }

    //查询所有未选课程
    public List getAllCourse(){
        List<CourseBean> courseList = new ArrayList<>();
        Connection conn = DBUtil.getConn();
        Statement state = null;
        ResultSet rs = null;
        try{
            String sql = "select course.*,teacher.teaName " +
                    "from course,teacher " +
                    "where course.teaId = teacher.teaId ";
            //System.out.println(stuId);
            //System.out.println(sql);
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()) {
                CourseBean courseTmp = new CourseBean();
                courseTmp.setCourseId(rs.getString("courseId"));
                courseTmp.setCredit(rs.getFloat("credit"));
                courseTmp.setName(rs.getString("courseName"));
                courseTmp.setTeaId(rs.getString("teaId"));
                courseTmp.setTeaName(rs.getString("teaName"));
                courseList.add(courseTmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs, state, conn);
        }
        return courseList;
    }

    public CourseBean getCourseByCourseId(String courseId){
        CourseBean course = new CourseBean();
        Connection conn = DBUtil.getConn();
        Statement state = null;
        ResultSet rs = null;
        try{
            String sql = "select course.*,teacher.teaName from course,teacher where courseId='"+courseId+"' and teacher.teaId=course.teaId";
            state = conn.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()){
                course.setCourseId(rs.getString("courseId"));
                course.setCredit(rs.getFloat("credit"));
                course.setName(rs.getString("courseName"));
                course.setTeaId(rs.getString("teaId"));
                course.setTeaName(rs.getString("teaName"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(rs, state, conn);
        }
        return course;
    }

    //根据课程号和学号选课
    public void updateCourse(CourseBean course){
        Connection conn = DBUtil.getConn();
        Statement state = null;
        String sql ="update course " +
                "set courseName='"+course.getCourseName()+"'," +
                "credit='"+course.getCredit()+"',"+
                "teaId='"+course.getTeaId()+"'"+
                " where courseId='" + course.getCourseId() + "'";
        //System.out.println(sql);
        try{
            state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(state, conn);
        }
    }

    public void deleteCourse(String courseId){
        Connection conn = DBUtil.getConn();
        Statement state = null;
        String sql = "delete from course where courseId='"+courseId+"'";
        //System.out.println(sql);
        try{
            state = conn.createStatement();
            state.executeUpdate(sql);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(state, conn);
        }
    }

    public boolean insertCourse(CourseBean course){
        boolean isDone=false;
        Connection conn = DBUtil.getConn();
        Statement state = null;

        String sql = "insert into course" +
                "(courseId,courseName,credit,teaId)" +
                "values ('"+course.getCourseId()+"','"+course.getCourseName()+"','"+course.getCredit()+"','"+course.getTeaId()+"')";
        //System.out.println(sql);
        try{
            state = conn.createStatement();
            state.executeUpdate(sql);
            isDone=true;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(state, conn);
        }
        //System.out.println(isDone);
        return isDone;
    }
}
