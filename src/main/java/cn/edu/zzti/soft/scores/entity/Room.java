package cn.edu.zzti.soft.scores.entity;

public class Room {
	private Integer roomID;
	private Integer roomNum;
	public Integer getRoomID() {
		return roomID;
	}
	public void setRoomID(Integer roomID) {
		this.roomID = roomID;
	}
	public Integer getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(Integer roomNum) {
		this.roomNum = roomNum;
	}
	@Override
	public String toString() {
		return "Room [roomID=" + roomID + ", roomNum=" + roomNum + "]";
	}
	
}
