<%@ page import="bean.CourseBean" %>
<%@ page import="dao.CourseDao" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: sk308
  Date: 2018/11/19/019
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的课程</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mdui.css">
    <script src="${pageContext.request.contextPath}/js/mdui.js"></script>
</head>

<body class="mdui-appbar-with-toolbar mdui-theme-primary-indigo mdui-theme-accent-pink mdui-loaded mdui-drawer-body-left">
<header class="mdui-appbar mdui-appbar-fixed">
    <div class="mdui-toolbar mdui-color-theme">
        <span mdui-drawer="{target: '#drawer', swipe: true}"
              class="mdui-btn mdui-btn-icon mdui-ripple mdui-ripple-white"><i class="mdui-icon material-icons">menu</i></span>
        <span class="mdui-typo-title">学生信息管理系统</span>
        <div class="mdui-toolbar-spacer"></div>

        <a href="javascript:;" class="mdui-btn mdui-btn-icon"><i class="mdui-icon material-icons">more_vert</i></a>
    </div>
</header>

<div class="mdui-text-left mdui-m-l-2">
    <h1 class="mdui-typo">我的课程</h1>
</div>
<div class="mdui-divider"></div>

<div class="mdui-m-a-5">
    <table border="1" align="center" class="mdui-table mdui-table-hoverable mdui-typo">
        <tr>
            <th>课程编号</th>
            <th>课程名</th>
            <th>学分</th>
            <th>教师</th>
        </tr>
        <%
            CourseDao cd = new CourseDao();
            String stuId = session.getAttribute("stuId").toString();
            List list = cd.getCourseBystuId(stuId);

            for (int i = 0; i < list.size(); i++) {
                CourseBean course = (CourseBean) list.get(i);
        %>
                
        <tr>
                        
            <td><%=course.getCourseId() %>
            </td>
                        
            <td><%=course.getName() %>
            </td>
                        
            <td><%=course.getCredit() %>
            </td>
                        
            <td><%=course.getTeaName() %>
            </td>
                    
        </tr>
        <%
            }
        %>
    </table>
</div>

<div class="mdui-drawer" id="drawer">
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">account_circle</i>
            <a href="student_index.jsp" class="mdui-list-item-content">我的信息</a>
        </li>
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">local_library</i>
            <a href="student_course.jsp" class="mdui-list-item-content">查看课程</a>
        </li>
        <li class="mdui-list-item mdui-ripple ">
            <i class="mdui-list-item-icon mdui-icon material-icons">book</i>
            <a href="student_score.jsp" class="mdui-list-item-content">查看成绩</a>
        </li>
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">library_add</i>
            <a href="student_select_course.jsp" class="mdui-list-item-content">选课</a>
        </li>
    </ul>
    <div class="mdui-divider"></div>
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">cancel</i>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="mdui-list-item-content">注销</a>
        </li>
    </ul>
</div>
</body>
</html>
