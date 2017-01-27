package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Project;
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
	
}
