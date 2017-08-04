package com.bluemobi.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;


public class ImageUtil {
	
	FTPClient ftp=new FTPClient();
	public  boolean connect(String path,String addr,int port,String username,String password) throws Exception, IOException{
		
		Boolean result=false;
		int reply;
		System.out.println("-----连接前-----");
		ftp=new FTPClient();
		ftp.connect(addr, port);
		System.out.println("-----连接后-----");
		ftp.login(username, password);
		//设置上传文件的类型为二进制类型
		ftp.setFileType(FTPClient.BINARY_FILE_TYPE);
		reply=ftp.getReplyCode();
		if (!FTPReply.isPositiveCompletion(reply)) {
			ftp.disconnect();
			return result;
		}
		//设置上传路径
		ftp.changeWorkingDirectory(path);
		result=true;
		return result;
	}
	
	
	public void upload(File file) throws Exception{
		if (file.isDirectory()) {
			ftp.makeDirectory(file.getName());
			ftp.changeWorkingDirectory(file.getName());
			String[] files =file.list();
			for (int i = 0; i < files.length; i++) {
				File file1=new File(file.getPath()+"\\"+files[i]);
				if (file1.isDirectory()) {
					upload(file1);
					ftp.changeToParentDirectory();
				}
				else {
					File file2=new File(file.getPath()+"\\"+files[i]);
					FileInputStream input=new FileInputStream(file2);
					ftp.storeFile(file2.getName(), input);
					input.close();
				}
			}
			ftp.logout();
		}
		else {
			File file3=new File(""+file);
			FileInputStream input=new FileInputStream(file3);
			ftp.storeFile(file3.getName(), input);
			input.close();
			ftp.logout();
		}
	}
	

}
