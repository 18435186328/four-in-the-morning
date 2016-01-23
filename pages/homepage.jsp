<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@include file="MySQLHelper.jsp"%>
<%
	String userId = request.getParameter("user_id");
	String password = request.getParameter("password");
	boolean login = false;

	if (userId != null && password != null) {
		login = MySQLHelper.checkPwd(userId, password);
		if (login) {
			session.setAttribute("userId", userId);
		} else {
			out.print("wrong password");
			response.sendRedirect("index.jsp");
		}
	} else {
		userId = (String) session.getAttribute("userId");
		if (userId == null) {
			out.print("Please Login first");
			response.sendRedirect("index.jsp");
		}
	}

	String postHw = "";
	boolean isTA = false;
	isTA = MySQLHelper.isTA(userId);
	if (isTA) {
		postHw = "<a href=\"addHomework.jsp\">发布作业</a>";
	}
	
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/homepage.css">
<meta charset="UTF-8">
<title>个人主页</title>
</head>
<body>
	<p><%=postHw%></p>
	<p>你好, ${sessionScope.userId}</p>
	<p>本周作业</p>
	<table>
		<tr>
			<td>课程</td>
			<td>作业</td>
			<td>Deadline</td>
			<td>详情</td>
		</tr>
		<%
			ArrayList<MySQLHelper.HomeworkPost> postList = MySQLHelper.queryDDLHomework(userId);
			for (MySQLHelper.HomeworkPost post : postList) {
				String detail = String.format(
						//"<a href=\"homeworkdetail.jsp?course_id=%s&homework_id=%s\">详情</a>",
						"<a onclick=\"onClickChangeShow(this)\">详情</a>", post.course_id, post.homework_id);
				out.print(String.format("<tr><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>", post.course_id,
						post.homework_title, post.ddl, detail));
				out.print(String.format("<tr id=\"showOrHidden\" sytle=\"visibility: hidden\"><td>%s</td></tr>",
						post.homework_description));
			}
		%>
	</table>
	<script type="text/javascript">
		function onClickChangeShow(e) {
			document.getElementById("showOrHidden").style.visibility = "visible";
		}
	</script>
</body>
</html>