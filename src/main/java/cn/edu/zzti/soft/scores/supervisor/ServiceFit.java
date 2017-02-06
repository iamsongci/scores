package cn.edu.zzti.soft.scores.supervisor;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.service.AdminService;
import cn.edu.zzti.soft.scores.service.LoginService;
import cn.edu.zzti.soft.scores.service.NotifyService;
import cn.edu.zzti.soft.scores.service.RoomService;
import cn.edu.zzti.soft.scores.service.StudentService;
import cn.edu.zzti.soft.scores.service.TeacherService;

@Repository
public class ServiceFit {
	
	@Resource
	private LoginService loginService;
	@Resource
	private StudentService studentService;
	@Resource
	private RoomService roomService;
	@Resource
	private AdminService adminService;
	@Resource
	private TeacherService teacherService;
	@Resource
	private NotifyService notifyService;
	
	public NotifyService getNotifyService() {
		return notifyService;
	}
	public LoginService getLoginService() {
		return loginService;
	}
	public StudentService getStudentService() {
		return studentService;
	}
	public RoomService getRoomService() {
		return roomService;
	}
	public AdminService getAdminService() {
		return adminService;
	}
	public TeacherService getTeacherService() {
		return teacherService;
	}
	
}
