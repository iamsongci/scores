package cn.edu.zzti.soft.scores.entity;

public class Score {
	private Integer id;
	private Integer stuID;
	private Integer teaID;
	private Integer proID;
	private String teaName;
	private String proName;
	private String myProName;
	private Integer reportStatus;
	private String comment;
	private String address;
	private Integer usualScore;
	private Integer projectScore;
	private Integer reportScore;
	private Integer totalScore;
	private Integer scoresStatus;
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
	public Integer getProID() {
		return proID;
	}
	public void setProID(Integer proID) {
		this.proID = proID;
	}
	public String getTeaName() {
		return teaName;
	}
	public void setTeaName(String teaName) {
		this.teaName = teaName;
	}
	public String getProName() {
		return proName;
	}
	public void setProName(String proName) {
		this.proName = proName;
	}
	public String getMyProName() {
		return myProName;
	}
	public void setMyProName(String myProName) {
		this.myProName = myProName;
	}
	public Integer getReportStatus() {
		return reportStatus;
	}
	public void setReportStatus(Integer reportStatus) {
		this.reportStatus = reportStatus;
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
	public Integer getUsualScore() {
		return usualScore;
	}
	public void setUsualScore(Integer usualScore) {
		this.usualScore = usualScore;
	}
	public Integer getProjectScore() {
		return projectScore;
	}
	public void setProjectScore(Integer projectScore) {
		this.projectScore = projectScore;
	}
	public Integer getReportScore() {
		return reportScore;
	}
	public void setReportScore(Integer reportScore) {
		this.reportScore = reportScore;
	}
	public Integer getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(Integer totalScore) {
		this.totalScore = totalScore;
	}
	public Integer getScoresStatus() {
		return scoresStatus;
	}
	public void setScoresStatus(Integer scoresStatus) {
		this.scoresStatus = scoresStatus;
	}
	@Override
	public String toString() {
		return "Score [id=" + id + ", stuID=" + stuID + ", teaID=" + teaID + ", proID=" + proID + ", teaName=" + teaName
				+ ", proName=" + proName + ", myProName=" + myProName + ", reportStatus=" + reportStatus + ", comment="
				+ comment + ", address=" + address + ", usualScore=" + usualScore + ", projectScore=" + projectScore
				+ ", reportScore=" + reportScore + ", totalScore=" + totalScore + ", scoresStatus=" + scoresStatus
				+ "]";
	}
	
	
	
}
