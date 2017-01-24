package cn.edu.zzti.soft.scores.entity;

public class TeaRoom {
	private Integer id;
	private Integer room_id;
	private Integer identity_id;
	private String identity_name;
	private Integer start;
	private Integer end;
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
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "TeaRoom [id=" + id + ", room_id=" + room_id + ", identity_id="
				+ identity_id + ", identity_name=" + identity_name + ", start="
				+ start + ", end=" + end + ", getId()=" + getId()
				+ ", getRoom_id()=" + getRoom_id() + ", getIdentity_id()="
				+ getIdentity_id() + ", getIdentity_name()="
				+ getIdentity_name() + ", getStart()=" + getStart()
				+ ", getEnd()=" + getEnd() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()="
				+ super.toString() + "]";
	}
    

}
