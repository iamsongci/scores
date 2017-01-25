package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface StudentService {
   
	ResultDo<List<MyScore>> getMyScores(int id);
	
	Boolean upProName(int id, String newName);
}
