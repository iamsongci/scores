package cn.edu.zzti.soft.scores.entity;

public class TeaRoom {
	private Integer id;
	private Integer roomID;
	private Integer identityID;
	private String identityName;
	private Integer start;
	private Integer end;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRoomID() {
		return roomID;
	}

	public void setRoomID(Integer roomID) {
		this.roomID = roomID;
	}

	public Integer getIdentityID() {
		return identityID;
	}

	public void setIdentityID(Integer identityID) {
		this.identityID = identityID;
	}

	public String getIdentityName() {
		return identityName;
	}

	public void setIdentityName(String identityName) {
		this.identityName = identityName;
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
		return "TeaRoom [id=" + id + ", roomID=" + roomID + ", identityID=" + identityID + ", identityName="
				+ identityName + ", start=" + start + ", end=" + end + "]";
	}

}
