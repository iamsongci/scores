package cn.edu.zzti.soft.scores.dao;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.RoomNew;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.TeaRoomNew;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.entity.tools.UseingSeats;

@Repository
public interface RoomNewDao {
	
	@Select("SELECT room_new.*, seats AS used FROM room_new LEFT JOIN (SELECT room_id, GROUP_CONCAT(seats SEPARATOR ',') AS seats FROM tea_room_new GROUP BY room_id) AS temp ON temp.room_id = room_new.`room_id`")
	List<RoomNew> listRoom();
	
	@Select("SELECT * FROM room_new WHERE room_id = #{0}")
	RoomNew getRoom(Integer ID);
	
	Integer insertRoom(List<RoomNew> rooms);
	
	@Update("UPDATE room_new SET start_num = #{1} WHERE room_id = #{0}")
	Integer updateStartSeat(Integer ID, Integer start);
	
	@Update("UPDATE room_new SET end_num = #{1} WHERE room_id = #{0}")
	Integer updateEndSeat(Integer ID, Integer end);
	
	@Update("UPDATE room_new SET other_use = #{1} WHERE room_id = #{0}")
	Integer updateOtherUse(Integer ID, String otherUse);
	
	@Select("SELECT room_new.`room_id`, start_num, end_num, seats FROM room_new LEFT JOIN (SELECT room_id, GROUP_CONCAT(seats SEPARATOR ',') AS seats FROM tea_room_new GROUP BY room_id) AS temp ON temp.room_id = room_new.`room_id` WHERE room_new.`room_id` = #{0}")
	UseingSeats getUseingSeats(Integer ID);
	
	Integer deleteRoom(List<Integer> IDs);
	
	@Select("SELECT * FROM tea_room_new")
	List<TeaRoomNew> listTeaRoom();
	
	Integer insertTeaRoom(List<TeaRoomNew> teaRoom);
	
	Integer deleteTeaRoom(List<String> IDs);
	
}