package cn.edu.zzti.soft.scores.entity;

public class TeaRoomNew {
	private Integer id;
	private Integer room_id;
	private Integer identity_id;
	private String identity_name;
	private String seats;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public Integer getIdentity_id() {
		return identity_id;
	}
	public void setIdentity_id(Integer identity_id) {
		this.identity_id = identity_id;
	}
	public String getIdentity_name() {
		return identity_name;
	}
	public void setIdentity_name(String identity_name) {
		this.identity_name = identity_name;
	}
	public String getSeats() {
		return seats;
	}
	public void setSeats(String seats) {
		this.seats = seats;
	}
	@Override
	public String toString() {
		return "TeaRoomNew [id=" + id + ", room_id=" + room_id + ", identity_id=" + identity_id + ", identity_name="
				+ identity_name + ", seats=" + seats + "]";
	}
	
	
    

}
