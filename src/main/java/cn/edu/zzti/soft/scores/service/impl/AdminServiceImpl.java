package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.Grade;
import cn.edu.zzti.soft.scores.service.AdminService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
@Service("AdminService")
public class AdminServiceImpl implements AdminService {

	private static final Integer FALSE = 0;
	
	@Resource
	DaoFit daoFit;
	
	@Override
	public ResultDo<List<Project>> getProjects() {
		ResultDo<List<Project>> resultDo = new ResultDo<>();
		List<Project> projects = daoFit.getAdminDao().getProjects();
		if(projects != null) {
			resultDo.setResult(projects);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public ResultDo<List<Identity>> getStudents() {
		ResultDo<List<Identity>> resultDo = new ResultDo<>();
		List<Identity> projects = daoFit.getAdminDao().getByRole("stu");
		if(projects != null) {
			resultDo.setResult(projects);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public ResultDo<List<Identity>> getTeachers() {
		ResultDo<List<Identity>> resultDo = new ResultDo<>();
		List<Identity> projects = daoFit.getAdminDao().getByRole("tea");
		if(projects != null) {
			resultDo.setResult(projects);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public ResultDo<List<Classes>> getClasses() {
		ResultDo<List<Classes>> resultDo = new ResultDo<>();
		List<Classes> classes = daoFit.getAdminDao().getClasses();
		if(classes != null) {
			resultDo.setResult(classes);
			resultDo.setSuccess(true);
		} 
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public boolean addIdentity(List<Identity> identities) {
		return FALSE != daoFit.getAdminDao().addIdentity(identities);
	}

	@Override
	public ResultDo<List<Grade>> getGrades() {
		ResultDo<List<Grade>> resultDo = new ResultDo<>();
		List<Grade> grades = daoFit.getAdminDao().getGrades();
		if(grades != null) {
			resultDo.setResult(grades);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败!");
		}
		return resultDo;
	}

	@Override
	public boolean addClasses(List<Classes> classes) {
		return FALSE != daoFit.getAdminDao().addClasses(classes);
	}

	@Override
	public boolean delIdentity(List<String> identities) {
		return FALSE != daoFit.getAdminDao().delIdentity(identities);
	}

	@Override
	public boolean upDistr(Integer proID, Integer teaID, String teaName) {
		return FALSE != daoFit.getAdminDao().upDistr(proID, teaID, teaName);
	}

	@Override
	public boolean upAggre(Integer proID, Integer teaID, String teaName) {
		return FALSE != daoFit.getAdminDao().upAggre(proID, teaID, teaName);
	}

	@Override
	public boolean resetDistr(Integer proID) {
		return FALSE != daoFit.getAdminDao().resetDistr(proID);
	}

	@Override
	public boolean resetAggre(Integer proID) {
		return FALSE != daoFit.getAdminDao().resetAggre(proID);
	}

	@Override
	public boolean addProjects(List<String> projcets) {
		return FALSE != daoFit.getAdminDao().addProjects(projcets);
	}

	@Override
	public ResultDo<List<Identity>> getAllTea() {
		ResultDo<List<Identity>> resultDo = new ResultDo<>();
		List<Identity> projects = daoFit.getAdminDao().getAllTea();
		if(projects != null) {
			resultDo.setResult(projects);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}
	
}
