package cn.edu.zzti.soft.scores.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;

@Controller
@RequestMapping("/")
public class LoginController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("login")
	public ModelAndView login(Map<String, Object> model, @RequestParam("p") String p, @RequestParam("u") String u, HttpSession session) {
		u = u.trim();
		int num = u.length();
		String role = "index";
		ModelAndView mv = new ModelAndView();
		if (num == 4 || num == 11 || num == 12) {
			ResultDo resultDo = serviceFit.getLoginService().Login(u, p);
			if (resultDo.isSuccess()) {
				Identity identity = (Identity) resultDo.getResult();
				session.setAttribute("user", identity);
				String my_role = identity.getRole();
				if (my_role != null || my_role != "") {
					if("tea".equals(my_role)){
						ResultDo<List<Project>> resultDoPro=serviceFit.getTeacherService().getPowerById(identity.getId());
						if(resultDoPro.isSuccess()){
							session.setAttribute("power", (List<Project>)resultDoPro.getResult());
						}else{
							session.setAttribute("power", null);
						}
						
					}
					session.setAttribute("pathCode", my_role);
					role = "redirect:./" + my_role + "/home.do";
				} else {
					model.put("message", "后台数据角色有误，请与管理员联系！！");
				}

			} else {
				model.put("message", resultDo.getMessage());
			}
		} else {
			if (AdminUser.equals(u) && AdminPwd.equals(p)) {
				Identity identity = new Identity();
				identity.setName(AdminName);
				identity.setRole(AdminRole);
				session.setAttribute("user", identity);
				role = "redirect:./admin/home.do";
				session.setAttribute("pathCode", "admin");
			} else {
				model.put("message", "用户名输入格式有误");
			}

		}
		return new ModelAndView(role, model);

	}

	// 登出
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "./index";
	}

}