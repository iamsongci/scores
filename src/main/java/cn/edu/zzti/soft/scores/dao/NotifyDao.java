package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Notify;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.Grade;

@Repository
public interface NotifyDao {
	
	Integer addNotify(List<Notify> notifies);
	
	@Select("SELECT * FROM notify ORDER BY id DESC")
	List<Notify> getNotifies();
	
	Integer delNotify(List<String> IDs);

	@Select("SELECT notify.* FROM notify WHERE (owner_id IN (SELECT score.`tea_id` FROM score WHERE stu_id = #{0}) OR owner_id = '0' OR owner_name = '机房') AND tostudent = b'1' ORDER BY id DESC")
	List<Notify> getNotifiesByStu(String stuID);
	
	
	@Select("SELECT notify.* FROM notify WHERE owner_id =#{0} OR owner_id = '0' ORDER BY id DESC")
	List<Notify> getNotifiesByTea(String teaID);
	
}
