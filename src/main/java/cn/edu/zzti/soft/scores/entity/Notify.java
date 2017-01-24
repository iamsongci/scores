package cn.edu.zzti.soft.scores.entity;

import java.sql.Date;

public class Notify {
	private Integer id;
	private String title;
	private String content;
	private String owner_name;
	private Date time;
	private Boolean toStudent;
	private Integer owner_id;
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
	public String getOwner_name() {
		return owner_name;
	}
	public void setOwner_name(String owner_name) {
		this.owner_name = owner_name;
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
	public Integer getOwner_id() {
		return owner_id;
	}
	public void setOwner_id(Integer owner_id) {
		this.owner_id = owner_id;
	}
	@Override
	public String toString() {
		return "Notify [id=" + id + ", title=" + title + ", content=" + content
				+ ", owner_name=" + owner_name + ", time=" + time
				+ ", toStudent=" + toStudent + ", owner_id=" + owner_id + "]";
	}
	
	
	
}
