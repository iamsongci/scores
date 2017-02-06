package cn.edu.zzti.soft.scores.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import net.sf.json.JSONArray;

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
		
		ResultDo<?> resultDo = serviceFit.getNotifyService().getNotifiesByTea("" + identity.getId());
		List<?> notifies = null;
		if(resultDo.isSuccess()) {
			notifies = (List<?>)resultDo.getResult();
			model.addAttribute("notifies", notifies);
		}
		else {
			model.addAttribute("message", resultDo.getMessage());
		}
		
		return "./room/notify";
	}
	
	//创建通知
	@RequestMapping("create")
	public String create(@RequestParam("title") String title, @RequestParam("content") String content, @RequestParam("toStudent") Boolean toStudent, Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		List<Notify> notifies = new ArrayList<>();
		Notify notify = new Notify();
		notify.setTitle(title);
		notify.setContent(content);
		notify.setOwner_name(identity.getName());
		notify.setTime(new Date(new java.util.Date().getTime()));
		notify.setToStudent(toStudent);
		notify.setOwner_id(identity.getId());
		notifies.add(notify);
		serviceFit.getNotifyService().addNotify(notifies);
		return "./room/notify";
	}
	
	@RequestMapping("delNotify")
	public String delNotify(@RequestParam("ID") String ID, Model model, HttpSession session) {
		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getNotifyService().delNotify(IDs);
		return "./room/notify";
	}
	
	
	@RequestMapping("distribute")
	public String distribute(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./room/myInfo";
		}
		
		ResultDo<?> resultDo = serviceFit.getRoomService().getDisInfo();
		List<?> tearooms = null;
		if(resultDo.isSuccess()){
			tearooms = (List<?>) resultDo.getResult();
			model.addAttribute("tearooms", tearooms);
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		
		return "./room/distribute";
	}

	@RequestMapping("delTeaRoom")
	public String delTeaRoom(@RequestParam("ID") String ID, Model model, HttpSession session) {

		List<String> IDs = new ArrayList<>();
		IDs.add(ID);
		serviceFit.getRoomService().delTeaRoom(IDs);
		
		return "./room/distribute";
	}
	
	@RequestMapping("delAllTeaRoom")
	public String delAllTeaRoom(Model model, HttpSession session) {
		List<String> IDs = new ArrayList<>();
		IDs.add("");
		ResultDo<?> resultDo = serviceFit.getRoomService().getDisInfo();
		for (TeaRoom teaRoom : (List<TeaRoom>) resultDo.getResult()) {
			IDs.add(teaRoom.getId() + "");
		}
		serviceFit.getRoomService().delTeaRoom(IDs);
		return "./room/distribute";
	}

	@RequestMapping("chooseTeacher")
	public String chooseTeacher(Model model, HttpSession session){
		ResultDo<List<NumOfStuWithTea>> resultDo=serviceFit.getTeacherService().chooseTeacher();
		if(resultDo.isSuccess()){
			model.addAttribute("teachers", resultDo.getResult());
		}else{
			model.addAttribute("message", resultDo.getMessage());
		}
		return "./room/chooseTeacher";
	}
	
	
	@RequestMapping("roomList")
	public String roomList(@RequestParam("teaID") String teaID, @RequestParam("teaName") String teaName, Model model, HttpSession session){
		model.addAttribute("teaID", teaID);
		model.addAttribute("teaName", teaName);
		ResultDo<List<Room>> resultDo = serviceFit.getRoomService().getRooms();
		List<Room> rooms = null;
		if(resultDo.isSuccess()) {
			rooms = (List<Room>) resultDo.getResult();
			model.addAttribute("rooms", rooms);
		} 
		else {
			model.addAttribute("message", "查询失败");
		}
		return "./room/roomList";
	}
	
	@RequestMapping("getRooms")
	public void getRooms(Model model, HttpSession session, HttpServletResponse response) throws Exception{
		ResultDo<List<TeaRoom>> resultDo = serviceFit.getRoomService().getDisInfo();
		List<TeaRoom> tearooms = null;
		if(resultDo.isSuccess()) {
			tearooms = (List<TeaRoom>) resultDo.getResult();
			response.getWriter().write(JSONArray.fromObject(tearooms).toString());
		} 
		else {
			model.addAttribute("message", "查询失败");
		}
	}
	
	
	@RequestMapping("addTeaRoom")
	public String addTeaRoom(@RequestParam("teaID") Integer teaID, @RequestParam("teaName") String teaName, @RequestParam("roomID") Integer roomID, @RequestParam("start") Integer start, @RequestParam("end") Integer end, Model model, HttpSession session) {
		model.addAttribute("teaID", teaID);
		model.addAttribute("teaName", teaName);
		
		List<TeaRoom> tearooms = new ArrayList<>();
		TeaRoom tearoom = new TeaRoom();
		tearoom.setRoom_id(roomID);
		tearoom.setIdentity_id(teaID);
		tearoom.setIdentity_name(teaName);
		tearoom.setStart(start);
		tearoom.setEnd(end);
		tearooms.add(tearoom);
		serviceFit.getRoomService().addTeaRoom(tearooms);
		
		return "./room/roomList";
	}
}
