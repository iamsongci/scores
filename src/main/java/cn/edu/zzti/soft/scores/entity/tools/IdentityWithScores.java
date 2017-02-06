package cn.edu.zzti.soft.scores.entity.tools;

import cn.edu.zzti.soft.scores.entity.Identity;

public class IdentityWithScores extends Identity {
	Integer score_id;
	private Integer stu_id;
	private Integer tea_id;
	private Integer pro_id;
	private String pro_name;
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
	@Override
	public String toString() {
		return "IdentityWithScores [score_id=" + score_id + ", stu_id="
				+ stu_id + ", tea_id=" + tea_id + ", pro_id=" + pro_id
				+ ", pro_name=" + pro_name + "]";
	}
	

}
