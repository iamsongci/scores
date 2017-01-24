package cn.edu.zzti.soft.scores.entity;

import java.sql.Date;

public class Notify {
	private Integer id;
	private String title;
	private String content;
	private String ownerName;
	private Date time;
	private Boolean toStudent;
	private Integer ownerID;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOwnerName() {
		return ownerName;
	}
	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	public Boolean getToStudent() {
		return toStudent;
	}
	public void setToStudent(Boolean toStudent) {
		this.toStudent = toStudent;
	}
	public Integer getOwnerID() {
		return ownerID;
	}
	public void setOwnerID(Integer ownerID) {
		this.ownerID = ownerID;
	}
	@Override
	public String toString() {
		return "Notify [id=" + id + ", title=" + title + ", content=" + content + ", ownerName=" + ownerName + ", time="
				+ time + ", toStudent=" + toStudent + ", ownerID=" + ownerID + "]";
	}
	
	
}
