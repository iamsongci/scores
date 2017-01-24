package cn.edu.zzti.soft.scores.entity;

public class Classes {
	private Integer id;
	private Integer grede;
	private String classesName;
	private Boolean type;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getGrede() {
		return grede;
	}
	public void setGrede(Integer grede) {
		this.grede = grede;
	}
	public String getClassesName() {
		return classesName;
	}
	public void setClassesName(String classesName) {
		this.classesName = classesName;
	}
	public Boolean getType() {
		return type;
	}
	public void setType(Boolean type) {
		this.type = type;
	}
	
	@Override
	public String toString() {
		return "Classes [id=" + id + ", grede=" + grede + ", classesName=" + classesName + ", type=" + type + "]";
	}
	
}
