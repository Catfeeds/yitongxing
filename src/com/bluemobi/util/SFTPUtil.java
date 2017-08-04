package com.bluemobi.util;

import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.portlet.mvc.AbstractController;

import com.appcore.util.SftpUtil;
import com.bluemobi.conf.Config;

public class SFTPUtil {


	/**
	 * 图片上传SFTP方式
	 * @param localPath 本地图片绝对路径
	 * @param module 模块名
	 * @return
	 * @throws Exception
	 */
	public static String upload(String localPath, String filePath, String fileName, String suffix, int size) throws Exception {

		StringBuilder localFile = new StringBuilder();
		localFile.append(localPath);
		localFile.append(filePath);
		localFile.append(fileName);
		localFile.append(suffix);
		
		StringBuilder minPath = new StringBuilder();
		minPath.append(localPath);
		minPath.append(filePath);
		minPath.append(fileName);
		minPath.append("-min");
		minPath.append(suffix);
		
		SftpUtil.upload(Config.FTP_HOST, Short.parseShort(Config.FTP_PORT), Config.FTP_USERNAME, Config.FTP_PASSWORD,
				localFile.toString(), Config.FTP_SAVE_PATH + filePath, fileName + suffix);
		boolean tag = IconCompressUtil.compressImg(new File(localFile.toString()), size, new File(minPath.toString()));
		if(tag) {
			SftpUtil.upload(Config.FTP_HOST, Short.parseShort(Config.FTP_PORT), Config.FTP_USERNAME, Config.FTP_PASSWORD, 
					new FileInputStream(new File(minPath.toString())), Config.FTP_SAVE_PATH + filePath, fileName + "-min" + suffix);
		} else {
			SftpUtil.upload(Config.FTP_HOST, Short.parseShort(Config.FTP_PORT), Config.FTP_USERNAME, Config.FTP_PASSWORD, 
					localFile.toString(), Config.FTP_SAVE_PATH + filePath, fileName + "-min" + suffix);
		}
		StringBuilder url = new StringBuilder();
		url.append(filePath);
		url.append(fileName);
		url.append(suffix);
		url.append("###");
		url.append(filePath);
		url.append(fileName);
		url.append("-min");
		url.append(suffix);
		return url.toString();
	}
	
	/**
	 * 文件上传SFTP方式
	 * @param localPath 本地文件绝对路径
	 * @param module 模块名
	 * @return
	 * @throws Exception
	 */
	public static String uploadFile(String localPath, String module) throws Exception {
	
		String suffix = localPath.substring(localPath.lastIndexOf(".")).toLowerCase();
		
		String remoteDirectorys = "/upload/images/" + module + "/"
				+ new SimpleDateFormat("yyyy").format(new Date()) + "/"
				+ new SimpleDateFormat("MM").format(new Date()) + "/"
				+ new SimpleDateFormat("dd").format(new Date()) + "/";
	
		String remoteFileName = new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date()) + UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
		
		SftpUtil.upload(Config.FTP_HOST, Short.parseShort(Config.FTP_PORT), Config.FTP_USERNAME, Config.FTP_PASSWORD,
				localPath, Config.FTP_SAVE_PATH + remoteDirectorys, remoteFileName + suffix);
		
		return remoteDirectorys + remoteFileName + suffix;
	}
	
	/**
	 * 文件上传SFTP方式
	 */
	public static String uploadNoCompress(String localPath, String module) throws Exception {
		String suffix = localPath.substring(localPath.lastIndexOf(".")).toLowerCase();
		Calendar c = Calendar.getInstance();
		String remoteDirectorys = "/" + module + "/" + c.get(Calendar.YEAR) + "/" +
				(c.get(Calendar.MONTH) + 1) + "/" + c.get(Calendar.DAY_OF_MONTH) + "/";
		String remoteFileName = UUID.randomUUID().toString();
		SftpUtil.upload(Config.FTP_HOST, Short.parseShort(Config.FTP_PORT), Config.FTP_USERNAME, Config.FTP_PASSWORD,
				localPath, Config.FTP_SAVE_PATH + remoteDirectorys, remoteFileName + suffix);
		return remoteDirectorys + remoteFileName + suffix;
	}
	
	/**
	 * 上传用户文件
	 */
	public static String uploadFile(MultipartFile headfile,String filename) {
		try {
			if(headfile.isEmpty()) {
				return "2";
			} else {
				StringBuilder sb = new StringBuilder();
				String suffix = headfile.getOriginalFilename();
				suffix = suffix.substring(suffix.lastIndexOf(".")).toLowerCase();
	//				String suffixArray = ".gif,.jpg,.jpeg,.png";
	//				if(suffixArray.indexOf(suffix) < 0) {
	//					return ResultTO.newFailResultTO("只能上传【" + suffixArray + "】类型的图片", null);
	//				}
				Calendar c = Calendar.getInstance();
				sb.append("/versions/");
				sb.append(c.get(Calendar.YEAR));
				sb.append("/");
				sb.append(c.get(Calendar.MONTH) + 1);
				sb.append("/");
				sb.append(c.get(Calendar.DAY_OF_MONTH));
				sb.append("/");
				String fileName = CommonUtils.getUUID();
				File file = new File(getTomcatPath()+ sb.toString() + fileName + suffix);
				File dir = file.getParentFile();
				if (!dir.exists()) {
					dir.mkdirs();
				}
					FileCopyUtils.copy(headfile.getBytes(), file);
				String url = SFTPUtil.uploadNoCompress(file.getPath(), filename);//新路径
				return url;
			}
		} catch (Exception e) {
			return "1";
		}
	}
	
	/**
	 * 获取工程WebRoot绝对路径
	 */
	public static String getTomcatPath() {
		return AbstractController.class.getResource("/").getPath().substring(0, AbstractController.class.getResource("/").getPath().indexOf("webapps") +8);
	}
}