<%@ page import="dao.CourseDao" %>
<%@ page import="java.util.List" %>
<%@ page import="util.PageUtil" %>
<%@ page import="bean.CourseBean" %><%--
  Created by IntelliJ IDEA.
  User: sk308
  Date: 2018/12/10/010
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mdui.css">
    <script src="${pageContext.request.contextPath}/js/mdui.js"></script>
</head>


<script type="text/javascript">
    var buttonClicked;

    function jump(id) {
        var form = document.forms[id];
        var courseId = form.getAttributeNode("courseId");
        var state = 0;
        if (buttonClicked === 1) {
            form.action = "course_modify.jsp?courseId=" + courseId;
            state = 1;
        } else {
            form.action = "/servlet/CourseDeleteServlet?courseId=" + courseId;
            form.method = "get";

            if (confirm("确定删除？")) {
                state = 1;
            }
        }
        return state === 1;
    }
</script>

<div class="mdui-drawer" id="drawer">
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">account_circle</i>
            <a href="student_select.jsp" class="mdui-list-item-content">学生信息</a>
        </li>
    </ul>
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">person</i>
            <a href="teacher_select.jsp" class="mdui-list-item-content">教师信息</a>
        </li>
    </ul>
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">book</i>
            <a href="course_select.jsp" class="mdui-list-item-content">课程信息</a>
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
    <h1 class="mdui-typo">课程信息</h1>
</div>
<div class="mdui-divider"></div>


<div class="mdui-container">
    <table border="1" align="center" class="mdui-table mdui-table-hoverable mdui-typo">
        <tr>
            <th>课程号</th>
            <th>课程名</th>
            <th>学分</th>
            <th>教师号</th>
            <th>教师名</th>
            <th>修改</th>
            <th>删除</th>
        </tr>
        <%
            CourseDao cd = new CourseDao();
            List list = cd.getAllCourse();

            String pageStr = request.getParameter("page");
            int currentPage = 1;
            if (pageStr != null)
                currentPage = Integer.parseInt(pageStr);
            PageUtil pageUtil = new PageUtil(10, list.size(), currentPage);
            currentPage = pageUtil.getCurrentPage();

            List currentPageList = pageUtil.getCurrentList(list);

            for (int i = 0; i < currentPageList.size(); i++) {
                CourseBean course = (CourseBean) currentPageList.get(i);
        %>
        <form id="form" onsubmit="return jump(<%=i%>)" action="">
            <tr>
                  
                <td><%=course.getCourseId() %><input value=<%=course.getCourseId()%> name="courseId" type="hidden"></td>
                  
                <td><%=course.getCourseName() %>
                </td>
                  
                <td><%=course.getCredit() %>
                </td>

                <td><%=course.getTeaId() %>
                </td>

                <td><%=course.getTeaName() %>
                </td>

                <td>
                    <button onclick="buttonClicked=1" class="mdui-btn mdui-color-theme-accent mdui-ripple">修改</button>
                </td>
                <td>
                    <button onclick="buttonClicked=2" class="mdui-btn mdui-color-theme-accent mdui-ripple">删除</button>
                </td>
            </tr>
        </form>
        <%
            }
        %>
        <tr>
            <td bgcolor="#eeeeee" colspan=7>
                <div>
                    第<%=currentPage%>页/共<%=pageUtil.getPageCount()%>页
                    <a href="teacher_select.jsp?page=1">首页</a>
                    <a href="teacher_select.jsp?page=<%=(pageUtil.getPrePage())%>">上页</a>
                    <a href="teacher_select.jsp?page=<%=(pageUtil.getNextPage())%>">下页</a>
                    <a href="teacher_select.jsp?page=<%=pageUtil.getPageCount()%>">末页</a>
                </div>
            </td>
        </tr>
    </table>
    <div class="mdui-float-right mdui-icon-right mdui-m-a-2">
        <button class="mdui-btn mdui-color-theme-accent mdui-ripple" onclick="location.href='course_insert.jsp'">新增课程</button>
    </div>
</div>

</body>
</html>
