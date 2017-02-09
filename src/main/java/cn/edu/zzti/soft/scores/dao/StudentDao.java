package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.tools.MyScore;
@Repository
public interface StudentDao {
	
	List<MyScore> getMyScores(int id);

	Integer upProName(int id, String newName);
	
	@Select("SELECT * FROM score WHERE id = #{0}")
	MyScore getScore(Integer ID);
}
