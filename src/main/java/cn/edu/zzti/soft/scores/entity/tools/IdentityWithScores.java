package cn.edu.zzti.soft.scores.entity.tools;

import cn.edu.zzti.soft.scores.entity.Identity;

public class IdentityWithScores extends Identity {
	Integer score_id;
	private Integer stu_id;
	private Integer tea_id;
	private String tea_name;
	private Integer pro_id;
	private String pro_name;
	private String my_pro_name;
	private Integer usual_score;
	private Integer project_score;
	private Integer report_score;
	private Integer total_score;
	private Integer scores_status;
	public Integer getScore_id() {
		return score_id;
	}
	public void setScore_id(Integer score_id) {
		this.score_id = score_id;
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
	
	public String getTea_name() {
		return tea_name;
	}
	public void setTea_name(String tea_name) {
		this.tea_name = tea_name;
	}
	public Integer getPro_id() {
		return pro_id;
	}
	public void setPro_id(Integer pro_id) {
		this.pro_id = pro_id;
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
		return "IdentityWithScores [score_id=" + score_id + ", stu_id="
				+ stu_id + ", tea_id=" + tea_id + ", tea_name=" + tea_name
				+ ", pro_id=" + pro_id + ", pro_name=" + pro_name
				+ ", my_pro_name=" + my_pro_name + ", usual_score="
				+ usual_score + ", project_score=" + project_score
				+ ", report_score=" + report_score + ", total_score="
				+ total_score + ", scores_status=" + scores_status + "]";
	}
    
	
	

}
