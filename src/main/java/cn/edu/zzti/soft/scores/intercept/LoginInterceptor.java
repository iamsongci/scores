package cn.edu.zzti.soft.scores.intercept;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.zzti.soft.scores.entity.Identity;

@Repository
public class LoginInterceptor implements HandlerInterceptor {
	
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("进入afterCompletion方法");
		
	}
	public void postHandle(HttpServletRequest arg0, HttpServletResponse response,
			Object arg2, ModelAndView arg3) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("ִ进入postHandle方法");
		
		
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		   Identity identity = (Identity) request.getSession().getAttribute("user");
		   if (identity == null){
	            response.sendRedirect(request.getContextPath());
	            return false;
	        }
	            return true;  
	}

}
