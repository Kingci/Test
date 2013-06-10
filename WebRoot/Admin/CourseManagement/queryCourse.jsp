<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.actionForm.*" %>
<%
	String account = (String)session.getAttribute("Account");
	String accountType = (String)session.getAttribute("AccountType");
	if (account == null || "".equals(account)){
		response.sendRedirect("../../index.jsp");
	} 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>研究生教务系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<script type="text/javascript" src="../../JS/jquery-1.3.2.js"></script>
<link href="../../CSS/inner.css" rel="stylesheet" type="text/css" />
<style>
.MenuBar li a:hover,.MenuBar li a:active{border:none;color:#00B5F7;text-decoration:none;}
.MenuBar .sep{padding-top:13px;font-size:10px;color:#aeadad;float:left;height:20px;border-top:none;}
.MenuBar{position:relative;height:28px;float:left;}
.MenuBar .current{color:#008ace;}
.MenuBar .current a{color:#008ace;}
.MenuBar li{float:left;list-style:none;padding-bottom:11px;}
.MenuBar li.back{background:url(../../Images/b_slider.gif) center bottom no-repeat;width:120px;height:28px;z-index:8;position:absolute;}
.MenuBar li a{font:bold 14px arial;text-decoration:none;color:#303030;outline:none;text-align:center;top:6px;letter-spacing:0;z-index:10;display:block;float:left;height:28px;position:relative;overflow:hidden;padding:5px 20px 0 17px;font-family:"Microsoft Yahei",Arial,Helvetica,sans-serif,"微软雅黑";font-weight:normal;font-size:13px;}
</style>
</head>

<body>

<div id="Header">
	  <ul  id="1" class="MenuBar">	 
      	<li >
			<a href="../index.jsp" style="padding: 5px 30px 0;">首页</a>
		</li> 
	             <span class="sep">|</span>	
		<li >
			<a href="../StudentManagement/index.jsp" style="padding: 5px 30px 0;">院系学生管理</a>
		</li>
		<span class="sep">|</span>		
		<li >
			<a href="../AchievementManagement/index.jsp" style="padding: 5px 30px 0;">院系成绩管理</a>
		</li>
		<span class="sep">|</span>	
		<li class="current">
			<a href="../CourseManagement/index.jsp" style="padding: 5px 30px 0;">院系课程管理</a>
		</li>
        <span class="sep">|</span>				
		<li >
			<a href="../AcdemicDeanInfo/index.jsp" style="padding: 5px 30px 0;">教务员信息管理</a>
		</li>
	 </ul>
	<br />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;欢迎您：<font color="#0000ff"><%=account%></font> &nbsp;当前身份：<font color="#0000ff"><%=accountType%></font>
    </div>
</div>
<br/><br /><br /><br/>

<table width="716" border="1" cellpadding="0" cellspacing="1" align="center">
  <%
  	AdminDAO adminDAO = new AdminDAO();
	Collection courInfo = adminDAO.queryCourse();
	int id = -1;
	String nameC = "";
	String nameE = "";
	float credit = -1;
	int weekHour = -1;
	String semester = "";
	String teacherMode = "";
	int collegeId = -1;
	String year = "";
	String collegeName = "";
	
	if (courInfo != null && !courInfo.isEmpty()){
		out.println("<tr height='40'><td colspan='9' align='center'>可选课程</td></tr>");
		out.println("<tr height='30'><td>课程号</td><td>课程中文名</td><td>课程英文名</td><td>学分数</td><td>周学时</td><td>学期</td><td>教学形式</td><td>开设院系</td><td>学年</td></tr>");
		Iterator it = courInfo.iterator();
		while(it.hasNext()){
			CourseForm courseForm = (CourseForm)it.next();
			id = courseForm.getId();
			nameC = courseForm.getNameC();
			nameE = courseForm.getNameE();
			credit = courseForm.getCredit();
			weekHour= courseForm.getWeekHour();
			semester = courseForm.getSemester();
			teacherMode = courseForm.getTeacherMode();
			collegeId = courseForm.getCollegeId();
			year = courseForm.getYear();
			Collection departInfo = adminDAO.queryDepartment(Integer.toString(collegeId));
			if(departInfo != null && !departInfo.isEmpty()){
				Iterator itD = departInfo.iterator();
				if(itD.hasNext()){
					DepartmentForm departmentForm = (DepartmentForm)itD.next();
					collegeName = departmentForm.getCollegeName();
				}
			}
	  		out.println("<tr height='30' ><td>"+ id +"</td>");
	  		out.println("<td>"+ nameC +"</td>");
			out.println("<td>"+ nameE +"</td>");
			out.println("<td>"+ credit +"</td>");
			out.println("<td>"+ weekHour +"</td>");
			out.println("<td>"+ semester +"</td>");
			out.println("<td>"+ teacherMode +"</td>");
			out.println("<td>"+ collegeName +"</td>");
			out.println("<td>"+ year +"</td></tr>");
  		}
	}
	else 
	{
		out.println("<tr><td>当前没有课程</td></tr>");
	}
  	
  %>
  
</table>
<script type="text/javascript" src="../../JS/flash.js"></script>
</body>
</html>