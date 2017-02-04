package cn.edu.zzti.soft.scores.entity.tools;

import cn.edu.zzti.soft.scores.entity.Classes;

public class NumOfClasses extends Classes {
   private int num;

public int getNum() {
	return num;
}

public void setNum(int num) {
	this.num = num;
}

@Override
public String toString() {
	return "NumOfClasses [num=" + num + "]";
}
   
}
