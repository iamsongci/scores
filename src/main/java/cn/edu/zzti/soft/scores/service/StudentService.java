package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface StudentService {
   
	//都得到我的课题
	ResultDo<List<MyScore>> getMyScores(int id);
	
	//更新课题名
	Boolean upProName(int id, String newName);
	
	ResultDo<MyScore> getScore(Integer ID);
}
