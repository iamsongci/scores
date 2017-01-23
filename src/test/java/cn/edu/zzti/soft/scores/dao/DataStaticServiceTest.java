//package cn.edu.zzti.soft.scores.dao;
//
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.context.ApplicationContext;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
//
//import cn.edu.zzti.soft.scores.entity.Identity;
//import cn.edu.zzti.soft.scores.supervisor.DaoFit;
//import cn.edu.zzti.soft.scores.supervisor.ResultDo;
//import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
//
//
//public class DataStaticServiceTest {
//
//    private DaoFit dao;
//    
//    private ServiceFit servicefit;
//
//	@Before
//	public void setUp() throws Exception {
//		ApplicationContext context = new ClassPathXmlApplicationContext(
//				new String[] { "classpath:conf/spring-sql.xml",
//						"classpath:conf/spring-mvc.xml" });
//		servicefit = (ServiceFit) context.getBean("serviceFit");
//	}
//	
//
//	
//	
//	@Test 
//	public void testLogin() {
//		ResultDo resultDo=new ResultDo();
//		resultDo=servicefit.getLoginService().Login("2222", "123456");//空指针异常
//		if(resultDo.isSuccess()){
//			System.out.println("成功！！！！！！！！！！！！！！！！！！");
//			Identity identity=(Identity)resultDo.getResult();
//			System.out.println(identity.toString());
//		}else{
//			System.out.println(resultDo.getMessage());
//		}
//	}
//	@Test 
//	public void UpdateInfoByKey() {
//		ResultDo resultDo=new ResultDo();
//		resultDo=servicefit.getLoginService().GetIdentityById(3);
//		if(resultDo.isSuccess()){
//			System.out.println("成功！！！！！！！！！！！！！！！！！！");
//			Identity identity=(Identity)resultDo.getResult();
//			identity.setPhone("123456789");
//			if(servicefit.getLoginService().UpdateInfoByKey(identity)){
//				System.out.println("更新数据成功");
//			}else{
//				System.out.println("失败！！！！");
//			}
//		}else{
//			System.out.println(resultDo.getMessage());
//		}
//	}
//}
