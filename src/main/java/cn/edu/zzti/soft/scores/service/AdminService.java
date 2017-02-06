package cn.edu.zzti.soft.scores.service;

import java.util.List;


import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.Grade;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface AdminService {

	//获取课题
	ResultDo<List<Project>> getProjects();
	
	//查学生
	ResultDo<List<Identity>> getStudents();
	
	//查导师
	ResultDo<List<Identity>> getTeachers();
	
	//查除了学生的人
	ResultDo<List<Identity>> getAllTea();
	
	//查班级
	ResultDo<List<Classes>> getClasses();
	
	//添加角色
	boolean addIdentity(List<Identity> identities);
	
	//查年级
	ResultDo<List<Grade>> getGrades();
	
	//添加班级
	boolean addClasses(List<Classes> classes);
	
	//删除角色
	boolean delIdentity(List<String> identities);
	
	//分配学生
	boolean upDistr(Integer proID, Integer teaID, String teaName);
	
	//汇总分数
	boolean upAggre(Integer proID, Integer teaID, String teaName);
	
	//置空
	boolean resetDistr(Integer proID);
	
	//置空
	boolean resetAggre(Integer proID);
	
	//添加课题
	boolean addProjects(List<String> projcets);
	
	
}
