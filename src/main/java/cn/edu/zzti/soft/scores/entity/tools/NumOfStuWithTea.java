package cn.edu.zzti.soft.scores.entity.tools;

public class NumOfStuWithTea {
	private int id;
	private String name;
	private String noid;
	private String role;
	private String phone;
	private int num;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNoid() {
		return noid;
	}
	public void setNoid(String noid) {
		this.noid = noid;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "NumOfStuWithTea [id=" + id + ", name=" + name + ", noid="
				+ noid + ", role=" + role + ", phone=" + phone + ", num=" + num
				+ "]";
	}
    	
   
}
