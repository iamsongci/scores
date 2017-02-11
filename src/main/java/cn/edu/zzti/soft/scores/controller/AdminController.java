package cn.edu.zzti.soft.scores.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.digest.Md5Crypt;
import org.apache.commons.io.IOUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.xmlbeans.impl.common.IOUtil;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.tools.ClassAndNum;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import cn.edu.zzti.soft.scores.util.ExcelUtil;
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

	@RequestMapping("claInfo/stuInfo/resetStuPsw")
	public String resetStuPsw(@RequestParam("stuID") Integer stuID, @RequestParam("claID") Integer claID, @RequestParam("message") String message, @RequestParam("claName") String claName, Model model, HttpServletResponse response)
			throws Exception {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		model.addAttribute("message", message);
		
		serviceFit.getLoginService().updatePsw(stuID, MDUtil.MD5Tools("123456"));
		return "redirect:./../stuInfo.do";
	}

	@RequestMapping("resetTeaPsw")
	public String resetTeaPsw(@RequestParam("ID") Integer ID, @RequestParam("message") String message, Model model, HttpServletResponse response)
			throws Exception {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("message", message);
		serviceFit.getLoginService().updatePsw(ID, MDUtil.MD5Tools("123456"));
		return "redirect:./teaInfo.do";
	}

	// 通知
	@RequestMapping("notify")
	public String notify(Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINNOTIFY);
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
		model.addAttribute("menuSelected1", ConfigDo.ADMINNOTIFY);
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
		model.addAttribute("menuSelected1", ConfigDo.ADMINNOTIFY);
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getNotifyService().delNotify(IDs);
		return "./admin/notify";
	}
	
	//
	@RequestMapping("delClass")
	public String delClass(@RequestParam("claID") String ID, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getAdminService().delClass(IDs);
		return "redirect:./claInfo.do";
	}

	// 课题 and 权限
	@RequestMapping("projects")
	public String projects(Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
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
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
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

	@RequestMapping("claInfo/stuInfo")
	public String stuInfo(@RequestParam("claID") String claID, @RequestParam("claName") String claName, @RequestParam("message") String message, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		model.addAttribute("message", message);
		
		
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
	public String teaInfo(@RequestParam("message") String message, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("message", message);
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

//	@RequestMapping("stuList")
//	public String stuInfo(Model model, HttpSession session) {
//		ResultDo<?> resultDo1 = serviceFit.getAdminService().getStudents();
//		ResultDo<?> resultDo2 = serviceFit.getAdminService().getClasses();
//
//		List<?> students = null;
//		List<?> classes = null;
//
//		if (resultDo1.isSuccess() && resultDo2.isSuccess()) {
//			students = (List<?>) resultDo1.getResult();
//			classes = (List<?>) resultDo2.getResult();
//			model.addAttribute("students", students);
//			model.addAttribute("classes", classes);
//		} else {
//			model.addAttribute("message", resultDo1.getMessage());
//		}
//		return "./admin/stuList";
//	}

	@RequestMapping("addClass")
	public String addClass(@RequestParam("type") boolean type, @RequestParam("grade") String grade,
			@RequestParam("classes_name") String name, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		List<Classes> classes = new ArrayList<>();
		Classes clas = new Classes();
		clas.setType(type);
		clas.setGrade(Integer.parseInt(grade));
		clas.setClasses_name(name);
		classes.add(clas);
		serviceFit.getAdminService().addClasses(classes);
		return "redirect:./claInfo.do";
	}

	@RequestMapping("claInfo/stuInfo/addStudent")
	public String addStudent(@RequestParam("noid") String noid, @RequestParam("name") String name,
			@RequestParam("claName") String claName, @RequestParam("claID") Integer claID, @RequestParam("message") String message, Model model,
			HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		model.addAttribute("message", message);
		
		List<Identity> identities = new ArrayList<>();
		Identity identity = new Identity();
		identity.setCla_id(claID);
		identity.setCla_name(claName);
		identity.setNoid(noid);
		identity.setName(name);
		identity.setRole("stu");
		identities.add(identity);
		serviceFit.getAdminService().addIdentity(identities);
		return "redirect:./../stuInfo.do";
	}

	@RequestMapping("claInfo/stuInfo/delStudent")
	public String delStudent(@RequestParam("stuID") String stuID, @RequestParam("claID") Integer claID, @RequestParam("claName") String claName, @RequestParam("message") String message, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("claID", claID);
		model.addAttribute("claName", claName);
		model.addAttribute("message", message);
		
		List<String> identities = new ArrayList<>();
		identities.add(stuID);
		serviceFit.getAdminService().delIdentity(identities);
		return "redirect:./../stuInfo.do";
	}

	@RequestMapping("addTeacher")
	public String addTeacher(@RequestParam("noid") String noid, @RequestParam("name") String name, @RequestParam("type") String type, @RequestParam("message") String message, Model model,
			HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("message", message);
		
		List<Identity> identities = new ArrayList<>();
		Identity identity = new Identity();
		identity.setNoid(noid);
		identity.setName(name);
		identity.setRole(type);
		identities.add(identity);
		serviceFit.getAdminService().addIdentity(identities);
		return "redirect:./teaInfo.do";
	}

	@RequestMapping("delTeacher")
	public String delTeacher(@RequestParam("id") String id, @RequestParam("message") String message,  Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("message", message);
		List<String> identities = new ArrayList<>();
		identities.add(id);
		serviceFit.getAdminService().delIdentity(identities);
		return "redirect:./teaInfo.do";
	}

	@RequestMapping("proDistr")
	public String proDistr(@RequestParam("proID") Integer proID, @RequestParam("teaID") Integer teaID,
			@RequestParam("teaName") String teaName, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
		serviceFit.getAdminService().upDistr(proID, teaID, teaName);
		return "redirect:./projects.do";
	}

	@RequestMapping("proAggre")
	public String proAggre(@RequestParam("proID") Integer proID, @RequestParam("teaID") Integer teaID,
			@RequestParam("teaName") String teaName, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
		serviceFit.getAdminService().upAggre(proID, teaID, teaName);
		return "redirect:./projects.do";
	}

	@RequestMapping("resetDistr")
	public String resetDistr(@RequestParam("proID") Integer proID, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
		serviceFit.getAdminService().resetDistr(proID);
		return "redirect:./projects.do";
	}

	@RequestMapping("resetAggre")
	public String resetAggre(@RequestParam("proID") Integer proID, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
		serviceFit.getAdminService().resetAggre(proID);
		return "redirect:./projects.do";
	}

	@RequestMapping("addProject")
	public String addProject(@RequestParam("proName") String proName, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMINPROJECTS);
		List<String> projects = new ArrayList<>();
		projects.add(proName);
		serviceFit.getAdminService().addProjects(projects);
		return "redirect:./projects.do";
	}
	
	@RequestMapping("upLoadTea")
	public String upLoadTea(@RequestParam("teaInfo") CommonsMultipartFile teaInfo, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		List<Identity> teachers = new ArrayList<>();
		Set<String> noids = new HashSet<>();
		
		try {
			//判断 .xls
			ExcelUtil.isXls(teaInfo.getOriginalFilename());  
			//获取工作簿
			HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(teaInfo);
			HSSFSheet sheet = null;
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				//获取sheet页
				sheet = wb.getSheetAt(i);
				if(sheet != null) {
					try {
						//添加sheet页的内容到list
						teachers.addAll(getIdentities(sheet, "tea"));
					} catch (Exception e) {
						e.printStackTrace();
						throw new Exception("sheet页: " + (i + 1) + " !  " + e.getMessage());
					}
				}
			}
			for (Identity iden : teachers) {
				noids.add(iden.getNoid());
			}
			if(noids.size() != teachers.size()) {
				throw new Exception("表单中存在重复工号!请更改后提交!");
			}
			
			ResultDo<List<Identity>> resultDo = serviceFit.getAdminService().getAllTea();
			List<Identity> existTeachers = null;
			if (resultDo.isSuccess()) {
				existTeachers = (List<Identity>) resultDo.getResult();
			} else {
				throw new Exception(resultDo.getMessage());
			}
			
			if(! hasConflict(existTeachers, teachers)) {
				serviceFit.getAdminService().addIdentity(teachers);
				model.addAttribute("message", "提交成功! 本次新增" + teachers.size() + "条数据!");
			}
		} catch (Exception e) {
			model.addAttribute("message", e.getMessage());
			e.printStackTrace();
		}
		return "redirect:./teaInfo.do";
	}
	
	
	@RequestMapping("claInfo/stuInfo/upLoadStu")
	public String upLoadStu(@RequestParam("stuInfo") CommonsMultipartFile stuInfo, @RequestParam("claName") String claName, @RequestParam("claID") Integer claID, Model model, HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.ADMININFO);
		model.addAttribute("claName", claName);
		model.addAttribute("claID", claID);
		
		List<Identity> students = new ArrayList<>();
		Set<String> noids = new HashSet<>();
		
		try {
			//判断 .xls
			ExcelUtil.isXls(stuInfo.getOriginalFilename());  
			//获取工作簿
			HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(stuInfo);
			HSSFSheet sheet = null;
			for (int i = 0; i < wb.getNumberOfSheets(); i++) {
				//获取sheet页
				sheet = wb.getSheetAt(i);
				if(sheet != null) {
					try {
						//添加sheet页的内容到list
						students.addAll(getIdentities(sheet, "stu"));
					} catch (Exception e) {
						e.printStackTrace();
						throw new Exception("sheet页: " + (i + 1) + " !  " + e.getMessage());
					}
				}
			}
			for (int i = 0; i < students.size(); i++) {
				students.get(i).setCla_id(claID);
				students.get(i).setCla_name(claName);
				students.get(i).setRole("stu");
			}
			
			for (Identity iden : students) {
				noids.add(iden.getNoid());
			}
			if(noids.size() != students.size()) {
				throw new Exception("表单中存在重复学号!请更改后提交!");
			}
			
			ResultDo<List<Identity>> resultDo = serviceFit.getAdminService().getStuByClaID("" + claID);
			List<Identity> existStudents = null;
			if (resultDo.isSuccess()) {
				existStudents = (List<Identity>) resultDo.getResult();
			} else {
				throw new Exception(resultDo.getMessage());
			}
			
			if(! hasConflict(existStudents, students)) {
				serviceFit.getAdminService().addIdentity(students);
				model.addAttribute("message", "提交成功! 本次新增" + students.size() + "条数据!");
			}
		} catch (Exception e) {
			model.addAttribute("message", e.getMessage());
			e.printStackTrace();
		}
		return "redirect:./../stuInfo.do";
	}
	
	private boolean hasConflict(List<Identity> identities1, List<Identity> identities2) throws Exception {
		for (Identity iden1 : identities1) {
			for (Identity iden2 : identities2) {
				if(iden1.getNoid().equals(iden2.getNoid())) {
					throw new Exception("数据库中已存在工号: " + iden1.getNoid() + " !请更改后提交!");
				}
			}
		}
		return false;
	}
	
	
	private List<Identity> getIdentities(HSSFSheet sheet, String type) throws Exception {
		List<Identity> identities = new ArrayList<>();
		HSSFRow row = null;
		
		for (int index = 1; index < sheet.getLastRowNum() + 1; index++) {
			row = sheet.getRow(index);
			if(row == null) {
				throw new Exception("存在空单元行: " + (index + 1) + " !  ");
			}
			try {
				Identity identity = null;
				switch (type) {
				case "tea":
					identity = getTeacher(row);
					break;
				case "stu":
					identity = getStudent(row);
					break;
				}
				if(identity != null) {
					identities.add(identity);
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("行: " + (index + 1) + " !  " + e.getMessage());
			}
		}
		return identities;
	}


	private Identity getStudent(HSSFRow row) throws Exception {
		Identity identity = new Identity();
		int i = 0;
		try {
			String noid = ExcelUtil.getStringCellValue(row.getCell(i));
			if(noid.trim() == "") {
				return null;
			}
			if(noid.trim().length() != 12) {
				throw new Exception("学号: " + noid +" !  长度错误!");
			}
			try {
				Long.parseLong(noid);
			} catch (NumberFormatException e) {
				throw new Exception("学号: " + noid +" !  应为数字!");
			}
			identity.setNoid(noid);
			i++;
			String name = ExcelUtil.getStringCellValue(row.getCell(i));
			if(name.trim().equals("")) {
				throw new Exception("姓名不能为空!");
			}
			identity.setName(name);
			return identity;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("列: " + (i + 1) + " !  " + e.getMessage() + "请更改后提交!");
		}
	}

	private Identity getTeacher(HSSFRow row) throws Exception {
		Identity identity = new Identity();
		int i = 0;
		try {
			String noid = ExcelUtil.getStringCellValue(row.getCell(i));
			if(noid.trim() == "") {
				return null;
			}
			if(noid.trim().length() != 4) {
				throw new Exception("工号: " + noid +" !  长度错误!");
			}
			try {
				Integer.parseInt(noid);
			} catch (NumberFormatException e) {
				throw new Exception("工号: " + noid +" !  应为数字!");
			}
			identity.setNoid(noid);
			i++;
			String name = ExcelUtil.getStringCellValue(row.getCell(i));
			if(name.trim().equals("")) {
				throw new Exception("姓名不能为空!");
			}
			identity.setName(name);
			i++;
			String role = ExcelUtil.getStringCellValue(row.getCell(i));
			if(! (role.trim().equals("room") || role.trim().equals("tea") || role.trim().equals("edu"))) {
				throw new Exception("类型: " + role +" 错误!");
			}
			identity.setRole(role);
			return identity;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("列: " + (i + 1) + " !  " + e.getMessage() + "请更改后提交!");
		}
	}

	
}
