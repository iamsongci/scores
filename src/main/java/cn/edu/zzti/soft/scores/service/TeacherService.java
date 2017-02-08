package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.tools.IdentityWithScores;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;


public interface TeacherService {
	////根据教师id进行分配权限获取
	ResultDo getPowerById(int id);
    //查看教师所带课题人数,并选择教师
	ResultDo chooseTeacher(int pro_id);
	//查看并选择班级
	ResultDo chooseClasses();
	//查看教师所带学生
	ResultDo teaWithStu(int tea_id,int pro_id);
	//取消导师分配的学生关系
	boolean delTeaWithStu(Integer score_id);
	//查看班级学生信息
	ResultDo selectStuByClassId(Integer class_id,Integer pro_id);
	//为导师分配学生
	boolean addTeaWithStu(Integer tea_id,Integer pro_id,Integer[] stuIdList,String teaName,String proName);
	//查看与该课题有关的班级
	ResultDo selectClaByProId (Integer pro_id);
	//查看某班某课题的学生成绩
	ResultDo proStuScore(Integer cla_id,Integer pro_id);
}
