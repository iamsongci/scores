package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;

public interface StudentService {
   
	List<MyScore> getMyScores(int id);
	
}
