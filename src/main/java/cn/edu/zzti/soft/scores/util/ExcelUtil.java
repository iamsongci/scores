package cn.edu.zzti.soft.scores.util;

import java.io.IOException;
import java.text.DecimalFormat;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class ExcelUtil {
	/**
     * 获取单元格数据内容为字符串类型的数据
     * 
     * @param cell Excel单元格
     * @return String 单元格数据内容
	 * @throws Exception 
     */
	public static String getStringCellValue(HSSFCell cell) throws Exception {
		/**
		 * 1. 获取cell
		 * 2. 判断cell是否为null 抛出异常
		 * 3. 获取值并返回
		 */
		if(cell == null) 
			throw new Exception("存在空单元格!");
		String str = "";
		DecimalFormat df = new DecimalFormat("0");
		
		switch (cell.getCellType()) {
			case HSSFCell.CELL_TYPE_STRING:
				str = cell.getStringCellValue();
				break;
			case HSSFCell.CELL_TYPE_NUMERIC:
				str = String.valueOf(df.format(cell.getNumericCellValue()));
				break;
			case HSSFCell.CELL_TYPE_BOOLEAN:
				str = String.valueOf(cell.getBooleanCellValue());
				break;
			case HSSFCell.CELL_TYPE_BLANK:
				str = "";
				break;
			default:
				str = "";
				break;
		}
		if (str.trim().equals("") || str == null) {
			return "";
		}
		return str;
	}
	
	
	/**
	 * 判断是否是.xls文件
	 * @param name
	 * @throws Exception
	 */
	public static void isXls(String name) throws Exception {
		if(name.length() < 5) {
			throw new Exception("文件类型错误!");
		}
		if(! name.substring(name.length() - 4).equals(".xls")) {
			throw new Exception("文件类型错误!");
		}
	}
	
	/**
	 * 获取HSSFWorkbook
	 * @param teaInfo
	 * @return
	 * @throws IOException
	 */
	public static HSSFWorkbook getHSSFWorkbook(CommonsMultipartFile teaInfo) throws IOException {
		return new HSSFWorkbook(new POIFSFileSystem(teaInfo.getInputStream()));
	}
	
}
