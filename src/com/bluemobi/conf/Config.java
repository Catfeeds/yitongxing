package com.bluemobi.conf;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.appcore.model.AbstractObject;

/**
 *  配置加载
 * @author haojian
 * Apr 27, 2012 3:21:26 PM
 * 加载在config.properties配置文件中配置的数据
 */
public class Config extends AbstractObject {
    
	private static final long serialVersionUID = 1L;

	private static final Logger LOGGER = LoggerFactory.getLogger(Config.class);

    private static String fileName = "config.properties";
    
    /**项目名*/
    public static String SITE_NAME;
    /**项目访问url*/
    public static String BASE_URL;
    /** 项目内部使用的静态资源，js库等 */
	public static String STATIC_URL;
    /**图片服务器地址，存放用户上传的图片、视频等*/
    public static String IMG_URL;
    
    /**FTP**/
	public static String FTP_HOST;
	public static String FTP_PORT;
	public static String FTP_USERNAME;
	public static String FTP_PASSWORD;
	public static String FTP_SAVE_PATH;
	
	/** Mob **/
	public static String MOB_APPKEY_Android;
	public static String MOB_APPKEY_IOS;
	
	/** 融云 **/
	public static String RONG_APPKEY;
	public static String RONG_APPSECRET;
	
	/**邮件**/
	public static String MAIL_SMTP; // 发送服务器
	public static String MAIL_POST; // 发信人
	public static String MAIL_USERNAME; // 账号
	public static String MAIL_PASSWORD; // 密码
	
	/* 用户端微信支付 */
	public static String Y_APPSECRET;
	public static String Y_APPID;
	public static String Y_MCHID;
	
	/* 翻译端微信支付 */
	public static String F_APPSECRET;
	public static String F_APPID;
	public static String F_MCHID;
	
	public static String ALIPAY_APPID; //支付宝appId
	public static String ALIPAY_PRIVATEKEY; // 商户的私钥
	public static String ALIPAY_PUBLICKEY; // 商户的公钥
	
	static {
		Config.loadConfig();
	}

	/**
	 * 加载config.properties文件
	 */
	private static void loadConfig() {
		Properties p = getProperties(fileName);
		SITE_NAME = p.getProperty("SITE_NAME");
		try {
			SITE_NAME = new String(SITE_NAME.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {}
		BASE_URL = p.getProperty("BASE_URL");
		STATIC_URL = p.getProperty("STATIC_URL");
		IMG_URL = p.getProperty("IMG_URL");
		
		FTP_HOST = p.getProperty("FTP_HOST");
		FTP_PORT = p.getProperty("FTP_PORT");
		FTP_USERNAME = p.getProperty("FTP_USERNAME");
		FTP_PASSWORD = p.getProperty("FTP_PASSWORD");
		FTP_SAVE_PATH = p.getProperty("FTP_SAVE_PATH");
		
		MAIL_SMTP = p.getProperty("MAIL_SMTP");
		MAIL_POST = p.getProperty("MAIL_POST");
		MAIL_USERNAME = p.getProperty("MAIL_USERNAME");
		MAIL_PASSWORD = p.getProperty("MAIL_PASSWORD");
		
		Y_APPSECRET = p.getProperty("y_appsecret");
		Y_APPID = p.getProperty("y_appid");
		Y_MCHID = p.getProperty("y_mchid");
		F_APPSECRET = p.getProperty("f_appsecret");
		F_APPID = p.getProperty("f_appid");
		F_MCHID = p.getProperty("f_mchid");
		
		ALIPAY_APPID = p.getProperty("Alipay_appId");
		ALIPAY_PRIVATEKEY = p.getProperty("Alipay_privateKey");
		ALIPAY_PUBLICKEY = p.getProperty("Alipay_publicKey");
		MOB_APPKEY_Android= p.getProperty("Mob_appKey_Android");
		MOB_APPKEY_IOS = p.getProperty("Mob_appKey_IOS");
		RONG_APPKEY = p.getProperty("Rong_appKey");
		RONG_APPSECRET =p.getProperty("Rong_appSecret");
	}
	
    /**
     * 读取propertity文件的方法
     */
    public static Properties getProperties(String fileName) {
        LOGGER.info("开始读取文件【{}】...", new Object[]{fileName});
        InputStream is = Config.class.getClassLoader().getResourceAsStream(fileName);
        Properties properties = new Properties();
        try {
            properties.load(is);
            if(is != null){
                is.close();
            }
        } catch (IOException e) {
            LOGGER.error("Exception:【{}】" + e);
        }
        LOGGER.info("读取文件【{}】结束...", new Object[]{fileName});
        return properties;
    }
    
}
