package cn.edu.zzti.soft.scores.supervisor;

public interface ConfigDo {
    public final String AppsName = "实践课题管理系统";

    public final String AdminUser = "zzti00";
    public final String AdminPwd = "zzti00";
    public final String AdminName = "管理员";
    public final String AdminRole = "admin";
    
    /*
     * 一级导航栏
     */
    /**
     * 空页面
     */
	public static final String EMPTY="empty";
    /**
     * 首页
     */
	public static final String HOME="index";
	/**
	 * 个人信息维护
	 */
	public static final String MYINFO="myInfo";
	/**
	 * 教师端-课题组长权限
	 */
	public static final String MYPOWER="myPower";
	/**
	 * 超级管理员端-通知管理
	 */
	public static final String ADMINNOTIFY="notify";
	/**
	 * 超级管理员端-课题管理
	 */
	public static final String ADMINPROJECTS="projects";
	/**
	 * 超级管理员端-信息管理
	 */
	public static final String ADMININFO="info";
	
	
	/**
	 * 机房管理员端-通知管理
	 */
	public static final String ROOMNOTIFY="notify";
	/**
	 * 机房管理员端-机房管理
	 */
	public static final String ROOMROOMS="rooms";
	/**
	 * 机房管理员端-分配管理
	 */
	public static final String ROOMDISTRIBUTE="distribute";
	/**
	 * 机房管理员端-个人信息管理
	 */
	public static final String ROOMMYINFO="myInfo";
	
	
	/**
	 * 学生端-课题信息
	 */
	public static final String STUDENTSCORES="scores";
	/**
	 * 学生端-个人信息
	 */
	public static final String STUDENTINFO="myInfo";
	
	
	
	
	

}
