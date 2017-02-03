package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.service.TeacherService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService {
	@Resource
	 DaoFit daoFit;
	@Override
	public ResultDo<List<Project>> getPowerById(int id) {
		// TODO Auto-generated method stub
		ResultDo<List<Project>> resultDo=new ResultDo<List<Project>>();
		if(id>0){
			List<Project> list =daoFit.getTeacherDao().getPowerById(id);	
			if(list.size()>0){
				resultDo.setResult(list);
				resultDo.setSuccess(true);
	        }else{
	        	resultDo.setMessage("该人员无权限！！");
	        }
		}
		return resultDo;
	}
	@Override
	public ResultDo chooseTeacher() {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfStuWithTea>> resultDo=new ResultDo<List<NumOfStuWithTea>>();
		List<NumOfStuWithTea> list =daoFit.getTeacherDao().chooseTeacher();
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无人员信息，请联系超级管理员进行导入！！");
		}
		return resultDo;
	}
	@Override
	public ResultDo chooseClasses() {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfClasses>> resultDo=new ResultDo<List<NumOfClasses>>();
		List<NumOfClasses> list =daoFit.getTeacherDao().chooseClasses();
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无班级信息，请联系超级管理员进行导入！！");
		}
		return resultDo;
	}
	
}
