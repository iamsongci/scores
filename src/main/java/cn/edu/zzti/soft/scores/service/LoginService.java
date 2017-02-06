package cn.edu.zzti.soft.scores.service;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface LoginService {
	//用户根据noid登陆
	 ResultDo Login(String noid ,String psw);
    //根据id进行用户信息查询
	 ResultDo GetIdentityById(int id);
	 //根据id对用户信息进行修改
	 boolean UpdateInfoByKey(Identity identity);
	 
	 //修改密码
	 boolean updatePsw(Integer ID, String psw);
}
