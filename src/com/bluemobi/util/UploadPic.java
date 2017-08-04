package com.bluemobi.util;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.bluemobi.conf.Config;
import com.bluemobi.controller.AbstractWebController;

/**
 * 上传
 * @author LiuChuang
 */
public class UploadPic extends AbstractWebController {

	private static final Logger log = LoggerFactory.getLogger(UploadPic.class.getName());

	/**
	 * 上传文件
	 * 如果多文件上传速度较快可能会出现同一时间传两个文件，更改文件名称是按照时间来算，名字相同会替换掉，所以cs为传来的参数，如for循环里的i
	 * ，单文件可传"" uploadFile 文件 fileSavePath 路径 ml ""为根目录下,否则为项目下
	 */
	public String userUp(CommonsMultipartFile uploadFile, String fileSavePath, String cs, String ml) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		String fileName = null;
		String saveFileName = null;
		if (!uploadFile.isEmpty()) {
			String base = request.getSession().getServletContext().getRealPath("") + "/";
			ml = "";// 存到根目录下
			if (ml.equals("")) {
				base = base.substring(0, base.indexOf("webapps") + 8);// 根目录下
			}
			base = base + fileSavePath + "/";
			// base = base.replaceAll("%20", " ");
			fileName = String.valueOf(new Date().getTime()) + cs;
			String savePath = base;
			savePath = savePath + File.separator;
			try {
				FileItem fi = uploadFile.getFileItem();
				fileName = this.getSaveFileName(fileName, fi.getName());
				File file = new File(base.substring(0, base.length() - 1)); // 新建一个文件
				if (!file.exists()) {
					file.mkdirs();
				}
				File file2 = new File(base + fileName);
				uploadFile.getFileItem().write(file2); // 将上传的文件写入新建的文件中
				// saveFileName = "\\"+fileSavePath + "\\" + fileName;
				saveFileName = "/" + fileSavePath + "/" + fileName;
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return saveFileName;
	}

	/**
	 * 改文件名称
	 */
	private String getSaveFileName(String fileName, String name) {
		// int strLength = name.lastIndexOf("\\");
		int i = name.lastIndexOf(".");
		return fileName + name.substring(i, name.length());
	}

	/**
	 * 上传服务器
	 * @param pic (图片本地路径)
	 */
	public String uppic(String pic) {
		String piclj = getTomcatPath() + pic;// 绝对路径
		int su = 0;
		try {
			System.out.println("==="+piclj);
			piclj = SFTPUtil.uploadFile(piclj, "train");
		} catch (Exception e) {
			su = 1;
			e.printStackTrace();
		}
		log.info("图片未上传服务器路径==============" + piclj);
		piclj = Config.IMG_URL + piclj;
		log.info("图片IP==============" + Config.IMG_URL);
		log.info("图片最终路径==============" + piclj);
		log.info("返回路径==============" + piclj + "," + su);
		return piclj + "," + su;
	}

}