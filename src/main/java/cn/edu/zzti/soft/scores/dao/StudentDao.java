package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;
@Repository
public interface StudentDao {
	
	List<MyScore> getMyScores(int id);

}
