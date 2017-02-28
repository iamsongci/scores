package cn.edu.zzti.soft.scores.entity.tools;

import java.util.Arrays;

public class UseingSeats {
	private Integer room_id;
	private Integer start_num;
	private Integer end_num;
	private String seats;
	private String seat[];

	
	public Integer getStart_num() {
		return start_num;
	}
	public void setStart_num(Integer start_num) {
		this.start_num = start_num;
	}
	public Integer getEnd_num() {
		return end_num;
	}
	public void setEnd_num(Integer end_num) {
		this.end_num = end_num;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public String getSeats() {
		return seats;
	}
	public void setSeats(String seats) {
		this.seats = seats;
	}
	public String[] getSeat() {
		return seat;
	}
	public void setSeat(String[] seat) {
		this.seat = seat;
	}
	@Override
	public String toString() {
		return "UseingSeats [room_id=" + room_id + ", start_num=" + start_num + ", end_num=" + end_num + ", seats="
				+ seats + ", seat=" + Arrays.toString(seat) + "]";
	}
	
	
	
	
}
