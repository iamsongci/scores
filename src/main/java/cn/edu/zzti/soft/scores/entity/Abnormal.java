package cn.edu.zzti.soft.scores.entity;

public class Abnormal {
	private Integer id;
	private Integer stu_id;
	private Integer tea_id;
	private String problem;
	private String means;
	private String abnormal_status;
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
	public String getProblem() {
		return problem;
	}
	public void setProblem(String problem) {
		this.problem = problem;
	}
	public String getMeans() {
		return means;
	}
	public void setMeans(String means) {
		this.means = means;
	}
	public String getAbnormal_status() {
		return abnormal_status;
	}
	public void setAbnormal_status(String abnormal_status) {
		this.abnormal_status = abnormal_status;
	}
	@Override
	public String toString() {
		return "Abnormal [id=" + id + ", stu_id=" + stu_id + ", tea_id="
				+ tea_id + ", problem=" + problem + ", means=" + means
				+ ", abnormal_status=" + abnormal_status + "]";
	}
	
	
	
	
}
