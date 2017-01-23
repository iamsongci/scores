package cn.edu.zzti.soft.scores.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
@Controller
@RequestMapping("/room/")
public class RoomController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;
	@RequestMapping("home")
	public String homePage(Model model,HttpSession session) {
		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./room/home";
	}
	//功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./room/empty";
	}
}
