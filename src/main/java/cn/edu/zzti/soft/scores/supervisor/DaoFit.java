package cn.edu.zzti.soft.scores.supervisor;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.dao.AdminDao;
import cn.edu.zzti.soft.scores.dao.LoginDao;
import cn.edu.zzti.soft.scores.dao.NotifyDao;
import cn.edu.zzti.soft.scores.dao.RoomDao;
import cn.edu.zzti.soft.scores.dao.RoomNewDao;
import cn.edu.zzti.soft.scores.dao.StudentDao;
import cn.edu.zzti.soft.scores.dao.TeacherDao;

@Repository
 public class DaoFit {
	@Resource
	private LoginDao loginDao;
	
	@Resource
	private StudentDao studentDao;
	
	@Resource
	private TeacherDao teacherDao;
	
	@Resource
	private RoomDao roomDao;
	
	@Resource
	private AdminDao adminDao;
	
	@Resource
	private NotifyDao notifyDao;
	
	@Resource
	private RoomNewDao roomNewDao;

	public RoomNewDao getRoomNewDao() {
		return roomNewDao;
	}

	public NotifyDao getNotifyDao() {
		return notifyDao;
	}

	public LoginDao getLoginDao() {
		return loginDao;
	}

	public StudentDao getStudentDao() {
		return studentDao;
	}

	public TeacherDao getTeacherDao() {
		return teacherDao;
	}

	public RoomDao getRoomDao() {
		return roomDao;
	}

	public AdminDao getAdminDao() {
		return adminDao;
	}
    
	
}
