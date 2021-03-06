<%@ page language="java" import="java.util.*" 
		 contentType="text/html; charset=utf-8"%>
<%@include file="uploadFileHelper.jsp"%>
<%request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>UploadFile</title>
		</head>
	<body>
		<%
			SingleFileUpload upload = new SingleFileUpload();
			upload.parseRequest(request);

			String fileDir = request.getRealPath("/") + "homeworkUpload\\";
			//File parent = new File("/home/web/four-in-the-morning/ROOT/four-in-the-morning/homeworkUpload/");
			File parent = new File(fileDir);
			String uploadStatus = "true";
			try {
				String newFileName = request.getParameter("fileName");
				String oldFileName = upload.getFileItem().getName();
				String[] oldFileNameSplit = oldFileName.split("\\.");
				newFileName += ("." + oldFileNameSplit[oldFileNameSplit.length - 1]);
				upload.upload(parent, newFileName);
			} catch (Exception e) {
				uploadStatus = "false";
				e.printStackTrace();
			}
			
			String detailIndex = request.getParameter("detailIndex");
			response.sendRedirect(String.format("homepage.jsp?uploadStatus=%s&detailIndex=%s", uploadStatus, detailIndex));
		%>
	</body>
</html>