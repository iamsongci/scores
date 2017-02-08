package cn.edu.zzti.soft.scores.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import cn.edu.zzti.soft.scores.entity.Classes;
import cn.edu.zzti.soft.scores.entity.Identity;
import cn.edu.zzti.soft.scores.entity.Project;
import cn.edu.zzti.soft.scores.entity.tools.ClassAndNum;
import cn.edu.zzti.soft.scores.entity.tools.Grade;

@Repository
public interface AdminDao {
	
	@Select("SELECT * FROM project")
	List<Project> getProjects();
	
	@Select("SELECT * FROM identity WHERE identity.`role` = #{0} AND identity.`status` = '0'")
	List<Identity> getByRole(String role);
	
	@Select("SELECT * FROM identity WHERE identity.`role` != 'stu' AND identity.`status` = '0'")
	List<Identity> getAllTea();
	
	@Select("SELECT * FROM classes")
	List<Classes> getClasses();
	
	Integer addIdentity(List<Identity> identities);
	
	@Select("SELECT DISTINCT grade FROM classes")
	List<Grade> getGrades();
	
	Integer addClasses(List<Classes> classes);
	
	Integer delClass(List<String> IDs);
	
	Integer delIdentity(List<String> identities);
	
	@Update("UPDATE project SET distribution_id = #{1}, distribution_name = #{2} WHERE project_id = #{0}")
	Integer upDistr(Integer proID, Integer teaID, String teaName);
	
	@Update("UPDATE project SET aggregate_id = #{1}, aggregate_name = #{2} WHERE project_id = #{0}")
	Integer upAggre(Integer proID, Integer teaID, String teaName);
	
	@Update("UPDATE project SET distribution_id = NULL, distribution_name = NULL WHERE project_id = #{0}")
	Integer resetDistr(Integer proID);
	
	@Update("UPDATE project SET aggregate_id = NULL, aggregate_name = NULL WHERE project_id = #{0}")
	Integer resetAggre(Integer proID);
	
	Integer addProjects(List<String> projcets);
	
	@Select("SELECT * FROM identity WHERE role = 'stu' AND identity.`status` = '0' AND cla_id = #{0}")
	List<Identity> getStuByClaID(String claID);
	
	@Select("SELECT classes.*, temp2.cla_num FROM classes LEFT JOIN (SELECT cla_id, COUNT(cla_id) AS cla_num FROM (SELECT * FROM identity WHERE role = 'stu'  AND identity.`status` = '0') AS temp1 GROUP BY cla_id) AS temp2 ON temp2.cla_id = classes.`id`")
	List<ClassAndNum> getClassesAndNum();
}
