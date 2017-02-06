package cn.edu.zzti.soft.scores.service;

import java.util.List;


import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.Grade;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface NotifyService {

	//添加
	boolean addNotify(List<Notify> notifies);
	
	//查询
	ResultDo<List<Notify>> getNotifies();
	
	//删除
	boolean delNotify(List<String> IDs);
	
	//学生查询通知
	ResultDo<List<Notify>> getNotifiesByStu(String stuID);
	
	//老师查询通知
	ResultDo<List<Notify>> getNotifiesByTea(String teaID);
}
