package cn.edu.zzti.soft.scores.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.Score;
import cn.edu.zzti.soft.scores.entity.TeaRoom;
import cn.edu.zzti.soft.scores.entity.tools.IdentityWithScores;
import cn.edu.zzti.soft.scores.entity.tools.NumOfClasses;
import cn.edu.zzti.soft.scores.entity.tools.NumOfStuWithTea;
import cn.edu.zzti.soft.scores.service.TeacherService;
import cn.edu.zzti.soft.scores.supervisor.DaoFit;
import cn.edu.zzti.soft.scores.supervisor.ResultDo;
@Service("TeacherService")
public class TeacherServiceImpl implements TeacherService {
	private static final Integer FALSE = 0;
	@Resource
	 DaoFit daoFit;
	@Override
	public ResultDo<List<Project>> getPowerById(int id) {
		// TODO Auto-generated method stub
		ResultDo<List<Project>> resultDo=new ResultDo<List<Project>>();
		if(id>0){
			List<Project> list =daoFit.getTeacherDao().getPowerById(id);	
			if(list.size()>0){
				resultDo.setResult(list);
				resultDo.setSuccess(true);
	        }else{
	        	resultDo.setMessage("该人员无权限！！");
	        }
		}
		return resultDo;
	}
	@Override
	public ResultDo chooseTeacher(int pro_id) {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfStuWithTea>> resultDo=new ResultDo<List<NumOfStuWithTea>>();
		List<NumOfStuWithTea> list =daoFit.getTeacherDao().chooseTeacher(pro_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无人员信息，请联系超级管理员进行导入！！");
		}
		return resultDo;
	}
	@Override
	public ResultDo chooseClasses() {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfClasses>> resultDo=new ResultDo<List<NumOfClasses>>();
		List<NumOfClasses> list =daoFit.getTeacherDao().chooseClasses();
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无班级信息，请联系超级管理员进行导入！！");
		}
		return resultDo;
	}
	@Override
	public ResultDo teaWithStu(int tea_id, int pro_id) {
		// TODO Auto-generated method stub
		ResultDo<List<IdentityWithScores>> resultDo=new ResultDo<List<IdentityWithScores>>();
		List<IdentityWithScores> list =daoFit.getTeacherDao().teaWithStu(tea_id, pro_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无分配信息，请进行分配！！");
		}
		return resultDo;
	}
	@Override
	public boolean delTeaWithStu(Integer score_id) {
		// TODO Auto-generated method stub
		if(score_id!=null){
		   return FALSE != daoFit.getTeacherDao().delTeaWithStu(score_id);
		}else{
			return false;
		}
		
	}
	@Override
	public ResultDo selectStuByClassId(Integer class_id,Integer pro_id) {
		// TODO Auto-generated method stub
		ResultDo<List<Identity>> resultDo=new ResultDo<List<Identity>>();
		List<Identity> list=new ArrayList<Identity>();
		if(class_id!=null){
			if(pro_id!=null){
				list=daoFit.getTeacherDao().selectStuByClassId(class_id,pro_id);
			}else{
				list=daoFit.getTeacherDao().selectStuByClassId(class_id,null);
			}
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无学生信息，请联系超级管理员进行导入！！");
		}
		}else{
			resultDo.setMessage("查询异常！！！");
		}
		return resultDo;
	}
	@Override
	public boolean addTeaWithStu(Integer tea_id,Integer pro_id,Integer[] stuIdList,String teaName,String proName) {
		// TODO Auto-generated method stub
		boolean isSuccess=false;
		if(tea_id!=null&&pro_id!=null&&stuIdList!=null&&teaName!=null&&proName!=null){
			List<Score> scList=new ArrayList<Score>();
			
			for(Integer stu_id:stuIdList){
				    Score score=new Score();
					score.setStu_id(stu_id);
					score.setTea_id(tea_id);
					score.setPro_id(pro_id);
					score.setTea_name(teaName);
					score.setPro_name(proName);
					scList.add(score);
			}
			if(scList.size()!=0)
				isSuccess= (FALSE != daoFit.getTeacherDao().addTeaWithStu(scList));
		}
		return isSuccess;
	}
	@Override
	public ResultDo selectClaByProId(Integer pro_id) {
		// TODO Auto-generated method stub
		ResultDo<List<NumOfClasses>> resultDo=new ResultDo<List<NumOfClasses>>();
		List<NumOfClasses> list =daoFit.getTeacherDao().selectClaByProId(pro_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无班级信息，请联系该课题分配组长进行分配！！");
		}
		return resultDo;
	}
	@Override
	public ResultDo proStuScore(Integer cla_id, Integer pro_id) {
		// TODO Auto-generated method stub
		ResultDo<List<IdentityWithScores>> resultDo=new ResultDo<List<IdentityWithScores>>();
		List<IdentityWithScores> list =daoFit.getTeacherDao().proStuScore(cla_id, pro_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("无分配信息，请联系分配课题组长进行分配！！");
		}
		return resultDo;
	}
	@Override
	public boolean updateStuScore(int score_id, int usual_score, int pro_score,
			int report_score,int scores_status) {
		// TODO Auto-generated method stub
		       int total_score=(int) Math.round(usual_score*0.3+pro_score*0.3+report_score*0.4);
			   return FALSE != daoFit.getTeacherDao().updateStuScore(score_id, usual_score, pro_score, report_score, total_score,scores_status);
	}
	@Override
	public ResultDo myStudent(int tea_id) {
		// TODO Auto-generated method stub
		ResultDo<List<IdentityWithScores>> resultDo=new ResultDo<List<IdentityWithScores>>();
		List<IdentityWithScores> list =daoFit.getTeacherDao().myStudent(tea_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("没有学生信息！！！");
		}
		return resultDo;
	}
	@Override
	public ResultDo myStudentScore(int tea_id) {
		// TODO Auto-generated method stub
		ResultDo<List<IdentityWithScores>> resultDo=new ResultDo<List<IdentityWithScores>>();
		List<IdentityWithScores> list =daoFit.getTeacherDao().myStudentScore(tea_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("没有学生信息！！！");
		}
		return resultDo;
	}
	@Override
	public boolean putStudentScore(int tea_id) {
		// TODO Auto-generated method stub
		return FALSE != daoFit.getTeacherDao().putStudentScore(tea_id);
	}
	@Override
	public ResultDo myMrInfo(int tea_id) {
		// TODO Auto-generated method stub
		ResultDo<List<TeaRoom>> resultDo=new ResultDo<List<TeaRoom>>();
		List<TeaRoom> list=daoFit.getTeacherDao().myMrInfo(tea_id);
		if(list.size()>0){
			resultDo.setResult(list);
			resultDo.setSuccess(true);
		}else{
			resultDo.setMessage("未分配机房信息！");
		}
		return resultDo;
	}
	@Override
	public boolean updateRepStatus(int id, int report_status, String comment) {
		// TODO Auto-generated method stub
		return FALSE != daoFit.getStudentDao().updateReport(id, report_status, comment);
	}
	@Override
	public HSSFWorkbook exportProStuScore(List<IdentityWithScores> list,Integer num) {
		String[] excelHeader = { "学生信息ID请勿修改","学号", "姓名","总成绩"};
		// TODO Auto-generated method stub
		 HSSFWorkbook wb = new HSSFWorkbook();  
	        HSSFSheet sheet = wb.createSheet("IdentityWithScores"); 
	        HSSFRow row = sheet.createRow((int) 0);  
	        HSSFCellStyle style = wb.createCellStyle();  
	        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);  
	        int n=1;
	        if(num==1){
	        	for (int i = 0; i <3; i++) {  
		            HSSFCell cell = row.createCell(i);  
		            cell.setCellValue(excelHeader[i+1]);  
		            cell.setCellStyle(style);  
		            sheet.autoSizeColumn(i);  
		            sheet.setColumnWidth(i, 20 * 256);  
		        }  
	        }else{
	        	for (int i = 0; i < excelHeader.length; i++) {  
		            HSSFCell cell = row.createCell(i);  
		            cell.setCellValue(excelHeader[i]);  
		            cell.setCellStyle(style);  
		            sheet.autoSizeColumn(i);  
		            sheet.setColumnWidth(i, 20 * 256);  
		        }  
	        }
	        
	        for (int i = 0; i < list.size(); i++) {
	            IdentityWithScores lws = list.get(i); 
	            if(num==1){
	            	
	            	 row = sheet.createRow(i + 1);  
	            	row.createCell(0).setCellValue(lws.getNoid());  
		            row.createCell(1).setCellValue(lws.getName()); 
		            if(lws.getScores_status()!=null&&lws.getScores_status()==2){
		            	 row.createCell(2).setCellValue(lws.getTotal_score());  
		            }else{
		            	 row.createCell(2).setCellValue("无");  
		            }
	            }else{
	            	if(lws.getTotal_score()==null&&lws.getTea_id()!=null){
	            		 row = sheet.createRow(n); 
	            		 row.createCell(0).setCellValue(lws.getScore_id()); 
	            		row.createCell(1).setCellValue(lws.getNoid());  
			            row.createCell(2).setCellValue(lws.getName());
			            n=n+1;
			           
	            	}
	            }
	            
	           
	        }  
	        return wb;
		
	}
	@Override
	public boolean importProStuScore(List<Score> list) {
		// TODO Auto-generated method stub
		return FALSE != daoFit.getTeacherDao().importProStuScore(list);
	}
	
}
