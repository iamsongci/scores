package cn.edu.zzti.soft.scores.service.impl;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.RoomNew;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.TeaRoomNew;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.entity.tools.UseingSeats;
import cn.edu.zzti.soft.scores.service.RoomNewService;
import cn.edu.zzti.soft.scores.service.RoomService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;

@Service("RoomNewService")
public class RoomNewServiceImpl implements RoomNewService {

	private static final Integer FALSE = 0;
	
	@Resource
	DaoFit daoFit;
	
	@Override
	public List<RoomNew> listRoom() throws Exception {
		List<RoomNew> roomNews = daoFit.getRoomNewDao().listRoom();
		if(roomNews == null) {
			throw new Exception("查询失败!");
		}
		return roomNews;
	}

	@Override
	public void insertRoom(List<RoomNew> rooms) throws Exception {
		Integer i = daoFit.getRoomNewDao().insertRoom(rooms);
		if(i == FALSE) {
			throw new Exception("添加失败!");
		}
	}

	@Override
	public void updateStartSeat(Integer ID, Integer start) throws Exception {
		Integer i = daoFit.getRoomNewDao().updateStartSeat(ID, start);
		if(i == FALSE) {
			throw new Exception("更新失败!");
		}
	}

	@Override
	public void updateEndSeat(Integer ID, Integer end) throws Exception {
		Integer i = daoFit.getRoomNewDao().updateEndSeat(ID, end);
		if(i == FALSE) {
			throw new Exception("更新失败!");
		}
	}

	@Override
	public void updateOtherUse(Integer ID, String otherUse) throws Exception {
		Integer i = daoFit.getRoomNewDao().updateOtherUse(ID, otherUse);
		if(i == FALSE) {
			throw new Exception("更新失败!");
		}
		
	}

	@Override
	public void resetOtherUse(Integer ID) throws Exception {
		Integer i = daoFit.getRoomNewDao().updateOtherUse(ID, null);
		if(i == FALSE) {
			throw new Exception("更新失败!");
		}
	}

	@Override
	public void deleteRoom(List<Integer> IDs) throws Exception {
		Integer i = daoFit.getRoomNewDao().deleteRoom(IDs);
		if(i == FALSE) {
			throw new Exception("删除失败!");
		}
		
	}

	@Override
	public UseingSeats getUseingSeats(Integer ID) throws Exception {
		UseingSeats useingSeats = daoFit.getRoomNewDao().getUseingSeats(ID);
		if(useingSeats == null) {
			throw new Exception("查询失败!");
		}
		if(useingSeats.getSeats() != null) {
			useingSeats.setSeat(useingSeats.getSeats().split(","));
			Arrays.sort(useingSeats.getSeat());
		}
		return useingSeats;
	}

	@Override
	public RoomNew getRoom(Integer ID) throws Exception {
		RoomNew room = daoFit.getRoomNewDao().getRoom(ID);
		if(room == null) {
			throw new Exception("查询失败!");
		}
		return room;
	}

	@Override
	public List<TeaRoomNew> listTeaRoom() throws Exception {
		List<TeaRoomNew> tearooms = daoFit.getRoomNewDao().listTeaRoom();
		if(tearooms == null) {
			throw new Exception("查询失败!");
		}
		return tearooms;
	}

	@Override
	public void insertTeaRoom(List<TeaRoomNew> teaRoom) throws Exception {
		Integer i = daoFit.getRoomNewDao().insertTeaRoom(teaRoom);
		if(i == FALSE) {
			throw new Exception("添加失败!");
		}
	}

	@Override
	public void deleteTeaRoom(List<String> IDs) throws Exception {
		Integer i = daoFit.getRoomNewDao().deleteTeaRoom(IDs);
		if(i == FALSE) {
			throw new Exception("添加失败!");
		}
	}
}
