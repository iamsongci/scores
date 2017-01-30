package cn.edu.zzti.soft.scores.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;

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
		ResultDo<List<NumOfStuWithTea>> resultDo=serviceFit.getTeacherService().chooseTeacher();
		if(resultDo.isSuccess()){
			model.addAttribute("projectId", project_id);
			model.addAttribute("list", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./teacher/chooseTeacher";
		
	}
	
}
