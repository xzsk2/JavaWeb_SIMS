<%@ page import="bean.ScoreBean" %>
<%@ page import="dao.ScoreDao" %>
<%@ page import="util.PageUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: sk308
  Date: 2018/11/28/028
  Time: 20:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生成绩</title>
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
    <h1 class="mdui-typo">学生成绩</h1>
</div>


<div class="mdui-divider"></div>

<script type="text/javascript">

    function validate(id) {
        //var form = document.forms[id];
        var score = document.getElementsByName("score")[id];
        var numPattern = /^(\d|[1-9]\d|100)(\.\d)?$/;
        //alert(score.value);
        if (numPattern.test(score.value)) {
            //form.action = "/servlet/UpdateScoreServlet";
            //form.submit();
            return true;
        } else {
            //mdui.alert("成绩输入错误！\n请输入0-100的数字，只允许有一位小数！");
            mdui.alert('请输入0-100的数字，只允许有一位小数！', '成绩输入错误！');
            //alert("成绩输入错误！\n请输入0-100的数字，只允许有一位小数！");
            return false;
        }
    }
</script>



<div class="mdui-container">

    <div class="mdui-m-t-2">
        <div class="mdui-float-left">
            <button class="mdui-textfield-icon mdui-btn mdui-btn-icon" id="searchBtn"><i class="mdui-icon material-icons">search</i></button>
        </div>
        <div class="mdui-float-right">
            <form action="${pageContext.request.contextPath}/servlet/PrintPDFServlet" method="post"
                  onsubmit="return print()">
                <button class="mdui-btn mdui-color-theme-accent mdui-ripple mdui-btn-raised" type="submit">打印为PDF
                </button>
            </form>
        </div>
        <div class="mdui-float-right mdui-m-r-2">
            <form action="${pageContext.request.contextPath}/servlet/PrintExcelServlet" method="post"
                  onsubmit="return print()">
                <button class="mdui-btn mdui-color-theme-accent mdui-ripple mdui-btn-raised" type="submit">打印为Excel
                </button>
            </form>
        </div>
    </div>



    <table border="1" align="center" class="mdui-table mdui-table-hoverable mdui-typo">
        <tr>
            <th>课程号</th>
            <th>课程名</th>
            <th>学号</th>
            <th>学生名</th>
            <th>成绩</th>
            <th>修改成绩</th>
            <th></th>
        </tr>
        <%



            ScoreDao sd = new ScoreDao();
            String teaId = session.getAttribute("teaId").toString();
            if (teaId == null) response.sendRedirect("/login.jsp");
            String courseId = request.getParameter("courseId");
            List list = sd.getScoreBycourseId(courseId);

            String searchStuId = request.getParameter("searchStuId");//搜索学生
            if(searchStuId!=null){
                for (int i = 0; i < list.size(); i++) {
                    ScoreBean scoreSearch = (ScoreBean) list.get(i);
                    if(scoreSearch.getStuId().equals(searchStuId)){
                        List<ScoreBean> listSearch = new ArrayList<>();
                        listSearch.add(scoreSearch);
                        list = listSearch;
                        break;
                    }
                }
            }

            String pageStr = request.getParameter("page");
            int currentPage = 1;
            if (pageStr != null)
                currentPage = Integer.parseInt(pageStr);
            PageUtil pageUtil = new PageUtil(10, list.size(), currentPage);
            currentPage = pageUtil.getCurrentPage();

            List currentPageList = pageUtil.getCurrentList(list);

            for (int i = 0; i < currentPageList.size(); i++) {
                ScoreBean score = (ScoreBean) currentPageList.get(i);
        %>

        <script>
            function print() {
                <%
                session.setAttribute("scoreList",list);
                %>
                return true;
            }
        </script>

        <form id="editScoreForm" onsubmit="return validate(<%=i%>)"
              action="${pageContext.request.contextPath}/servlet/UpdateScoreServlet" method="post">
            <tr>
                <td><%=score.getCourseId()%>
                </td>
                <td><%=score.getCourseName()%>
                </td>
                <td><%=score.getStuId() %>
                </td>
                  
                <td><%=score.getStuName() %>
                </td>
                  
                <td><%=score.getScore() == -1 ? "无成绩" : score.getScore()%>
                </td>
                <td>
                    <input value="<%=score.getStuId() %>" name="stuId" type="hidden">
                    <input value="<%=courseId %>" name="courseId" type="hidden">
                    <%--<label>--%>
                    <%--<input name="score" size="4">--%>
                    <%--</label>--%>
                    <div class="mdui-textfield mdui-m-a-0 mdui-p-a-0">
                        <input class="mdui-textfield-input mdui-m-a-0 mdui-p-a-0" name="score" type="text"
                               placeholder="输入分数" required/>
                    </div>
                </td>
                <td>
                    <%--<input type="submit" value="修改">--%>
                    <button class="mdui-btn mdui-color-theme-accent mdui-ripple" type="submit">修改</button>
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
                    <a href="teacher_score.jsp?courseId=<%=courseId%>&page=1">首页</a>
                    <a href="teacher_score.jsp?courseId=<%=courseId%>&page=<%=(pageUtil.getPrePage())%>">上页</a>
                    <a href="teacher_score.jsp?courseId=<%=courseId%>&page=<%=(pageUtil.getNextPage())%>">下页</a>
                    <a href="teacher_score.jsp?courseId=<%=courseId%>&page=<%=pageUtil.getPageCount()%>">末页</a>
                </div>
            </td>
        </tr>
    </table>
</div>


<div class="mdui-drawer" id="drawer">
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">account_circle</i>
            <a href="teacher_index.jsp" class="mdui-list-item-content">我的主页</a>
        </li>
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">book</i>
            <a href="teacher_course.jsp" class="mdui-list-item-content">查看课程</a>
        </li>
    </ul>
    <div class="mdui-divider"></div>
    <ul class="mdui-list">
        <li class="mdui-list-item mdui-ripple">
            <i class="mdui-list-item-icon mdui-icon material-icons">clear</i>
            <a href="${pageContext.request.contextPath}/logout.jsp" class="mdui-list-item-content">注销</a>
        </li>
    </ul>
</div>

</body>
</html>

<script>
    mdui.JQ('#searchBtn').on('click', function () {
        mdui.prompt('请输入要搜索的学生学号',
            function (value) {
                mdui.alert('你输入了：' + value + '，点击了确认按钮');
                location.href="teacher_score.jsp?courseId=<%=courseId%>&searchStuId="+value;
            }
        );
    });
</script>