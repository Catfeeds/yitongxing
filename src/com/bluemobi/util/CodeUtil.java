package com.bluemobi.util;

import java.io.DataOutputStream;
import java.net.URL;
import java.nio.charset.Charset;
import java.security.SecureRandom;

import org.apache.commons.httpclient.util.HttpURLConnection;

import com.sun.net.ssl.HostnameVerifier;
import com.sun.net.ssl.HttpsURLConnection;
import com.sun.net.ssl.SSLContext;
import com.sun.net.ssl.TrustManager;

public class CodeUtil {
	
//	  public static void main(String[] args) throws Exception {
//
//			String result = requestData("https://webapi.sms.mob.com/sms/verify",
//	 "appkey=xxxx&phone=xxx&zone=xx&&code=xx");
//	        System.out.println(result);
//		}
//
//		/**
//		 * 发起https 请求
//		 * @param address
//		 * @param m
//		 * @return
//		 */
//		public  static String requestData(String address ,String params){
//
//			HttpURLConnection conn = null;
//			try {
//			// Create a trust manager that does not validate certificate chains
//			TrustManager[] trustAllCerts = new TrustManager[]{new X509TrustManager(){
//			    public X509Certificate[] getAcceptedIssuers(){return null;}
//			    public void checkClientTrusted(X509Certificate[] certs, String authType){}
//			    public void checkServerTrusted(X509Certificate[] certs, String authType){}
//			}};
//
//			// Install the all-trusting trust manager
//		    SSLContext sc = SSLContext.getInstance("TLS");
//		    sc.init(null, trustAllCerts, new SecureRandom());
//
//		    //ip host verify
//		    HostnameVerifier hv = new HostnameVerifier() {
//		         public boolean verify(String urlHostName, SSLSession session) {
//		         return urlHostName.equals(session.getPeerHost());
//		         }
//		    };
//
//		    //set ip host verify
//			HttpsURLConnection.setDefaultHostnameVerifier(hv);
//
//			HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
//
//			URL url = new URL(address);
//			conn = (HttpURLConnection) url.openConnection();
//			conn.setRequestMethod("POST");// POST
//			conn.setConnectTimeout(3000);
//			conn.setReadTimeout(3000);
//			// set params ;post params 
//			if (params!=null) {
//				conn.setDoOutput(true);
//				DataOutputStream out = new DataOutputStream(conn.getOutputStream());
//				out.write(params.getBytes(Charset.forName("UTF-8")));
//				out.flush();
//				out.close();
//			}
//			conn.connect();
//			//get result 
//			if (conn.getResponseCode() == HttpURLConnection.HTTP_OK) {
//				String result = parsRtn(conn.getInputStream());
//				return result;
//			} else {
//				System.out.println(conn.getResponseCode() + " "+ conn.getResponseMessage());
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			if (conn != null)
//				conn.disconnect();
//		}
//		return null;
//
//		}

}
