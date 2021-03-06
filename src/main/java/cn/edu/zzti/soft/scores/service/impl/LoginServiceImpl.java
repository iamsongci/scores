package cn.edu.zzti.soft.scores.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.service.LoginService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.util.MDUtil;

@Service("LoginService")
public class LoginServiceImpl implements LoginService{

	@Resource
	 DaoFit daoFit;
	public ResultDo Login(String noid, String psw) {
		// TODO Auto-generated method stub
		ResultDo resultDo=new ResultDo();
	    psw=MDUtil.MD5Tools(psw);
		//System.out.println(psw);
		Identity identity=daoFit.getLoginDao().Login(noid, psw);
		if(identity != null) {
			resultDo.setResult(identity);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("用户名或密码不正确");
		}
		return resultDo;
	}
	public ResultDo GetIdentityById(int id) {
		// TODO Auto-generated method stub
		ResultDo resultDo=new ResultDo();
		Identity identity=daoFit.getLoginDao().GetIdentityById(id);
		if(identity != null) {
			resultDo.setResult(identity);
			resultDo.setSuccess(true);
		}
		else {
			resultDo.setMessage("未查到该用户信息");
		}
		return resultDo;
	}
	public boolean UpdateInfoByKey(Identity identity) {
		// TODO Auto-generated method stub
		Integer in=daoFit.getLoginDao().UpdateInfoByKey(identity);
		boolean isSuccess=false;
		if(in==1){
			isSuccess=true;
		}
		return isSuccess;
	}

}
