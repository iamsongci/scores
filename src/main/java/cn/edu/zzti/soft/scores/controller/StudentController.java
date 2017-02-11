package cn.edu.zzti.soft.scores.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.tools.MyScore;
import cn.edu.zzti.soft.scores.supervisor.ConfigDo;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
import cn.edu.zzti.soft.scores.supervisor.ServiceFit;
import cn.edu.zzti.soft.scores.util.MDUtil;

@Controller
@RequestMapping("/stu/")
public class StudentController implements ConfigDo {
	@Resource
	private ServiceFit serviceFit;

	@RequestMapping("home")
	public String homePage(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./student/myInfo";
		}
		
		ResultDo<?> resultDo = serviceFit.getNotifyService().getNotifiesByStu("" + identity.getId());
		List<?> notifies = null;
		if(resultDo.isSuccess()) {
			notifies = (List<?>)resultDo.getResult();
			model.addAttribute("notifies", notifies);
		}
		else {
			model.addAttribute("message", resultDo.getMessage());
		}

		model.addAttribute("menuSelected1", ConfigDo.HOME);
		return "./student/home";
	}

	// 功能未做实现-----空页面
	@RequestMapping("empty")
	public String empty(Model model) {
		model.addAttribute("menuSelected1", ConfigDo.EMPTY);
		return "./student/empty";
	}

	// 个人信息维护页面
	@RequestMapping("myInfo")
	public String myInfo(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		ResultDo resultDo = serviceFit.getLoginService().GetIdentityById(identity.getId());
		if (resultDo.isSuccess()) {
			Identity iden = (Identity) resultDo.getResult();
			session.setAttribute("user", iden);
		} else {
			model.addAttribute("message", resultDo.getMessage());
		}
		model.addAttribute("menuSelected1", ConfigDo.MYINFO);
		return "./student/myInfo";
	}

	@RequestMapping("myScores")
	public String myScores(Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (identity.getPhone() == null || identity.getPhone().trim().equals("")) {
			return "./student/myInfo";
		}
		ResultDo<List<MyScore>> resultDo = serviceFit.getStudentService().getMyScores(identity.getId());
		if (resultDo.isSuccess()) {
			model.addAttribute("scores", (List<MyScore>) resultDo.getResult());

		} else {
			model.addAttribute("message", "查询失败");
		}
		model.addAttribute("menuSelected1", ConfigDo.STUDENTSCORES);
		return "./student/myScores";
	}

	// 修改个人信息
	@RequestMapping("upMyInfo")
	public String upMyInfo(@RequestParam("sex") boolean sex, @RequestParam("phone") String phone,
			@RequestParam("email") String email, Model model, HttpSession session) {
		Identity identity = (Identity) session.getAttribute("user");
		if (phone != null) {
			identity.setSex(sex);
			identity.setPhone(phone);
			identity.setEmail(email);
			if (serviceFit.getLoginService().UpdateInfoByKey(identity)) {
				model.addAttribute("message", "信息修改成功");
			} else {
				model.addAttribute("message", "信息修改失败");
			}
		} else {
			model.addAttribute("message", "信息修改失败");
		}
		model.addAttribute("menuSelected1", ConfigDo.STUDENTINFO);
		return "redirect:./myInfo.do";
	}

	@RequestMapping("upProName")
	private String upProName(@RequestParam("index") String index, @RequestParam("newProName") String newProName,
			Model model, HttpSession session) {
		serviceFit.getStudentService().upProName(Integer.parseInt(index), newProName);
		model.addAttribute("menuSelected1", ConfigDo.STUDENTSCORES);
		return "redirect:./myScores.do";
	}
	
	@RequestMapping("getScore")
	public void getScore(@RequestParam("ID") Integer ID, Model model, HttpSession session, HttpServletResponse response) throws Exception{
		StringBuffer code = new StringBuffer();
		
		
		ResultDo<MyScore> resultDo = serviceFit.getStudentService().getScore(ID);
		MyScore score = null;
		if(resultDo.isSuccess()) {
			score = (MyScore)resultDo.getResult();
			code.append("<dl class='dl-horizontal'>")
				.append(getCode("课题类型", score.getPro_name()));
			if(score.getScores_status() != 2) {
				if(score.getMy_pro_name() != null)
					code.append("<dt>课题名称</dt><dd>" + score.getMy_pro_name() + "<button type='button' style='margin-left:20%' class='btn btn-primary btn-sm' data-toggle='modal' data-target='#changeMyProName' onclick='initOne(" + ID + ")' >修改我的课题名称</button></dd>");
				else
					code.append("<dt>课题名称</dt><dd>[暂无]<button type='button' style='margin-left:20%' class='btn btn-primary btn-sm' data-toggle='modal' data-target='#changeMyProName' onclick='initOne(" + ID + ")' >修改我的课题名称</button></dd>");
			}
			else {
				code.append(getCode("课题名称", score.getMy_pro_name()));
			}
			code.append(getCode("导师", score.getTea_name()))
			.append(getCode("报告状态", score.getRepStatus()))
			.append(getCode("报告名称", score.getAddress()))
			.append(getCode("平时分数", score.getUsual_score()))
			.append(getCode("课题分数", score.getProject_score()))
			.append(getCode("报告分数", score.getReport_score()))
			.append(getCode("总分数", score.getTotal_score()))
			.append(getCode("教师评语", score.getComment()));
			response.getWriter().write(code.toString());
		}
		else {
			model.addAttribute("message", "查询失败");
		}
		model.addAttribute("menuSelected1", ConfigDo.STUDENTSCORES);
		
	}
	
	private String getCode(String name, String value) {
		if(value == null || value.trim().equals("")) {
			return "<dt>" + name + "</dt><dd>[暂无]</dd>";
		}
		return "<dt>" + name + "</dt><dd>" + value + "</dd>";
	}
	
	private String getCode(String name, Integer value) {
		if(value == null) {
			return "<dt>" + name + "</dt><dd>[暂无]</dd>";
		}
		return "<dt>" + name + "</dt><dd>" + value + "</dd>";
	}
	
	@RequestMapping("updateStuPsd")
	public String resetStuPsw(@RequestParam("psw") String psw, Model model, HttpServletResponse response, HttpSession session)
			throws Exception {
		Identity identity = (Identity) session.getAttribute("user");
		serviceFit.getLoginService().updatePsw(identity.getId(), MDUtil.MD5Tools(psw));
		return "forward:./../logout.do";
	}
	
	//文件上传
	@RequestMapping(value="doUpload")
	public String doUploadFile(Model model,@RequestParam("file")MultipartFile file,HttpServletRequest request,
			@RequestParam("score_id")int score_id,@RequestParam("tea_id")int tea_id,
			@RequestParam("pro_id")int pro_id
			) throws IOException{
		if(!file.isEmpty()){
			String path =request.getSession().getServletContext().getRealPath(File.separator) ;
			String path2="studentReport\\"+tea_id+"\\"+pro_id+"\\";
			path=path+path2;
			String adress=file.getOriginalFilename();
			FileUtils.copyInputStreamToFile(file.getInputStream(), new File(path,adress));
			serviceFit.getStudentService().updateReport(score_id, 1, adress);
		}else{
			model.addAttribute("message","文件为空");
		}
		model.addAttribute("menuSelected1", ConfigDo.STUDENTSCORES);
		return "redirect:./myScores.do";
		
	}
	
	//文件下载
    @RequestMapping("download")    
    public void download(@RequestParam("id")int id, Model model, HttpServletRequest request
    		, HttpServletResponse response,HttpSession session) throws IOException {  
    	ResultDo<MyScore> resultDo = serviceFit.getStudentService().getScore(id);
		MyScore score = null;
			score = (MyScore)resultDo.getResult();
			String fileName=score.getAddress();
			String path =request.getSession().getServletContext().getRealPath(File.separator) ;
			String path2="studentReport\\"+score.getTea_id()+"\\"+score.getPro_id()+"\\";
			path=path+path2;
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			//fileName=new String(fileName.getBytes("iso8859-1"),"utf-8");
			System.out.println(fileName);
			
			try
			  {
			         response.setContentType("text/plain");
			         response.setHeader("Location",fileName);
			         response.setHeader("Content-Disposition", "attachment; filename=" +  new String( fileName.getBytes("gb2312"), "ISO8859-1" ) );
			         OutputStream outputStream = response.getOutputStream();
			         System.out.println(path+fileName);
			         InputStream inputStream = new FileInputStream(path+fileName);
			         byte[] buffer = new byte[1024];
			         int i = -1;
			         while ((i = inputStream.read(buffer)) != -1) {
			          outputStream.write(buffer, 0, i);
			         }
			         outputStream.flush();
			         outputStream.close();
			  }catch(FileNotFoundException e1)
			  {
			   System.out.println("没有找到您要的文件");
			  }
			  catch(Exception e)
			  {
			   System.out.println("系统错误，请及时与管理员联系");
			  }
			model.addAttribute("menuSelected1", ConfigDo.STUDENTSCORES);
    }   
	
	

}
