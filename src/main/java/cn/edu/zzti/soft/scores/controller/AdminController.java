package cn.edu.zzti.soft.scores.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.Md5Crypt;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.tools.ClassAndNum;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import cn.edu.zzti.soft.scores.util.MDUtil;

@Controller
@RequestMapping("/admin/")
public class AdminController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("home")
	public String homePage(Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./admin/home";
	}

	// 功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./admin/empty";
	}

	@RequestMapping("resetStuPsw")
	public String resetStuPsw(@RequestParam("stuID") Integer stuID, @RequestParam("claID") Integer claID, @RequestParam("claName") String claName, Model model, HttpServletResponse response)
			throws Exception {
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		
		serviceFit.getLoginService().updatePsw(stuID, MDUtil.MD5Tools("123456"));
		return "redirect:./stuInfo.do";
	}

	@RequestMapping("resetTeaPsw")
	public String resetTeaPsw(@RequestParam("ID") Integer ID, Model model, HttpServletResponse response)
			throws Exception {
		serviceFit.getLoginService().updatePsw(ID, MDUtil.MD5Tools("123456"));
		return "redirect:./teaInfo.do";
	}

	// 通知
	@RequestMapping("notify")
	public String notify(Model model, HttpSession session) {
		ResultDo<?> resultDo = serviceFit.getNotifyService().getNotifies();
		List<?> notifies = null;
		if (resultDo.isSuccess()) {
			notifies = (List<?>) resultDo.getResult();
			model.addAttribute("notifies", notifies);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./admin/notify";
	}

	// 创建通知
	@RequestMapping("create")
	public String create(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("toStudent") Boolean toStudent, Model model, HttpSession session) {
		List<Notify> notifies = new ArrayList<>();
		Notify notify = new Notify();
		notify.setTitle(title);
		notify.setContent(content);
		notify.setOwner_name("super");
		notify.setTime(new Date(new java.util.Date().getTime()));
		notify.setToStudent(toStudent);
		notify.setOwner_id(0);
		notifies.add(notify);
		serviceFit.getNotifyService().addNotify(notifies);
		return "./admin/notify";
	}

	@RequestMapping("delNotify")
	public String delNotify(@RequestParam("ID") String ID, Model model, HttpSession session) {
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getNotifyService().delNotify(IDs);
		return "./admin/notify";
	}
	
	//
	@RequestMapping("delClass")
	public String delClass(@RequestParam("claID") String ID, Model model, HttpSession session) {
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getAdminService().delClass(IDs);
		return "redirect:./claInfo.do";
	}

	// 课题 and 权限
	@RequestMapping("projects")
	public String projects(Model model, HttpSession session) {
		ResultDo<?> resultDo1 = serviceFit.getAdminService().getProjects();
		ResultDo<?> resultDo2 = serviceFit.getAdminService().getTeachers();
		List<?> projects = null;
		List<?> teachers = null;
		if (resultDo1.isSuccess()) {
			projects = (List<?>) resultDo1.getResult();
			model.addAttribute("projects", projects);

			teachers = (List<?>) resultDo2.getResult();
			model.addAttribute("teachers", teachers);
		} else {
			model.addAttribute("message", resultDo1.getMessage());
		}
		return "./admin/projects";
	}

	@RequestMapping("claInfo")
	public String claInfo(Model model, HttpSession session) {
		ResultDo<List<ClassAndNum>> resultDo = serviceFit.getAdminService().getClassesAndNum();
		List<?> classes = null;
		if (resultDo.isSuccess()) {
			classes = (List<?>)resultDo.getResult();
			model.addAttribute("classes", classes);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./admin/claInfo";
	}

	@RequestMapping("stuInfo")
	public String stuInfo(@RequestParam("claID") String claID, @RequestParam("claName") String claName, Model model, HttpSession session) {
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		
		ResultDo<List<Identity>> resultDo = serviceFit.getAdminService().getStuByClaID(claID);
		List<?> students = null;
		if (resultDo.isSuccess()) {
			students = (List<?>) resultDo.getResult();
			model.addAttribute("students", students);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./admin/stuInfo";
	}

	@RequestMapping("teaInfo")
	public String teaInfo(Model model, HttpSession session) {
		ResultDo<?> resultDo = serviceFit.getAdminService().getAllTea();
		List<?> teachers = null;
		if (resultDo.isSuccess()) {
			teachers = (List<?>) resultDo.getResult();
			model.addAttribute("teachers", teachers);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./admin/teaInfo";
	}

	@RequestMapping("stuList")
	public String stuInfo(Model model, HttpSession session) {
		ResultDo<?> resultDo1 = serviceFit.getAdminService().getStudents();
		ResultDo<?> resultDo2 = serviceFit.getAdminService().getClasses();

		List<?> students = null;
		List<?> classes = null;

		if (resultDo1.isSuccess() && resultDo2.isSuccess()) {
			students = (List<?>) resultDo1.getResult();
			classes = (List<?>) resultDo2.getResult();
			model.addAttribute("students", students);
			model.addAttribute("classes", classes);
		} else {
			model.addAttribute("message", resultDo1.getMessage());
		}
		return "./admin/stuList";
	}

	@RequestMapping("addClass")
	public String addClass(@RequestParam("type") boolean type, @RequestParam("grade") String grade,
			@RequestParam("classes_name") String name, Model model, HttpSession session) {
		List<Classes> classes = new ArrayList<>();
		Classes clas = new Classes();
		clas.setType(type);
		clas.setGrade(Integer.parseInt(grade));
		clas.setClasses_name(name);
		classes.add(clas);
		serviceFit.getAdminService().addClasses(classes);
		return "redirect:./claInfo.do";
	}

	@RequestMapping("addStudent")
	public String addStudent(@RequestParam("noid") String noid, @RequestParam("name") String name,
			@RequestParam("claName") String claName, @RequestParam("claID") Integer claID, Model model,
			HttpSession session) {
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		
		List<Identity> identities = new ArrayList<>();
		Identity identity = new Identity();
		identity.setCla_id(claID);
		identity.setCla_name(claName);
		identity.setNoid(noid);
		identity.setName(name);
		identity.setRole("stu");
		identities.add(identity);
		serviceFit.getAdminService().addIdentity(identities);
		return "redirect:./stuInfo.do";
	}

	@RequestMapping("delStudent")
	public String delStudent(@RequestParam("stuID") String stuID, @RequestParam("claID") Integer claID, @RequestParam("claName") String claName, Model model, HttpSession session) {
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		List<String> identities = new ArrayList<>();
		identities.add(stuID);
		serviceFit.getAdminService().delIdentity(identities);
		return "redirect:./stuInfo.do";
	}

	@RequestMapping("addTeacher")
	public String addTeacher(@RequestParam("noid") String noid, @RequestParam("name") String name, Model model,
			HttpSession session) {
		List<Identity> identities = new ArrayList<>();
		Identity identity = new Identity();
		identity.setNoid(noid);
		identity.setName(name);
		identity.setRole("tea");
		identities.add(identity);
		serviceFit.getAdminService().addIdentity(identities);
		return "redirect:./teaInfo.do";
	}

	@RequestMapping("delTeacher")
	public String delTeacher(@RequestParam("id") String id, Model model, HttpSession session) {
		List<String> identities = new ArrayList<>();
		identities.add(id);
		serviceFit.getAdminService().delIdentity(identities);
		return "redirect:./teaInfo.do";
	}

	@RequestMapping("proDistr")
	public String proDistr(@RequestParam("proID") Integer proID, @RequestParam("teaID") Integer teaID,
			@RequestParam("teaName") String teaName, Model model, HttpSession session) {
		serviceFit.getAdminService().upDistr(proID, teaID, teaName);
		return "redirect:./projects.do";
	}

	@RequestMapping("proAggre")
	public String proAggre(@RequestParam("proID") Integer proID, @RequestParam("teaID") Integer teaID,
			@RequestParam("teaName") String teaName, Model model, HttpSession session) {
		serviceFit.getAdminService().upAggre(proID, teaID, teaName);
		return "redirect:./projects.do";
	}

	@RequestMapping("resetDistr")
	public String resetDistr(@RequestParam("proID") Integer proID, Model model, HttpSession session) {
		serviceFit.getAdminService().resetDistr(proID);
		return "redirect:./projects.do";
	}

	@RequestMapping("resetAggre")
	public String resetAggre(@RequestParam("proID") Integer proID, Model model, HttpSession session) {
		serviceFit.getAdminService().resetAggre(proID);
		return "redirect:./projects.do";
	}

	@RequestMapping("addProject")
	public String addProject(@RequestParam("proName") String proName, Model model, HttpSession session) {
		List<String> projects = new ArrayList<>();
		projects.add(proName);
		serviceFit.getAdminService().addProjects(projects);
		return "redirect:./projects.do";
	}

}
