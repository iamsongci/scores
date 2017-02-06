package cn.edu.zzti.soft.scores.service;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

public interface RoomService {
	
	//查询所有机房
	ResultDo<List<Room>> getRooms();
	
	//删除机房
	boolean delRoom(Integer ID);
	
	//更新机位数
	boolean upRoomNum(Integer ID, Integer num);
	
	//添加新的机房
	boolean addNewRoom(Integer ID, Integer num);
	
	//删除所有
	boolean delAll();
	
	//获取分配信息
	ResultDo<List<TeaRoom>> getDisInfo();
	
	//删除机房分配
	boolean delTeaRoom(List<String> IDs);
	
	//添加导师机房
	boolean addTeaRoom(List<TeaRoom> tearooms);
}
