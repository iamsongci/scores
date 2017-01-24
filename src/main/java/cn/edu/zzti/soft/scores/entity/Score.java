package cn.edu.zzti.soft.scores.entity;

public class Score {
	private Integer id;
	private Integer stu_id;
	private Integer tea_id;
	private Integer pro_id;
	private String tea_name;
	private String pro_name;
	private String my_pro_name;
	private Integer report_status;
	private String comment;
	private String address;
	private Integer usual_score;
	private Integer project_score;
	private Integer report_score;
	private Integer total_score;
	private Integer scores_status;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStu_id() {
		return stu_id;
	}
	public void setStu_id(Integer stu_id) {
		this.stu_id = stu_id;
	}
	public Integer getTea_id() {
		return tea_id;
	}
	public void setTea_id(Integer tea_id) {
		this.tea_id = tea_id;
	}
	public Integer getPro_id() {
		return pro_id;
	}
	public void setPro_id(Integer pro_id) {
		this.pro_id = pro_id;
	}
	public String getTea_name() {
		return tea_name;
	}
	public void setTea_name(String tea_name) {
		this.tea_name = tea_name;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getMy_pro_name() {
		return my_pro_name;
	}
	public void setMy_pro_name(String my_pro_name) {
		this.my_pro_name = my_pro_name;
	}
	public Integer getReport_status() {
		return report_status;
	}
	public void setReport_status(Integer report_status) {
		this.report_status = report_status;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getUsual_score() {
		return usual_score;
	}
	public void setUsual_score(Integer usual_score) {
		this.usual_score = usual_score;
	}
	public Integer getProject_score() {
		return project_score;
	}
	public void setProject_score(Integer project_score) {
		this.project_score = project_score;
	}
	public Integer getReport_score() {
		return report_score;
	}
	public void setReport_score(Integer report_score) {
		this.report_score = report_score;
	}
	public Integer getTotal_score() {
		return total_score;
	}
	public void setTotal_score(Integer total_score) {
		this.total_score = total_score;
	}
	public Integer getScores_status() {
		return scores_status;
	}
	public void setScores_status(Integer scores_status) {
		this.scores_status = scores_status;
	}
	@Override
	public String toString() {
		return "Score [id=" + id + ", stu_id=" + stu_id + ", tea_id=" + tea_id
				+ ", pro_id=" + pro_id + ", tea_name=" + tea_name
				+ ", pro_name=" + pro_name + ", my_pro_name=" + my_pro_name
				+ ", report_status=" + report_status + ", comment=" + comment
				+ ", address=" + address + ", usual_score=" + usual_score
				+ ", project_score=" + project_score + ", report_score="
				+ report_score + ", total_score=" + total_score
				+ ", scores_status=" + scores_status + "]";
	}
	
	
	
}
