package cn.edu.zzti.soft.scores.dao;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;

@Repository
public interface RoomDao {
	
	@Select("SELECT * FROM room")
	List<Room> getRooms();
	
	@Delete("DELETE FROM room WHERE room.`room_id` = #{0}")
	Integer delRoom(Integer ID);
	
	@Update("UPDATE room SET room.`room_num` = #{1} WHERE room.`room_id` = #{0}")
	Integer upRoomNum(Integer ID, Integer num);
	
	@Insert("INSERT room VALUES(#{0}, #{1})")
	Integer addNewRoom(Integer ID, Integer num);
	
	@Delete("DELETE FROM room")
	Integer delAll();
	
	@Select("SELECT * FROM tea_room")
	List<TeaRoom> getDisInfo();
	
	Integer delTeaRoom(List<String> IDs);
	
	Integer addTeaRoom(List<TeaRoom> tearooms);
	
	@Select("SELECT identity.id,name,noid,role,phone,status,COUNT(tea_id) as num FROM identity LEFT JOIN score ON identity.id=tea_id GROUP BY identity.id HAVING role='tea' AND status = 0")
	List<NumOfStuWithTea> chooseTeacher();
	
}