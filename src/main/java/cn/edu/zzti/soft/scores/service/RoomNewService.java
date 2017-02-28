package cn.edu.zzti.soft.scores.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.RoomNew;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.TeaRoomNew;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.entity.tools.UseingSeats;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface RoomNewService {
	
	//查询所有机房
	List<RoomNew> listRoom() throws Exception;
	
	//添加机房
	void insertRoom(List<RoomNew> rooms) throws Exception;
	
	void updateStartSeat(Integer ID, Integer start) throws Exception;
	
	void updateEndSeat(Integer ID, Integer end) throws Exception;
	
	void updateOtherUse(Integer ID, String otherUse) throws Exception;
	
	void resetOtherUse(Integer ID) throws Exception;
	
	void deleteRoom(List<Integer> IDs) throws Exception;
	
	UseingSeats getUseingSeats(Integer ID) throws Exception;
	
	RoomNew getRoom(Integer ID) throws Exception;
	
	List<TeaRoomNew> listTeaRoom() throws Exception;
	
	void insertTeaRoom(List<TeaRoomNew> teaRoom) throws Exception;
	
	void deleteTeaRoom(List<String> IDs) throws Exception;
	
}
