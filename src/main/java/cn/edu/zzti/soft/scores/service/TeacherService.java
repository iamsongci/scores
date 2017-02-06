package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.tools.IdentityWithScores;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;


public interface TeacherService {
	////根据教师id进行分配权限获取
	ResultDo getPowerById(int id);
    //查看教师所带课题人数,并选择教师
	ResultDo chooseTeacher();
	//查看并选择班级
	ResultDo chooseClasses();
	//查看教师所带学生
	ResultDo teaWithStu(int tea_id,int pro_id);
}
