package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.service.StudentService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

@Service("StudentService")
public class StudentServiceImpl implements StudentService {

	private static final Integer FALSE = 0;
	@Resource
	DaoFit daoFit;
	
	@Override
	public ResultDo<List<MyScore>> getMyScores(int id) {
		ResultDo<List<MyScore>> resultDo = new ResultDo<List<MyScore>>();
		List<MyScore> myscore = daoFit.getStudentDao().getMyScores(id);
		if(myscore != null) {
			resultDo.setResult(myscore);
			resultDo.setSuccess(true);
		} 
		else {
			resultDo.setMessage("查询失败!");
		}
		return resultDo;
	}

	@Override
	public Boolean upProName(int id, String newName) {
		return FALSE != daoFit.getStudentDao().upProName(id, newName);
	}

	@Override
	public ResultDo<MyScore> getScore(Integer ID) {
		ResultDo<MyScore> resultDo = new ResultDo<>();
		MyScore score = daoFit.getStudentDao().getScore(ID);
		if(score != null) {
			if(score.getScores_status() != 2) {
				score.setProject_score(null);
				score.setReport_score(null);
				score.setTotal_score(null);
				score.setUsual_score(null);
			}
			resultDo.setResult(score);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("查询失败!");
		}
		return resultDo;
	}

	@Override
	public Boolean updateReport(int id, int report_status, String address) {
		// TODO Auto-generated method stub
		return FALSE != daoFit.getStudentDao().updateReport(id, report_status, address);
	}
	
}
