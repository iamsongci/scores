package cn.edu.zzti.soft.scores.entity;

public class Project {
	private Integer project_id;
	private String project_name;
	private String distribution_name;
	private Integer distribution_id;
	private String aggregate_name;
	private Integer aggregate_id;
	public Integer getProject_id() {
		return project_id;
	}
	public void setProject_id(Integer project_id) {
		this.project_id = project_id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getDistribution_name() {
		return distribution_name;
	}
	public void setDistribution_name(String distribution_name) {
		this.distribution_name = distribution_name;
	}
	public Integer getDistribution_id() {
		return distribution_id;
	}
	public void setDistribution_id(Integer distribution_id) {
		this.distribution_id = distribution_id;
	}
	public String getAggregate_name() {
		return aggregate_name;
	}
	public void setAggregate_name(String aggregate_name) {
		this.aggregate_name = aggregate_name;
	}
	public Integer getAggregate_id() {
		return aggregate_id;
	}
	public void setAggregate_id(Integer aggregate_id) {
		this.aggregate_id = aggregate_id;
	}
	@Override
	public String toString() {
		return "Project [project_id=" + project_id + ", project_name="
				+ project_name + ", distribution_name=" + distribution_name
				+ ", distribution_id=" + distribution_id + ", aggregate_name="
				+ aggregate_name + ", aggregate_id=" + aggregate_id + "]";
	}
	
}
