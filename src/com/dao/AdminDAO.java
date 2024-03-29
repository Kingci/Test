package com.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import com.actionForm.AcdemicDeanForm;
import com.actionForm.AcdemicInfoForm;
import com.actionForm.AdminModifyPwdForm;
import com.actionForm.CourseForm;
import com.actionForm.DepartmentForm;
import com.actionForm.DepartmentStudentCourseForm;
import com.actionForm.ShowGradesForm;
import com.actionForm.StudentForm;
import com.core.ConnDB;

public class AdminDAO {
	ConnDB conn = new ConnDB();
	
	public Collection acdemicInfoQuery() {
		String sql = "select tb_account.aname, tb_account.pwd, tb_college_info.college_name " +
				"from tb_account,tb_college_info where atype = 'Acdemic Dean'" +
				" and tb_account.aname= tb_college_info.college_id";
		ResultSet rs = conn.executeQuery(sql);
		Collection coll = new ArrayList();
		AcdemicInfoForm form = null;

			try {
				while (rs.next()) {
					form = new AcdemicInfoForm();
					form.setAname(rs.getString(1));
					form.setPwd(rs.getString(2));
					form.setCollegeName(rs.getString(3));
					coll.add(form);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
		return coll;
	}
	
	public int modifyPwd(AdminModifyPwdForm form) {
		String sql = "update tb_account set pwd='" + form.getNewPwd() + "' where aname='" +
				 form.getAccount() + "' and atype = 'Administrator'";
		System.out.println("sql is " + sql);
		int rs = conn.executeUpdate(sql);
		return rs;
	}
	
	public String getPwd(String account) {
		String sql = "select pwd from tb_account where aname='" + account + "' and atype= 'Administrator'";
		System.out.println(sql);
		ResultSet rs = conn.executeQuery(sql);
		String pwd = "";
		try {
			while(rs.next()) {
				pwd = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(pwd);
		return pwd;
	}
	
	public int addAcdemicDean(AcdemicDeanForm form) throws SQLException {
		String sql = "select * from tb_account where aname='" + form.getUser() + "' and atype= 'Acdemic Dean'";
		System.out.println(sql);
		ResultSet rs = conn.executeQuery(sql);
		if (rs.first()) {
			return -1;
		}
		else {
			String sql1 = "insert into tb_account(aname, pwd, atype) values ('" + form.getUser() +
				"','" + form.getPwd() + "','Acdemic Dean')"; 
			System.out.println(sql1);
			int rs1 = conn.executeUpdate(sql1);
			if (rs1 != 0) {
				String sql2 = "insert into tb_college_info(college_id, college_name) values ('" +
						form.getUser() + "','" + form.getCollegeName() + "')";
				System.out.println(sql2);
				int rs2 = conn.executeUpdate(sql2);
				if (rs2 != 0) {
					return 1;
				}
				else {
					System.out.println("rs2 is error");
					return 0;
				}
			}
			else {
				System.out.println("rs1 is error");
				return 0;
			}
		}
	}

	public int deleteAcdemicDean(String account) throws SQLException {
		String sql1 = "delete from tb_account where aname = '" + account + "'";
		int rs1 = conn.executeUpdate(sql1);
		if (rs1 != 0) {
			String sql2 = "delete from tb_college_info where college_id = " + account;
			System.out.println(sql2);
			int rs2 = conn.executeUpdate(sql2);
			if (rs2 != 0) {
				return 1;
			}
			else {
				System.out.println("rs2 is error");
				return 0;
			}
		}
		else {
			System.out.println("rs1 is error");
			return 0;
		}
	}
	
	public ArrayList<String> collegeQuery() {
		ArrayList<String> coll = new ArrayList<String>();
		String sql = "select college_name from tb_college_info";
		ResultSet rs = conn.executeQuery(sql);
		try {
			while (rs.next()) {
				coll.add(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return coll;
	}
	
	public ArrayList<String> entryTimeQuery() {
		ArrayList<String> coll = new ArrayList<String>();
		String sql = "select distinct entr_time from tb_student";
		ResultSet rs = conn.executeQuery(sql);
		try {
			while(rs.next()) {
				coll.add(rs.getString(1));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return coll;
	}
	
	public ArrayList<StudentForm> queryStudentInfo(String college_name, String entr_time) {
		ArrayList<StudentForm> array = new ArrayList<StudentForm>();
		String sql = "select * from tb_student where college_num='" + college_name + "' and " +
				"entr_time='" + entr_time + "'";
		ResultSet rs = conn.executeQuery(sql);
		try {
			while(rs.next()) {
				StudentForm form = new StudentForm();
				form.setStuId(rs.getInt(1));
				form.setStuNum(rs.getString(2));
				form.setNameCh(rs.getString(3));
				form.setNameEn(rs.getString(4));
				form.setBirthTime(rs.getString(5));
				form.setGender(rs.getString(6));
				form.setCollegeNum(rs.getString(7));
				form.setMajorNum(rs.getString(8));
				form.setSchLength(rs.getString(9));
				form.setIdNum(rs.getString(10));
				form.setEntrTime(rs.getString(11));
				form.setStuStatus(rs.getString(12));
				form.setGraduSch(rs.getString(13));
				form.setEmail(rs.getString(14));
				form.setTelephone(rs.getString(15));
				form.setHomeAddr(rs.getString(16));
				form.setPosCode(rs.getString(17));
				form.setCitizenship(rs.getString(18));
				form.setNation(rs.getString(19));
				array.add(form);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return array;
	}
	
	public Collection queryCourse(){
		String sql = null;
		sql="select * from tb_course_info";
		System.out.println("查询课程的SQL：" + sql);
		ResultSet rs=conn.executeQuery(sql);
		Collection coll=new ArrayList();
		CourseForm courseForm=null;
		try {
			while (rs.next()) {
				courseForm=new CourseForm();
				courseForm.setId(rs.getInt(1));       
				courseForm.setNameC(rs.getString(2));
			    courseForm.setNameE(rs.getString(3));
			    courseForm.setCredit(rs.getFloat(4));
			    courseForm.setWeekHour(rs.getInt(5));
			    courseForm.setSemester(rs.getString(6));
			    courseForm.setTeacherMode(rs.getString(7));
			    courseForm.setCollegeId(rs.getInt(8));
			    courseForm.setYear(rs.getString(9));
		        coll.add(courseForm);
			}
		} catch (SQLException ex) {
			System.out.println(ex.getMessage());
		}
		conn.close();
		return coll;
	}
	
	public int insertCourse(CourseForm courseForm){
		int flag = 0;
		String sql = "select * from tb_course_info where course_id =" + courseForm.getId();
		ResultSet rs = conn.executeQuery(sql);
		try{
			if(rs.next())
				flag = 2;
			else{
				sql = "insert into tb_course_info (course_id, course_name_chs, course_name_egh,"+
						"credit, week_hour, semester, teach_mode, college_id,course_year) values"+
						"(" +courseForm.getId()+","+courseForm.getNameC()+","+courseForm.getNameE()+
						","+courseForm.getCredit()+","+courseForm.getWeekHour()+","+courseForm.getSemester()+
						","+courseForm.getTeacherMode()+","+courseForm.getCollegeId()+","+courseForm.getYear()+")";
				System.out.println("添加课程的SQL：" + sql);
				flag = conn.executeUpdate(sql);
			}
		}
		catch(SQLException e){
			flag = 0;
		}
		conn.close();
		return flag;
	}
	
	public Collection queryStudentCourse(){//search student course info
		DepartmentStudentCourseForm departmentStudentCourseForm=null;
		Collection courseColl=new ArrayList();
		String sql="";
		sql="select student_id,name_ch,tb_student_course_info.course_id,course_name_chs,tb_college_info.college_name "+
		    "from tb_student_course_info,tb_course_info,tb_student,tb_college_info "+
		    "where tb_student_course_info.student_id = tb_student.stu_num and tb_student_course_info.course_id = tb_course_info.course_id "+
		    "and tb_course_info.college_id = tb_college_info.college_id order by student_id,tb_student_course_info.course_id";
		System.out.println("学生选课信息查询时的SQL："+sql);
		ResultSet rs=conn.executeQuery(sql);
		try {
		    while (rs.next()) {
		    	departmentStudentCourseForm = new DepartmentStudentCourseForm();
		    	departmentStudentCourseForm.setStudentId(rs.getInt(1));
		    	departmentStudentCourseForm.setStudentName(rs.getString(2));
		    	departmentStudentCourseForm.setCourseId(rs.getInt(3));
		    	departmentStudentCourseForm.setCourseName(rs.getString(4));
		    	departmentStudentCourseForm.setCourseCollegeName(rs.getString(5));
		       
		        courseColl.add(departmentStudentCourseForm);
		    }
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		conn.close();
		return courseColl;
	}
	public Collection queryDepartment(String strif){//search course info
		DepartmentForm departmentForm=null;
		Collection departmentColl=new ArrayList();
		String sql="";
		if(strif!="all" && strif!=null && strif!=""){
		    sql="select * from tb_college_info where college_id = " + strif;
		}else{
		    sql="select * from tb_college_info order by college_id";
		}
		System.out.println("院系查询时的SQL："+sql);
		ResultSet rs=conn.executeQuery(sql);
		try {
		    while (rs.next()) {
		    	departmentForm = new DepartmentForm();
		    	departmentForm.setCollegeId(rs.getInt(1));
		    	departmentForm.setCollegeName(rs.getString(2));
		    	departmentForm.setSciArts(rs.getString(3));
		    	departmentForm.setCollegeEn(rs.getString(4));
		    	
		    	departmentColl.add(departmentForm);
		    }
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
		conn.close();
		return departmentColl;
	}
	/**
	 * 以下为成绩添加、查看、修改部分
	 * */
	/**
	 * 五种查询方式：按学号，按姓名，按年级，按课程号，按院系（院系中所有人的课程情况，以年级分组，每个年级内部以学号从大到小排序）
	 * */
	public Collection QueryGrades(String key, String stu_num, String stu_name, String entr_time, String college, String course_id) {
		Collection coll = new ArrayList();
		if(key.equals("")&&stu_num.equals("") && stu_name.equals("") && entr_time.equals("") && college.equals(""))
			return coll;
		else {
			if(!stu_num.equals("")&&key.equals("0")) {
				coll = QueryGradesByStuNum(stu_num, college);
			}
			else if(!stu_name.equals("")&&key.equals("1")) {
				coll = QueryGradesByStuName(stu_name, college);
			}
			else if(!course_id.equals("")&&key.equals("3")) {
				coll = QueryGradesByCourseID(course_id, college);
			}
			else if(!entr_time.equals("")&&key.equals("2")){
				coll = QueryGradesByEntrTime(entr_time, college);
			}
			else {
				coll = QueryGradesByCollege(college);
			}
			return coll;
		}
	}
	public Collection QueryGrades(String stu_num, String college, String course_id) {
		Collection coll = new ArrayList();
		if(stu_num.equals("") || course_id.equals("") || college.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where tb_college_info.college_id = \"" + college+ "\"" +
			" and stu_num = " + stu_num +
			" and tb_course_info.course_id = \"" + course_id + "\"" +
			" ; ";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
			return coll;
		}
	}
	private Collection QueryGradesByCollege(String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(college.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where tb_college_info.college_id = \"" + college+ "\"" +
			" ; ";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
	/**
	 * 查看学号为stu_num的同学的所有成绩
	 * */
	public Collection QueryGradesByStuNum(String stu_num, String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(stu_num.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where stu_num = " + stu_num +
			" and tb_college_info.college_id = \"" + college+ "\";";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
	/**
	 * 按照姓名查找
	 * */
	public Collection QueryGradesByStuName(String stu_name, String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(stu_name.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where name_ch = \"" + stu_name + "\"" +
			" and tb_college_info.college_id = \"" + college+ "\";";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
	/**
	 * 查看某院系年级为entr_time的同学的所有成绩
	 * */
	public Collection QueryGradesByEntrTime(String entr_time, String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(entr_time.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where entr_time = \"" + entr_time + "\"" +
			" and tb_college_info.college_id = \"" + college+ "\"" +
			" ; ";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
	/**
	 * 查看某院系课程号为course_id的同学的所有成绩
	 * */
	public Collection QueryGradesByCourseID(String course_id, String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(course_id.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, tb_course_info.course_id, course_name_chs, credit, teach_mode, score " +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where tb_course_info.course_id = \"" + course_id + "\"" +
			" and tb_college_info.college_id = \"" + college+ "\"" +
			" ; ";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCourse_id(rs.getString(5));
	  	  			form.setCourse_name(rs.getString(6));
	  	  			form.setCredit(rs.getString(7));
	  	  			form.setTeach_mode(rs.getString(8));
	  	  			form.setScore(rs.getString(9));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
	public int updateScore(ShowGradesForm form) {
		String stu_id = getStuIDByStuNum(form.getStu_num());
		 String sql = " update tb_student_course_info set score=" + form.getScore() + 
				 		" where student_id = " + stu_id + 
				 		" and course_id = " + form.getCourse_id() + " ;";
		 System.out.println(sql);
		 int rt = conn.executeUpdate(sql);
		 System.out.println(rt);
		 return rt;
	}
	public int addScore(ShowGradesForm form) {
		String stu_id = getStuIDByStuNum(form.getStu_num());
		String sql = "insert into tb_student_course_info (student_id, course_id, score)" +
		 				"values( " +
		 				stu_id + ", " +
		 				form.getCourse_id() + ", " +
		 				form.getScore() + ");";
		 System.out.println(sql);
		 int rt = conn.executeUpdate(sql);
		 System.out.println(rt);
		 return rt;
	}
	public String getStuIDByStuNum(String stu_num) {
		String stu_id = "";
		String sql = "select stu_id from tb_student where stu_num = " + stu_num;
		ResultSet rs = conn.executeQuery(sql);
		try {
  			while (rs.next()) {
  				stu_id = rs.getString(1);
            }
        } catch (SQLException e) {}
		return stu_id;
	}
	public Collection GetCredits(String entr_time, String college) {
		Collection<ShowGradesForm> coll = new ArrayList<ShowGradesForm>();
		if(entr_time.equals(""))
			return coll;
		else {
			String sql = "";
			sql = " select stu_num, name_ch, entr_time, college_num, sum(credit)" +
			" from tb_student_course_info left join tb_student " + 
			" on tb_student_course_info.student_id = tb_student.stu_id " +
			" left join tb_course_info " +
			" on tb_student_course_info.course_id = tb_course_info.course_id " +
			" left join tb_college_info " +
			" on tb_student.college_num = tb_college_info.college_name " +
			" where entr_time = \"" + entr_time + "\"" +
			" and tb_college_info.college_id = \"" + college+ "\"" +
			" and tb_student_course_info.score >= 60 " +
			" group by stu_num " +
			" ; ";
			//" where tb_student_course_info.student_id = " + stu_num;
			System.out.println(sql);
			ResultSet rs = conn.executeQuery(sql);
			ShowGradesForm form = null;
			try {
	  			while (rs.next()) {
	  				form = new ShowGradesForm();
	  	  			form.setStu_num(rs.getString(1));
	  	  			form.setStu_name(rs.getString(2));
	  	  			form.setEntr_time(rs.getString(3));
	  	  			form.setCollege(rs.getString(4));
	  	  			form.setCredit(rs.getString(5));
	  	            coll.add(form);
	            }
	        } catch (SQLException e) {}
	        return coll;
		}
	}
}
