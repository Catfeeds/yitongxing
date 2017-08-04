package com.bluemobi.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.security.SignatureException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.SortedMap;

import org.apache.commons.codec.digest.DigestUtils;

import com.bluemobi.conf.Config;

public class WXPayUtil {

	/**
	 * 用户端将传入的参数进行MD5加密
	 * @param signParams
	 * @return
	 * @throws Exception
	 */
	public static String createMD5SignY(SortedMap<String, Object> signParams) throws Exception {
		StringBuffer sb = new StringBuffer(sortParams(signParams));
		String params = sb.append("&key=").append(Config.Y_APPSECRET).toString();
		return DigestUtils.md5Hex(getContentBytes(params, "UTF-8")).toUpperCase();
	}
	
	/**
	 * 翻译端将传入的参数进行MD5加密
	 * @param signParams
	 * @return
	 * @throws Exception
	 */
	public static String createMD5SignF(SortedMap<String, Object> signParams) throws Exception {
		StringBuffer sb = new StringBuffer(sortParams(signParams));
		String params = sb.append("&key=").append(Config.F_APPSECRET).toString();
		return DigestUtils.md5Hex(getContentBytes(params, "UTF-8")).toUpperCase();
	}
	
	/**
	 * @param signParams
	 * @return
	 * @throws Exception
	 */
	public static String sortParams(SortedMap<String, Object> signParams) {
		StringBuffer sb = new StringBuffer();
		Set<Entry<String, Object>> set = signParams.entrySet();
		Iterator<Entry<String, Object>> it = set.iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String k = (String) entry.getKey();
			String v = (String) entry.getValue();
			sb.append(k + "=" + v + "&");
			//要采用URLENCODER的原始值！
		}
		return sb.substring(0, sb.length() - 1);
	}
	
	/**
     * @param content
     * @param charset
     * @return
     * @throws SignatureException
     * @throws UnsupportedEncodingException 
     */
    private static byte[] getContentBytes(String content, String charset) {
        if (charset == null || "".equals(charset)) {
            return content.getBytes();
        }
        try {
            return content.getBytes(charset);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("MD5签名过程中出现错误,指定的编码集不对,您目前指定的编码集是:" + charset);
        }
    }
    
    public static String post(String url_, String xml) throws UnsupportedEncodingException {
    	StringBuilder sb = new StringBuilder();
    	try {
            URL url = new URL(url_);
            URLConnection con = url.openConnection();
            con.setDoOutput(true);
            con.setRequestProperty("Pragma:", "no-cache");
            con.setRequestProperty("Cache-Control", "no-cache");
            con.setRequestProperty("Content-Type", "text/xml");
            OutputStreamWriter out = new OutputStreamWriter(con.getOutputStream());
            out.write(new String(xml.getBytes("UTF-8")));
            out.flush();  
            out.close();  
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));  
            String line = "";
            for (line = br.readLine(); line != null; line = br.readLine()) {
            	sb.append(line);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    	return new String(sb.toString().getBytes(), "UTF-8");
    }
    
}