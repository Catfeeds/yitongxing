package com.bluemobi.util;

import java.io.*;

import java.net.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.appcore.util.StringUtil;

import java.io.UnsupportedEncodingException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * WebService方式发送短信公共类
 * @author heweiwen
 * 2015-7-13 下午2:07:47
 */
public class MessageSendClient {

    private static final Logger LOGGER = LoggerFactory.getLogger(MessageSendClient.class);
    
    /*
     * webservice服务器定义
     */
    private String serviceURL = "";

    private String sn = "";// 序列号

    private String pwd = "";// 密码
    
    /**
     * 构造函数
     * @param sn
     * @param password
     * @param serviceURL
     * @throws UnsupportedEncodingException
     */
    public MessageSendClient(String sn, String password,String serviceURL)
            throws UnsupportedEncodingException {
        this.sn = sn;
        this.serviceURL = serviceURL;
        this.pwd = StringUtil.md5(sn + password);
    }

    /**
     * webService消息组装
     * @author HeWeiwen
     * 2015-7-10
     * @param mobile 发送对象手机号
     * @param content 短信内容
     * @param ext 后缀扩展码
     * @param stime 定时发送时间
     * @param rrid 唯一标识
     * @param msgfmt 内容编码 （0：ASCII串,3：短信写卡操作,4：二进制信息,8：UCS2编码,空或15：含GB汉字.）
     * @return 返 回 值（唯一标识，如果不填写rrid将返回系统生成的）
     */
    public String mdsmssend(String mobile, String content, String ext, String stime,String rrid,String msgfmt) {
        String result = "";
        String soapAction = "http://entinfo.cn/mdsmssend";
        String xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
        xml += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">";
        xml += "<soap:Body>";
        xml += "<mdsmssend  xmlns=\"http://entinfo.cn/\">";
        xml += "<sn>" + sn + "</sn>";
        xml += "<pwd>" + pwd + "</pwd>";
        xml += "<mobile>" + mobile + "</mobile>";
        xml += "<content>" + content + "</content>";
        xml += "<ext>" + ext + "</ext>";
        xml += "<stime>" + stime + "</stime>";
        xml += "<rrid>" + rrid + "</rrid>";
        xml += "<msgfmt>" + msgfmt + "</msgfmt>";
        xml += "</mdsmssend>";
        xml += "</soap:Body>";
        xml += "</soap:Envelope>";
        
        try {
            URL url = new URL(serviceURL);

            URLConnection connection = url.openConnection();
            HttpURLConnection httpconn = (HttpURLConnection) connection;
            ByteArrayOutputStream bout = new ByteArrayOutputStream();
            bout.write(xml.getBytes());
            byte[] b = bout.toByteArray();
            httpconn.setRequestProperty("Content-Length", String
                    .valueOf(b.length));
            httpconn.setRequestProperty("Content-Type",
                    "text/xml; charset=utf-8");
            httpconn.setRequestProperty("SOAPAction", soapAction);
            httpconn.setRequestMethod("POST");
            httpconn.setDoInput(true);
            httpconn.setDoOutput(true);

            OutputStream out = httpconn.getOutputStream();
            out.write(b);
            out.close();
            InputStreamReader isr = new InputStreamReader(httpconn.getInputStream());
            BufferedReader in = new BufferedReader(isr);
            String inputLine;
            while (null != (inputLine = in.readLine())) {
                Pattern pattern = Pattern.compile("<mdsmssendResult>(.*)</mdsmssendResult>");
                Matcher matcher = pattern.matcher(inputLine);
                while (matcher.find()) {
                    result = matcher.group(1);
                }
            }
            return result;
        } catch (Exception e) {
            LOGGER.error("Exception:【{}】",e);
            return "";
        }
    }
    
}
