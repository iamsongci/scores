package cn.edu.zzti.soft.scores.entity;

public class Project {
	private Integer projectID;
	private String projectName;
	private String distributionName;
	private Integer distributionID;
	private String aggregateName;
	private Integer aggregateID;
	public Integer getProjectID() {
		return projectID;
	}
	public void setProjectID(Integer projectID) {
		this.projectID = projectID;
	}
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getDistributionName() {
		return distributionName;
	}
	public void setDistributionName(String distributionName) {
		this.distributionName = distributionName;
	}
	public Integer getDistributionID() {
		return distributionID;
	}
	public void setDistributionID(Integer distributionID) {
		this.distributionID = distributionID;
	}
	public String getAggregateName() {
		return aggregateName;
	}
	public void setAggregateName(String aggregateName) {
		this.aggregateName = aggregateName;
	}
	public Integer getAggregateID() {
		return aggregateID;
	}
	public void setAggregateID(Integer aggregateID) {
		this.aggregateID = aggregateID;
	}
	@Override
	public String toString() {
		return "Project [projectID=" + projectID + ", projectName=" + projectName + ", distributionName="
				+ distributionName + ", distributionID=" + distributionID + ", aggregateName=" + aggregateName
				+ ", aggregateID=" + aggregateID + "]";
	}
	
}
