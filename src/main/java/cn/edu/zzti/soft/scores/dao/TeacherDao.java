package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.IdentityWithScores;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;

@Repository
public interface TeacherDao {
	//根据教师id进行分配权限获取
	List<Project> getPowerById(int id); 
	//查看教师所带课题人数,并选择教师
	List<NumOfStuWithTea> chooseTeacher(int pro_id); 
	//查看班级人数
	List<NumOfClasses> chooseClasses();
	//查看教师所带学生
	List<IdentityWithScores> teaWithStu(int tea_id,int pro_id);
}
