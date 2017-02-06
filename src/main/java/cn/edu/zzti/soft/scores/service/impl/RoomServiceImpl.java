package cn.edu.zzti.soft.scores.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Room;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
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
		ResultDo<List<Room>> resultDo = new ResultDo<List<Room>>();
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

	@Override
	public ResultDo<List<TeaRoom>> getDisInfo() {
		ResultDo<List<TeaRoom>> resultDo = new ResultDo<List<TeaRoom>>();
		List<TeaRoom> teaRooms = daoFit.getRoomDao().getDisInfo();
		if(teaRooms != null) {
			resultDo.setResult(teaRooms);
			resultDo.setSuccess(true);
		} else {
			resultDo.setMessage("查询失败");
		}
		return resultDo;
	}

	@Override
	public boolean delTeaRoom(List<String> IDs) {
		return FALSE != daoFit.getRoomDao().delTeaRoom(IDs);
	}

	@Override
	public boolean addTeaRoom(List<TeaRoom> tearooms) {
		return FALSE != daoFit.getRoomDao().addTeaRoom(tearooms);
	}

	@Override
	public ResultDo chooseTeacher() {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfStuWithTea>> resultDo=new ResultDo<List<NumOfStuWithTea>>();
		List<NumOfStuWithTea> list =daoFit.getRoomDao().chooseTeacher();
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无人员信息，请联系超级管理员进行导入！！");
		}
		return resultDo;
	}
	
}
