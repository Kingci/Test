<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
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
      	<span class="sep">|</span>	
		<li >
			<a href="../index.jsp" style="padding: 5px 30px 0;">首页</a>
		</li> 
        <span class="sep">|</span>	
		<li>
			<a href="../EnrolmentInfo/index.jsp" style="padding: 5px 30px 0;">学籍信息</a>
		</li>
		<span class="sep">|</span>		
		<li>
			<a href="../Elective/index.jsp" style="padding: 5px 30px 0;">选课安排</a>
		</li>
		<span class="sep">|</span>	
		<li>
			<a href="../AchievementManagement/index.jsp" style="padding: 5px 30px 0;">成绩管理</a>
		</li>
		<span class="sep">|</span>				
		<li >
			<a href="../Declaration/index.jsp" style="padding: 5px 30px 0;">申报系统</a>
		</li>
		<span class="sep">|</span>				
		<li >
			<a href="../EvalCourse/index.jsp" style="padding: 5px 30px 0;">课程评估</a>
		</li>
        <span class="sep">|</span>				
		<li class="current">
			<a href="../Notification/index.jsp" style="padding: 5px 30px 0;">通知设置</a>
		</li>
	 </ul>
	 </br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;欢迎您：<font color="#0000ff"><%=account%></font> &nbsp;当前身份：<font color="#0000ff"><%=accountType%></font>
    </div>
</div>
<br/><br /><br /><br/>
<form id="form1" method="post" action="acdemicDean?action=updateNotification">
  <%
  	AcdemicDAO acdemicDeanDAO = new AcdemicDAO();
	Collection courInfo = acdemicDeanDAO.queryNotification(account);
	int notificationId = -1;
	String authorId = "";
	int collegeId = -1;
	String title = "";
	String content = "";
	
	if (courInfo != null && !courInfo.isEmpty()){
		out.println("<table width='720' border='1' cellpadding='0' cellspacing='1' align='center'>");
		out.println("<tr><td colspan='3' align='center'>已发布通知</td></tr>");
		out.println("<tr height='40'><td width='40'>通知编号</td><td width='150'>通知标题</td><td width='530'>通知内容</td></tr>");
		Iterator it = courInfo.iterator();
		while(it.hasNext()){
			NotificationForm notificationForm = (NotificationForm)it.next();
			notificationId = notificationForm.getNotificationId();
			authorId = notificationForm.getAuthorId();
			collegeId = notificationForm.getCollegeId();
			title = notificationForm.getTitle();
			content = notificationForm.getContent();
			System.out.println(content);
	  		out.println("<tr><td>"+ notificationId +"</td>");
	  		out.println("<td>"+ title +"</td>");
			out.println("<td><textarea name='"+notificationId+"' id='"+notificationId+"' cols='45' rows='10' style='height:100px;width:'530px'>"+content+"</textarea></td></tr>");
  		}
  		out.println("<tr><td colspan='3' align='center'><input type='submit' name='update' id='update' value='修改' />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
  					"<input type='button' name='return' id='return' value='返回' onClick=\"window.location.href='index.jsp'\"/></td></tr></table>");
	}
	else 
	{
		out.println("<tr><td>没有发布通知</td></tr>");
		System.out.println("Notification is empty!");
	}
  	
  %>
<input type="hidden" name="account" value="<%=account %>"/>
</form>
<script type="text/javascript" src="../../JS/flash.js"></script>
</body>
</html>