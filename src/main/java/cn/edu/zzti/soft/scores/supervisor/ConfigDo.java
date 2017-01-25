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

}
