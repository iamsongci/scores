package cn.edu.zzti.soft.scores.service;

import java.util.List;

import cn.edu.zzti.soft.scores.entity.Room;
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
}
