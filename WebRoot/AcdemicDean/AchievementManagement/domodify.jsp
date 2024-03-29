<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.dao.AcdemicDAO" %>
<%@ page import="com.actionForm.ShowGradesForm" %>
<%@ page import="java.util.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<%String account = (String)session.getAttribute("Account");
	String accountType = (String)session.getAttribute("AccountType");
	if (account == null || "".equals(account)){
		response.sendRedirect("../../index.jsp");
	}
	
	String stu_num = (String)session.getAttribute("getgrade_stu_num");
	String stu_name = (String)session.getAttribute("getgrade_stu_name");
	String entr_time = (String)session.getAttribute("getgrade_entr_time");
	String college = account;//(String)session.getAttribute("getgrade_college");
	String course_id = (String)session.getAttribute("getgrade_course_id");
	
	/* Get query result by functions of AcdemicDAO */
	AcdemicDAO acdemicDAO = new AcdemicDAO();
	Collection coll = acdemicDAO.QueryGrades(stu_num, college, course_id);
%>
<head>
<title>研究生教务系统</title>
<script language="javascript">
	function check(form){
		if (form.score.value==""){
			alert("请输入该课程的分数！");
			form.score.focus();
			return false;
		}
	}
</script>
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
		<li>
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
		<li class="current">
			<a href="../AchievementManagement/index.jsp" style="padding: 5px 30px 0;">成绩管理</a>
		</li>
		<span class="sep">|</span>				
		<li>
			<a href="../Declaration/index.jsp" style="padding: 5px 30px 0;">申报系统</a>
		</li>
        <span class="sep">|</span>				
		<li>
			<a href="../Notification/index.jsp" style="padding: 5px 30px 0;">通知设置</a>
		</li>
	 </ul>
	 <br />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;欢迎您：<font color="#0000ff"><%=account%></font> &nbsp;当前身份：<font color="#0000ff"><%=accountType%></font>
</div>
<br/><br /><br /><br/>
<br/><br /><br />

<div align="center" class="content">
<form id="form1" name="form1" method="post" action="acdemicDean?action=domodify" >
<%
if(!coll.isEmpty()) {
%>
<table width="90%"  border="1" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" bordercolordark="#595AAF" bordercolorlight="#FFFFFF">
  <tr align="center" bgcolor="#CCCCCC">
    <td width="8%">学号</td>  
    <td width="8%">姓名</td>
    <td width="8%">年级</td>
    <td width="20%">院系</td>
    <td width="10%">课程编号</td>
    <td width="20%">课程名称</td>
    <td width="5%">学分</td>
   	<td width="10%">课程类型</td>
   	<td width="5%">总评</td>
    </tr>
    <%
		Iterator it = coll.iterator();
		//while(it.hasNext()) {
		ShowGradesForm obj = (ShowGradesForm)it.next();
		session.setAttribute("setgrades_stu_num", obj.getStu_num());
		session.setAttribute("setgrades_course_id", obj.getCourse_id() );
	%> 
  <tr>
    <td style="padding:5px;"><label for="stu_num" id="stu_num">&nbsp;<%=obj.getStu_num()%></label></td>
    <td style="padding:5px;"><label for="stu_name">&nbsp;<%=obj.getStu_name()%></label></td>
    <td style="padding:5px;"><label for="emtr_time">&nbsp;<%=obj.getEntr_time()%></label></td>
    <td style="padding:5px;"><label for="college">&nbsp;<%=obj.getCollege()%></label></td>
    <td style="padding:5px;"><label for="course_id" id="course_id">&nbsp;<%=obj.getCourse_id()%></label></td>
    <td style="padding:5px;"><label for="course_name">&nbsp;<%=obj.getCourse_name()%></label></td>
    <td style="padding:5px;"><label for="credit">&nbsp;<%=obj.getCredit()%></label></td>
    <td style="padding:5px;"><label for="teach_mode">&nbsp;<%=obj.getTeach_mode()%></label></td>
    <td style="padding:5px;"><label for="score"></label>&nbsp; <input name="score" type="text" id="score" value="<%=obj.getScore()%>"style="height:20px;width:auto" /></td>
    </tr>
</table>
	<p>
    	<input type="submit" name="submit" id="submit" value="修改" onclick="return check(form1)"/>
    </p>
<%
	}
	else {
%>
	<p>暂无内容！请检查输入。 </p>		
<%		
	}
%>
</form>
</div>
<script type="text/javascript" src="../../JS/flash.js"></script>
</body>
</html>