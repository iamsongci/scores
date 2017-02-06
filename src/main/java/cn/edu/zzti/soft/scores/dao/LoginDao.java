package cn.edu.zzti.soft.scores.dao;

import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Identity;

@Repository
public interface LoginDao {
	//根据用户的noid和密码进行登陆操作
	Identity Login(String noid ,String psw);
	//根据id进行个人信息查询
	Identity GetIdentityById(int id);
	//根据id修改个人信息
	Integer UpdateInfoByKey(Identity identity);
	
	//修改密码
	@Update("UPDATE identity SET identity.`psw` = #{1} WHERE id = #{0}")
	Integer updatePsw(Integer ID, String psw);
}