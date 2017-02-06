package cn.edu.zzti.soft.scores.service.impl;


import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.service.NotifyService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
@Service("NotifyService")
public class NotifyServiceImpl implements NotifyService {
	
	private static final Integer FALSE = 0;
	
	@Resource
	DaoFit daoFit;
	
	@Override
	public boolean addNotify(List<Notify> notifies) {
		return FALSE != daoFit.getNotifyDao().addNotify(notifies);
	}
	
	@Override
	public ResultDo<List<Notify>> getNotifies() {
		ResultDo<List<Notify>> resultDo = new ResultDo<>();
		List<Notify> notifies = daoFit.getNotifyDao().getNotifies();
		if(notifies != null) {
			resultDo.setResult(notifies);
			resultDo.setSuccess(true);
		} 
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
 	}
	
	@Override
	public boolean delNotify(List<String> IDs) {
		return FALSE != daoFit.getNotifyDao().delNotify(IDs);
	}

	@Override
	public ResultDo<List<Notify>> getNotifiesByStu(String stuID) {
		ResultDo<List<Notify>> resultDo = new ResultDo<>();
		List<Notify> notifies = daoFit.getNotifyDao().getNotifiesByStu(stuID);
		if(notifies != null) {
			resultDo.setResult(notifies);
			resultDo.setSuccess(true);
		} 
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public ResultDo<List<Notify>> getNotifiesByTea(String teaID) {
		ResultDo<List<Notify>> resultDo = new ResultDo<>();
		List<Notify> notifies = daoFit.getNotifyDao().getNotifiesByTea(teaID);
		if(notifies != null) {
			resultDo.setResult(notifies);
			resultDo.setSuccess(true);
		} 
		else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}
}
