package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.service.RoomService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

@Service("RoomService")
public class RoomServiceImpl implements RoomService {

	private static final Integer FALSE = 0;
	
	@Resource
	DaoFit daoFit;
	
	@Override
	public ResultDo<List<Room>> getRooms() {
		ResultDo<List<Room>> resultDo = new ResultDo<>();
		List<Room> rooms = daoFit.getRoomDao().getRooms();
		if(rooms != null) {
			resultDo.setResult(rooms);
			resultDo.setSuccess(true);
		} else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public boolean delRoom(Integer ID) {
		return FALSE != daoFit.getRoomDao().delRoom(ID);
	}

	@Override
	public boolean upRoomNum(Integer ID, Integer num) {
		return FALSE != daoFit.getRoomDao().upRoomNum(ID, num);
	}

	@Override
	public boolean addNewRoom(Integer ID, Integer num) {
		return FALSE != daoFit.getRoomDao().addNewRoom(ID, num);
	}

	@Override
	public boolean delAll() {
		return FALSE != daoFit.getRoomDao().delAll();
	}
	
}
