<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import="com.dao.*" %>
<%@ page import="com.actionForm.*" %>
<%@ page import="java.util.*" %>
<%String account = (String)session.getAttribute("Account");
	String accountType = (String)session.getAttribute("AccountType");
	if (account == null || "".equals(account)){
		response.sendRedirect("../../index.jsp");
	} 
%>
<head>
<title>�о�������ϵͳ</title>
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
.MenuBar li.back{background:url(../Images/b_slider.gif) center bottom no-repeat;width:120px;height:28px;z-index:8;position:absolute;}
.MenuBar li a{font:bold 14px arial;text-decoration:none;color:#303030;outline:none;text-align:center;top:6px;letter-spacing:0;z-index:10;display:block;float:left;height:28px;position:relative;overflow:hidden;padding:5px 20px 0 17px;font-family:"Microsoft Yahei",Arial,Helvetica,sans-serif,"΢���ź�";font-weight:normal;font-size:13px;}
.tablehead {
	font-size: 18px;
	font-weight: bold;
}
</style>
</head>

<body>

<div id="Header">
	  <ul  id="1" class="MenuBar">	 
      			<li >
					<a href="../index.jsp" style="padding: 5px 30px 0;">��ҳ</a>
				</li> 
                <span class="sep">|</span>	
				<li >
					<a href="../StudentManagement/index.jsp" style="padding: 5px 30px 0;">Ժϵѧ������</a>
				</li>
				<span class="sep">|</span>		
				<li >
					<a href="../AchievementManagement/index.jsp" style="padding: 5px 30px 0;">Ժϵ�ɼ�����</a>
				</li>
				<span class="sep">|</span>	
				<li >
					<a href="../CourseManagement/index.jsp" style="padding: 5px 30px 0;">Ժϵ�γ̹���</a>
				</li>
                <span class="sep">|</span>				
	  			<li class="current">
					<a href="../AcdemicDeanInfo/index.jsp" style="padding: 5px 30px 0;">����Ա��Ϣ����</a>
				</li>			
	 </ul>
	<br />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;��ӭ����<font color="#0000ff"><%=account%></font> &nbsp;��ǰ��ݣ�<font color="#0000ff"><%=accountType%></font>
</div>
	
</div>
<br/><br /><br /><br/>

<form id="form1" method="post" action="admin?action=deleteAcdemicDean">
<table width="600" height="180" border="1" align="center">
  <tr>
    <td colspan="4" align="center" class="tablehead">ɾ������Ա��Ϣ</td>
  </tr>
  <tr>
    <td width="82" align="center">�û���</td>
    <td width="112" align="center">����</td>
    <td width="326" align="center">Ժϵ����</td>
    <td width="52" align="center">ѡ��</td>
  </tr>
  <%
	AdminDAO dao = new AdminDAO();
	Collection coll = dao.acdemicInfoQuery();
	String aname = "";
	String pwd = "";
	String college_name = "";
	if (coll != null && !coll.isEmpty()) {
		Iterator it = coll.iterator();
		while (it.hasNext()) {
			AcdemicInfoForm form = (AcdemicInfoForm)it.next();
			aname = form.getAname();
			pwd = form.getPwd();
			college_name = form.getCollegeName();
			out.println("<tr>" + 
			    "<td align=\"center\">" + aname + "</td>" +
			    "<td align=\"center\">" + pwd + "</td>" +
			    "<td align=\"center\">" + college_name + "</td>" +
			    "<td align=\"center\">" +
			    "<input type=\"checkbox\" name=\"choose\" value=\"" + aname +"\" /></td>" +
			    "</tr>");
		}
	}
	else {
		out.println("<tr> û�н���Ա��Ϣ </tr>");
	}
	
 %>
  <tr>
    <td height="42" colspan="4" align="center"><input type="submit" name="submit" id="submit" value="ɾ��" onclick="return check(form1)"/>&nbsp;&nbsp;&nbsp;
      <input type="reset" name="reset" id="reset" value="����" /></td>
  </tr>
</table>
</form>
<script language="javascript">
	function check(form) {
		var a = document.getElementsByName("choose");
		var k = 0;
		for (var i = 0; i < a.length; i ++) {
			if (a[i].checked) {
				k = 1;
			}
		}
		if (k == 0) {
			alert("û��ѡ�н���Ա��Ϣ!");
			return false;
		}
		
	}
</script>
<script type="text/javascript" src="../../JS/flash.js"></script>
</body>
</html>