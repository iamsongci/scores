package cn.edu.zzti.soft.scores.entity;

public class Classes {
	private Integer id;
	private Integer grade;
	private String classes_name;
	private Boolean type;  // 0：专科 1：本科
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getGrade() {
		return grade;
	}
	public void setGrade(Integer grade) {
		this.grade = grade;
	}
	public String getClasses_name() {
		return classes_name;
	}
	public void setClasses_name(String classes_name) {
		this.classes_name = classes_name;
	}
	public Boolean getType() {
		return type;
	}
	public void setType(Boolean type) {
		this.type = type;
	}
	@Override
	public String toString() {
		return "Classes [id=" + id + ", grede=" + grade + ", classes_name="
				+ classes_name + ", type=" + type + "]";
	}
	

}
