package cn.edu.zzti.soft.scores.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.IdentityWithScores;
import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import cn.edu.zzti.soft.scores.util.MDUtil;

@Controller
@RequestMapping("/tea/")
public class TeacherController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("home")
	public String homePage(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./teacher/myInfo";
		}
		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./teacher/home";
	}

	// 功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./teacher/empty";
		
	}
	//查看通知信息
	@RequestMapping("notify")
	public String notify(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./teacher/myInfo";
		}
		
		ResultDo<?> resultDo = serviceFit.getNotifyService().getNotifiesByTea("" + identity.getId());
		List<?> notifies = null;
		if(resultDo.isSuccess()) {
			notifies = (List<?>)resultDo.getResult();
			model.addAttribute("notifies", notifies);
		}
		else {
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.TEANOTIFY);
		return "./teacher/notify";
	}
	//删除通知
	@RequestMapping("delNotify")
	public String delNotify(@RequestParam("ID") String ID, Model model, HttpSession session) {
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getNotifyService().delNotify(IDs);
		model.addAttribute("menuSelected1", ConfigDo.TEANOTIFY);
		return "./teacher/notify";
	}
	//创建通知
		@RequestMapping("create")
		public String create(@RequestParam("title") String title, @RequestParam("content") String content,Model model, HttpSession session) {
			Identity identity = (Identity) session.getAttribute("user");
			List<Notify> notifies = new ArrayList<>();
			Notify notify = new Notify();
			notify.setTitle(title);
			notify.setContent(content);
			notify.setOwner_name(identity.getName());
			notify.setTime(new Date(new java.util.Date().getTime()));
			notify.setToStudent(true);
			notify.setOwner_id(identity.getId());
			notifies.add(notify);
			serviceFit.getNotifyService().addNotify(notifies);
			model.addAttribute("menuSelected1", ConfigDo.TEANOTIFY);
			return "./teacher/notify";
		}
	//机房信息查看
	@RequestMapping("myMrInfo")
	public String myMrInfo(Model model, HttpSession session){
		Identity identity = (Identity) session.getAttribute("user");
		ResultDo resultDo = serviceFit.getTeacherService().myMrInfo(identity.getId());
		if (resultDo.isSuccess()) {
			model.addAttribute("list", resultDo.getResult());
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYMRINFO);
		return "./teacher/myMrInfo";
		
	}

	// 个人信息维护页面
	@RequestMapping("myInfo")
	public String myInfo(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		ResultDo resultDo = serviceFit.getLoginService().GetIdentityById(identity.getId());
		if (resultDo.isSuccess()) {
			Identity iden = (Identity) resultDo.getResult();
			session.setAttribute("user", iden);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYINFO);
		return "./teacher/myInfo";
	}

	// 修改个人信息
	@RequestMapping("upMyInfo")
	public String upMyInfo(@RequestParam("sex") boolean sex, @RequestParam("phone") String phone,
			@RequestParam("email") String email, Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (phone != null) {
			identity.setSex(sex);
			identity.setPhone(phone);
			identity.setEmail(email);
			if (serviceFit.getLoginService().UpdateInfoByKey(identity)) {
				model.addAttribute("message", "信息修改成功!");
			} else {
				model.addAttribute("message", "信息修改失败!!");
			}
		} else {
			model.addAttribute("message", "信息修改失败!!");
		}
		return "redirect:./myInfo.do";
	}
	//教师所拥有的权限列表页面
	@RequestMapping("myPower")
	public String myPower(Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "./teacher/myPower";
	}
	//组长选择导师
	@RequestMapping("chooseTeacher")
	public String chooseTeacher(@RequestParam("projectId") int project_id,Model model, 
			HttpSession session){
		ResultDo<List<NumOfStuWithTea>> resultDo=serviceFit.getTeacherService().chooseTeacher(project_id);
		model.addAttribute("projectId", project_id);
		if(resultDo.isSuccess()){
			model.addAttribute("list", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "./teacher/chooseTeacher";
		
	}
	//选择分配班级
	@RequestMapping("chooseClasses")
	public String chooseClasses(@RequestParam("projectId") int project_id,@RequestParam("teaId") int tea_id,
			Model model, HttpSession session){
		ResultDo<List<NumOfClasses>> resultDo=serviceFit.getTeacherService().chooseClasses();
		model.addAttribute("projectId", project_id);
		model.addAttribute("teaId", tea_id);
		if(resultDo.isSuccess()){
			model.addAttribute("list", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "./teacher/chooseClasses";
		
	}
	//查看某课题导师所带学生信息
	@RequestMapping("teaWithStu")
	public String teaWithStu(@RequestParam("projectId") int project_id,@RequestParam("teaId") int tea_id,
			Model model, HttpSession session){
		ResultDo<List<IdentityWithScores>> resultDo=serviceFit.getTeacherService().teaWithStu(tea_id, project_id);
		model.addAttribute("teaId", tea_id);
		model.addAttribute("projectId", project_id);
		if(resultDo.isSuccess()){
			model.addAttribute("list", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "./teacher/teaWithStu";
	}
	//删除导师与学生的分配关系
	@RequestMapping("delTeaWithStu")
	public String teaWithStu(@RequestParam("projectId") int project_id,@RequestParam("teaId") int tea_id,
			@RequestParam("scoreId") Integer score_id,Model model, HttpSession session){
		if(!serviceFit.getTeacherService().delTeaWithStu(score_id)){
			model.addAttribute("message", "取消分配失败！");
		}
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "redirect:./teaWithStu.do?projectId="+project_id+"&teaId="+tea_id;
		
	}
	//选择学生
	@RequestMapping("chooseStudent")
	public String chooseStudent(@RequestParam("projectId") int project_id,@RequestParam("teaId") int tea_id,
			@RequestParam("classId") Integer class_id,Model model, HttpSession session){
		ResultDo<List<Identity>> resultDoAll=serviceFit.getTeacherService().selectStuByClassId(class_id,null);
		ResultDo<List<Identity>> resultDo=serviceFit.getTeacherService().selectStuByClassId(class_id,project_id);
		model.addAttribute("teaId", tea_id);
		model.addAttribute("projectId", project_id);
		model.addAttribute("classId", class_id);
		if(resultDoAll.isSuccess()){
			model.addAttribute("listAll",resultDoAll.getResult());
			if(resultDo.isSuccess())
				model.addAttribute("list", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
		return "./teacher/chooseStudent";
		}
	//添加学生导师分配信息
	@RequestMapping("addTeaWithStu")
	public String addTeaWithStu(@RequestParam("projectId") Integer project_id,@RequestParam("teaId") Integer tea_id,
			@RequestParam("classId") Integer class_id,@RequestParam(value="stu_id", required=false, defaultValue="-1") Integer[] stu_id,
			Model model, HttpSession session){
		if(stu_id[0]!=-1){
			List<Project> proList = (List<Project>) session.getAttribute("power");
			ResultDo resultDo = serviceFit.getLoginService().GetIdentityById(tea_id);
			String proName=null;
			Identity identity=(Identity) resultDo.getResult();
			String teaName=identity.getName();
			for(Project pro:proList){
				if(pro.getProject_id().equals(project_id)){
					proName=pro.getProject_name();
				}
			}
			if(!serviceFit.getTeacherService().addTeaWithStu(tea_id, project_id, stu_id,teaName,proName)){
				model.addAttribute("message","分配失败！");
			}
		}
		return "redirect:./chooseStudent.do?projectId="+project_id+"&teaId="+tea_id+"&classId="+class_id;
	}
	
	//查看该课题有关的班级信息
	@RequestMapping("proClasses")
	public String proClasses(@RequestParam("projectId") Integer pro_id,
			Model model, HttpSession session){
			ResultDo<List<NumOfClasses>> resultDo=serviceFit.getTeacherService().selectClaByProId(pro_id);
			ResultDo<List<NumOfClasses>> resultDoAll=serviceFit.getTeacherService().chooseClasses();
			model.addAttribute("proId", pro_id);
			if(resultDo.isSuccess()){
				model.addAttribute("listAll", resultDoAll.getResult());
				model.addAttribute("list", resultDo.getResult());
			}else{
				model.addAttribute("message", resultDo.getMessage());
			}
			model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
			return "./teacher/proClasses";
		
	}
	//查看该课题有关的班级信息
		@RequestMapping("proStuScore")
		public String proStuScore(@RequestParam("projectId") Integer pro_id,@RequestParam("classId") Integer cla_id,
				Model model, HttpSession session){
			ResultDo<List<Identity>> resultDoAll=serviceFit.getTeacherService().selectStuByClassId(cla_id,null);
			ResultDo<List<IdentityWithScores>> resultDo=serviceFit.getTeacherService().proStuScore(cla_id, pro_id);
			model.addAttribute("claId", cla_id);
			model.addAttribute("proId", pro_id);
			if(resultDo.isSuccess()){
				model.addAttribute("listAll", resultDoAll.getResult());
				model.addAttribute("list", resultDo.getResult());
			}else{
				model.addAttribute("message", resultDo.getMessage());
			}
			model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
			return "./teacher/proStuScore";
		}
		//学生成绩修改
		@RequestMapping("updateStuScore")   
		public String updateStuScore(@RequestParam("proId") Integer pro_id,@RequestParam("claId") Integer cla_id,
				@RequestParam("score_id") int score_id,@RequestParam("usual_score") int usual_score,
				@RequestParam("pro_score") int pro_score,@RequestParam("report_score") int report_score,
				@RequestParam("scores_status") int scores_status,
				Model model, HttpSession session){
			
			if(!serviceFit.getTeacherService().updateStuScore(score_id, usual_score, pro_score, report_score,scores_status)){
				model.addAttribute("message", "成绩修改失败！");
			}
			if(pro_id<0&&cla_id<0){
				return"redirect:./myStudentScore.do";
			}else{
				model.addAttribute("menuSelected1", ConfigDo.MYPOWER);
				return "redirect:./proStuScore.do?projectId="+pro_id+"&classId="+cla_id;
			}
			
			
		}
		//查看导师所带学生信息
		@RequestMapping("myStudent")
		public String myStudent(Model model, HttpSession session){
			Identity identity = (Identity) session.getAttribute("user");
			int tea_id=identity.getId();
			ResultDo<List<IdentityWithScores>> resultDo=serviceFit.getTeacherService().myStudent(tea_id);
			model.addAttribute("teaId", tea_id);
			if(resultDo.isSuccess()){
				model.addAttribute("list", resultDo.getResult());
			}else{
				model.addAttribute("message", resultDo.getMessage());
			}
			model.addAttribute("menuSelected1", ConfigDo.MYSTUDENT);
			model.addAttribute("menuSelected2", ConfigDo.MYSTUDENTINFO);
			return "./teacher/myStudent";
		}
		//查看导师所带学生成绩信息
		@RequestMapping("myStudentScore")
		public String myStudentScore(Model model, HttpSession session){
			Identity identity = (Identity) session.getAttribute("user");
			int tea_id=identity.getId();
			ResultDo<List<IdentityWithScores>> resultDo=serviceFit.getTeacherService().myStudentScore(tea_id);
			model.addAttribute("teaId", tea_id);
			if(resultDo.isSuccess()){
				model.addAttribute("list", resultDo.getResult());
			}else{
				model.addAttribute("message", resultDo.getMessage());
			}
			model.addAttribute("menuSelected1", ConfigDo.MYSTUDENT);
			model.addAttribute("menuSelected2", ConfigDo.MYSTUDENTSCORE);
			return "./teacher/myStudentScore";
		}
		//老师进行成绩提交
		@RequestMapping("putStudentScore")
		public String putStudentScore(Model model, HttpSession session){
			Identity identity = (Identity) session.getAttribute("user");
			int tea_id=identity.getId();
			model.addAttribute("teaId", tea_id);
			if(serviceFit.getTeacherService().putStudentScore(tea_id)){
				model.addAttribute("putScoresMessage", "1");
			}else{
				model.addAttribute("putScoresMessage", "0");
			}
			return"redirect:./myStudentScore.do";
		}
		//老师进行成绩添加
		@RequestMapping("addStudentScore")
		public String putStudentScore(@RequestParam("scoreId") int score_id,@RequestParam("usual") int usual_score,
				@RequestParam("pro") int pro_score,@RequestParam("report") int report_score,
				Model model, HttpSession session){
			if(serviceFit.getTeacherService().updateStuScore(score_id, usual_score, pro_score, report_score,1)){
				model.addAttribute("putScoresMessage", 2);
			}else{
				model.addAttribute("putScoresMessage", 3);
			}
			return"redirect:./myStudentScore.do";
		}
		
		
	@RequestMapping("updatePsd")
	public String resetStuPsw(@RequestParam("psw") String psw, Model model, HttpServletResponse response, HttpSession session)
			throws Exception {
		Identity identity = (Identity) session.getAttribute("user");
		serviceFit.getLoginService().updatePsw(identity.getId(), MDUtil.MD5Tools(psw));
		return "forward:./../logout.do";
	}
//	//reportStatus修改报告状态和评语
//	@RequestMapping("reportStatus")
//	public String reportStatus(@RequestParam("comment") String comment,@RequestParam("Status") int Status,@RequestParam("score_id") int score_id,
//            Model model, HttpServletResponse response, HttpSession session)
//			throws Exception {
//		serviceFit.getTeacherService().updateRepStatus(score_id, Status, comment);
//		return"redirect:./myStudentScore.do";
//	}
		
	
	
}
