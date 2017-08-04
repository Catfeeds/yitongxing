package com.bluemobi.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bluemobi.conf.StateUtil;
import com.bluemobi.po.Contents;
import com.bluemobi.po.LBSMap;
import com.google.gson.Gson;

/**
 * 百度lbs云检索/存储
 * 
 * @author liuchuang
 */
public class LBSUtil {
	private static final Logger log = LoggerFactory.getLogger(LBSUtil.class.getName());
	// ak
	private static String AK = StateUtil.AK;
	// geotable_id
	private static String GEOTABLEID = StateUtil.GEOTABLEID;
	// lbs检索地址
	private static String URL = "http://api.map.baidu.com/geosearch/v3/nearby";
	// 搜索范围,单位米
	private static String RADIUS = "50000";
	// lbs存储地址
	private static String URLC = "http://api.map.baidu.com/geodata/v3/poi/create";
	
	public static void main(String[] args) throws ParseException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("geotable_id", GEOTABLEID);
		params.put("latitude", "41.923296");
		params.put("longitude", "123.409994");
		params.put("coord_type", "1");
		params.put("userid", "88");
		params.put("address", "88");
		params.put("title", "88");
		params.put("ak", AK);
		String str = MapPost.post(URLC, params);
		System.out.println("值="+str);
	}

	/**
	 * 通过lbs查询翻译人员
	 * 
	 * location(经纬度,例:123.41462,41.922965)
	 */
	public static List<Map<String, Object>> findLBS(String location,Integer pageindex,Integer pagesize) {//TODO
		Map<String, String> params = new HashMap<String, String>();
		params.put("geotable_id", GEOTABLEID);
		params.put("ak", AK);
		params.put("location", location);
		params.put("radius", RADIUS);
		params.put("page_index", String.valueOf(pageindex));
		params.put("page_size", String.valueOf(pagesize));
		String str = sendGet(URL, params);
		log.info("lbs返回数据=" + str);
		Gson go = new Gson();
		LBSMap lbs = go.fromJson(str, LBSMap.class);
		List<Contents> list = lbs.getContents();
		List<Map<String, Object>> lbslist = new ArrayList<Map<String, Object>>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("total", lbs.getTotal());
		lbslist.add(param);
		for (int i = 0; i < list.size(); i++) {
			Contents ct = list.get(i);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("location", ct.getLocation());// 经纬度
			map.put("userid", ct.getUserid());// 翻译ID
			lbslist.add(map);
		}
		return lbslist;
	}

	/**
	 * 请求百度lbs获取数据
	 * 
	 * @param url
	 * @param paramsMap
	 */
	public static String sendGet(String url, Map<String, String> paramsMap) {
		String result = "";
		try {
			List<String> paramList = new ArrayList<String>();
			for (Map.Entry<String, String> param : paramsMap.entrySet()) {
				NameValuePair pair = new BasicNameValuePair(param.getKey(),
						param.getValue());
				paramList.add(pair.toString());
			}
			String par = "";// 参数
			for (int i = 0; i < paramList.size(); i++) {
				if (par.equals("")) {
					par = paramList.get(i);
				} else {
					par += "&" + paramList.get(i);
				}
			}
			String urlName = url + "?" + par;
			URL U = new URL(urlName);
			URLConnection connection = U.openConnection();
			connection.connect();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result = line;
			}
			in.close();
		} catch (Exception e) {
			log.info("异常==========" + e);
		}
		return result;
	}
}
