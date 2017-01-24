package cn.edu.zzti.soft.scores.entity;

public class Room {
	private Integer room_id;
	private Integer room_num;
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public Integer getRoom_num() {
		return room_num;
	}
	public void setRoom_num(Integer room_num) {
		this.room_num = room_num;
	}
	@Override
	public String toString() {
		return "Room [room_id=" + room_id + ", room_num=" + room_num + "]";
	}
    
}
