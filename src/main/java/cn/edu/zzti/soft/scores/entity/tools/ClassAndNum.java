package cn.edu.zzti.soft.scores.entity.tools;

import cn.edu.zzti.soft.scores.entity.Classes;

public class ClassAndNum extends Classes {
	int cla_num;

	public int getCla_num() {
		return cla_num;
	}

	public void setCla_num(int cla_num) {
		this.cla_num = cla_num;
	}

	@Override
	public String toString() {
		return "ClassAndNum [cla_num=" + cla_num + "]";
	}
	
	
}
