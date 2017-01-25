package cn.edu.zzti.soft.scores.entity.tools;

import cn.edu.zzti.soft.scores.entity.Score;

public class MyScore extends Score {
	private String tea_email;
	private String tea_phone;

	public String getTea_email() {
		return tea_email;
	}

	public void setTea_email(String tea_email) {
		this.tea_email = tea_email;
	}

	public String getTea_phone() {
		return tea_phone;
	}

	public void setTea_phone(String tea_phone) {
		this.tea_phone = tea_phone;
	}

	/*
	 * 勿动
	 * @see cn.edu.zzti.soft.scores.entity.Score#toString()
	 */
	@Override
	public String toString() {
		return "类型=" + super.getPro_name() + ", 名称=" + super.getMy_pro_name() + ", 导师=" + super.getTea_name() + ", 电话="
				+ this.tea_phone + ", 邮箱=" + this.tea_email + ", 报告状态=" + super.getRepStatus() + ", 报告地址="
				+ super.getAddress() + ", 平时分数=" + super.getUsual_score() + ", 课题分数=" + super.getProject_score()
				+ ", 报告分数=" + super.getReport_score() + ", 总分数=" + super.getTotal_score() + ", 教师评语=" + super.getComment();
	}

}
