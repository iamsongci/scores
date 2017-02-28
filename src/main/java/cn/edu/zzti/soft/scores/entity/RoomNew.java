package cn.edu.zzti.soft.scores.entity;

public class RoomNew {
	private Integer room_id;
	private String num_type;
	private Integer start_num;
	private Integer end_num;
	private String other_use;
	private String used;
	
	public String getUsed() {
		return used;
	}
	public void setUsed(String used) {
		this.used = used;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public String getNum_type() {
		return num_type;
	}
	public void setNum_type(String num_type) {
		this.num_type = num_type;
	}
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
	public String getOther_use() {
		return other_use;
	}
	public void setOther_use(String other_use) {
		this.other_use = other_use;
	}
	@Override
	public String toString() {
		return "RoomNew [room_id=" + room_id + ", num_type=" + num_type + ", start_num=" + start_num + ", end_num="
				+ end_num + ", other_use=" + other_use + ", used=" + used + "]";
	}
	
	
}
