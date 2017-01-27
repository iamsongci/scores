package cn.edu.zzti.soft.scores.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;

@Controller
@RequestMapping("/room/")
public class RoomController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("home")
	public String homePage(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./room/myInfo";
		}
		
		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./room/home";
	}

	// 功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./room/empty";
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
		return "./room/myInfo";
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
	
	@RequestMapping("rooms")
	public String rooms(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./room/myInfo";
		}
		
		ResultDo<List<Room>> resultDo = serviceFit.getRoomService().getRooms();
		List<Room> rooms = null;
		if(resultDo.isSuccess()) {
			rooms = (List<Room>) resultDo.getResult();
			model.addAttribute("rooms", rooms);
		} 
		else {
			model.addAttribute("message", "查询失败");
		}
		return "./room/rooms";
	}
	
	
	@RequestMapping("delRoom")
	public String delRoom(@RequestParam("id") String id, Model model, HttpSession session) {
		serviceFit.getRoomService().delRoom(Integer.parseInt(id));
		return "redirect:./rooms.do";
	}
	
	
	@RequestMapping("upRoomNum")
	public String upRoomNum(@RequestParam("id") String id, @RequestParam("newNumber") String newNumber, Model model, HttpSession session) {
		serviceFit.getRoomService().upRoomNum(Integer.parseInt(id), Integer.parseInt(newNumber));
		return "redirect:./rooms.do";
	}
	
	@RequestMapping("addNewRoom")
	public String addNewRoom(@RequestParam("id") String id, @RequestParam("num") String num, Model model, HttpSession session) {
		serviceFit.getRoomService().addNewRoom(Integer.parseInt(id), Integer.parseInt(num));
		return "redirect:./rooms.do";
	}
	
	@RequestMapping("delAll")
	public String delAll(Model model, HttpSession session) {
		serviceFit.getRoomService().delAll();
		return "redirect:./rooms.do";
	}
	
	@RequestMapping("notify")
	public String notify(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./room/myInfo";
		}
		
		
		return "./room/notify";
	}
	
	
	@RequestMapping("distribute")
	public String distribute(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./room/myInfo";
		}
		
		
		return "./room/distribute";
	}
	
	
	

}
