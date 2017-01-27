package cn.edu.zzti.soft.scores.dao;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Room;

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
	
}
