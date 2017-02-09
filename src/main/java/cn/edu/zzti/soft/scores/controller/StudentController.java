package cn.edu.zzti.soft.scores.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/stu/")
public class StudentController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("home")
	public String homePage(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./student/myInfo";
		}
		
		ResultDo<?> resultDo = serviceFit.getNotifyService().getNotifiesByStu("" + identity.getId());
		List<?> notifies = null;
		if(resultDo.isSuccess()) {
			notifies = (List<?>)resultDo.getResult();
			model.addAttribute("notifies", notifies);
		}
		else {
			model.addAttribute("message", resultDo.getMessage());
		}

		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./student/home";
	}

	// 功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./student/empty";
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
		return "./student/myInfo";
	}

	@RequestMapping("myScores")
	public String myScores(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./student/myInfo";
		}
		ResultDo<List<MyScore>> resultDo = serviceFit.getStudentService().getMyScores(identity.getId());
		if (resultDo.isSuccess()) {
			model.addAttribute("scores", (List<MyScore>) resultDo.getResult());

		} else {
			model.addAttribute("message", "查询失败");
		}

		return "./student/myScores";
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
				model.addAttribute("message", "信息修改成功");
			} else {
				model.addAttribute("message", "信息修改失败");
			}
		} else {
			model.addAttribute("message", "信息修改失败");
		}
		return "redirect:./myInfo.do";
	}

	@RequestMapping("upProName")
	private String upProName(@RequestParam("index") String index, @RequestParam("newProName") String newProName,
			Model model, HttpSession session) {
		serviceFit.getStudentService().upProName(Integer.parseInt(index), newProName);
		return "redirect:./myScores.do";
	}
	
	@RequestMapping("getScore")
	public void getScore(@RequestParam("ID") Integer ID, Model model, HttpSession session, HttpServletResponse response) throws Exception{
		StringBuffer code = new StringBuffer();
		
		
		ResultDo<MyScore> resultDo = serviceFit.getStudentService().getScore(ID);
		MyScore score = null;
		if(resultDo.isSuccess()) {
			score = (MyScore)resultDo.getResult();
			code.append("<dl class='dl-horizontal'>")
				.append(getCode("课题类型", score.getPro_name()));
			if(score.getScores_status() != 2) {
				if(score.getMy_pro_name() != null)
					code.append("<dt>课题名称</dt><dd>" + score.getMy_pro_name() + "<button type='button' style='margin-left:20%' class='btn btn-primary btn-sm' data-toggle='modal' data-target='#changeMyProName' onclick='initOne('" + ID + "')' >修改我的课题名称</button></dd>");
				else
					code.append("<dt>课题名称</dt><dd>[暂无]<button type='button' style='margin-left:20%' class='btn btn-primary btn-sm' data-toggle='modal' data-target='#changeMyProName' onclick='initOne('" + ID + "')' >修改我的课题名称</button></dd>");
			}
			else {
				code.append(getCode("课题名称", score.getMy_pro_name()));
			}
			code.append(getCode("导师", score.getTea_name()))
			.append(getCode("报告状态", score.getRepStatus()))
			.append(getCode("报告地址", score.getAddress()))
			.append(getCode("平时分数", score.getUsual_score()))
			.append(getCode("课题分数", score.getProject_score()))
			.append(getCode("报告分数", score.getReport_score()))
			.append(getCode("总分数", score.getTotal_score()))
			.append(getCode("教师评语", score.getComment()));
			response.getWriter().write(code.toString());
		}
		else {
			model.addAttribute("message", "查询失败");
		}
		
	}
	
	private String getCode(String name, String value) {
		if(value == null || value.trim().equals("")) {
			return "<dt>" + name + "</dt><dd>[暂无]</dd>";
		}
		return "<dt>" + name + "</dt><dd>" + value + "</dd>";
	}
	
	private String getCode(String name, Integer value) {
		if(value == null) {
			return "<dt>" + name + "</dt><dd>[暂无]</dd>";
		}
		return "<dt>" + name + "</dt><dd>" + value + "</dd>";
	}

}
