package cn.edu.zzti.soft.scores.service;

import cn.edu.zzti.soft.scores.supervisor.ResultDo;


public interface TeacherService {
	////根据教师id进行分配权限获取
	ResultDo getPowerById(int id);

}
