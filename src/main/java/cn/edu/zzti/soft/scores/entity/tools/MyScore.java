package cn.edu.zzti.soft.scores.entity.tools;

public class MyScore {
	private Integer id;
	private String proType;
	private String proName;
	private String teaName;
	private String teaPhone;
	private String teaEmail;
	private String proScore;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getProType() {
		return proType;
	}

	public void setProType(String proType) {
		this.proType = proType;
	}

	public String getProName() {
		return proName;
	}

	public void setProName(String proName) {
		this.proName = proName;
	}

	public String getTeaName() {
		return teaName;
	}

	public void setTeaName(String teaName) {
		this.teaName = teaName;
	}

	public String getTeaPhone() {
		return teaPhone;
	}

	public void setTeaPhone(String teaPhone) {
		this.teaPhone = teaPhone;
	}

	public String getTeaEmail() {
		return teaEmail;
	}

	public void setTeaEmail(String teaEmail) {
		this.teaEmail = teaEmail;
	}

	public String getProScore() {
		return proScore;
	}

	public void setProScore(String proScore) {
		this.proScore = proScore;
	}

	@Override
	public String toString() {
		return "Scores [proType=" + proType + ", proName=" + proName + ", teaName=" + teaName + ", teaPhone=" + teaPhone
				+ ", teaEmail=" + teaEmail + ", proScore=" + proScore + "]";
	}

}
