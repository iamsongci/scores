package cn.edu.zzti.soft.scores.entity;

public class Identity {
	private Integer id;// 我们在查询修改时需要使用此id，作为主键效率更改。
	private String noid;// 主要用于登陆和学号信息的显示
	private String name;
	private Boolean sex;// 0：男 1：女
	private String psw;// 在进行学生信息导入时不需要设置此值，数据库默认为123456
	private String phone;
	private String email;
	private String role;// 角色只有 stu/tea/room/edu[admin不算在这里]
	private Integer cla_id;// 班级id
	private String cla_name;// 班级名称
	private Integer status;// 0：表示正常状态 -1表示删除状态

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNoid() {
		return noid;
	}

	public void setNoid(String noid) {
		this.noid = noid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getSex() {
		return sex;
	}

	public void setSex(Boolean sex) {
		this.sex = sex;
	}

	public String getPsw() {
		return psw;
	}

	public void setPsw(String psw) {
		this.psw = psw;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Integer getCla_id() {
		return cla_id;
	}

	public void setCla_id(Integer cla_id) {
		this.cla_id = cla_id;
	}

	public String getCla_name() {
		return cla_name;
	}

	public void setCla_name(String cla_name) {
		this.cla_name = cla_name;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return noid;
	}

}
