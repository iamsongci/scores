package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Project;

@Repository
public interface TeacherDao {
	//根据教师id进行分配权限获取
	List<Project> getPowerById(int id); 
	
}
