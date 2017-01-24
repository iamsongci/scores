package cn.edu.zzti.soft.scores.entity;

public class Abnormal {
	private Integer id;
	private Integer stuID;
	private Integer teaID;
	private String problem;
	private String means;
	private String abnormalStatus;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getStuID() {
		return stuID;
	}
	public void setStuID(Integer stuID) {
		this.stuID = stuID;
	}
	public Integer getTeaID() {
		return teaID;
	}
	public void setTeaID(Integer teaID) {
		this.teaID = teaID;
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
	public String getAbnormalStatus() {
		return abnormalStatus;
	}
	public void setAbnormalStatus(String abnormalStatus) {
		this.abnormalStatus = abnormalStatus;
	}
	@Override
	public String toString() {
		return "Abnormal [id=" + id + ", stuID=" + stuID + ", teaID=" + teaID + ", problem=" + problem + ", means="
				+ means + ", abnormalStatus=" + abnormalStatus + "]";
	}
	
	
	
}
