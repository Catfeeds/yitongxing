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
import com.bluemobi.po.LBSInsert;
import com.bluemobi.po.User;
import com.google.gson.Gson;

/**
 * 百度lbs云存储
 * 
 * @author taoxd
 */
public class LBSStorage {

	private static final Logger log = LoggerFactory.getLogger(LBSStorage.class);
	// ak
	private static String AK = StateUtil.AK;
	
	// geotable_id
	private static String GEOTABLEID = StateUtil.GEOTABLEID;
	
	// lbs插入数据接口路径 请求：post
	private static String INSERT_URL = "http://api.map.baidu.com/geodata/v3/poi/create";

	// lbs查询数据接口路径 请求：get
	private static String SELECT_URL = "http://api.map.baidu.com/geodata/v3/poi/list";

	// lbs修改数据接口路径 请求 ：post
	private static String UPDATE_URL = "http://api.map.baidu.com/geodata/v3/poi/update";

	public static boolean lbsStorage(User user, String latitude, String longitude) throws Exception {
		try {
			// 根据userid查询lbs云端是否存在该用户数据
			String select_str = selectByUserid(user.getUserid());
			if (select_str.equals("1")) {// 云端无数据，进行插入操作
				return insertLBS(user, latitude, longitude);
			}
			if (select_str.equals("2")) {// 云端有数据，进行修改操作
				return updateLBS(user, latitude, longitude);
			} else {
				return false;
			}
		} catch (Exception e) {
			log.info("异常" + e);
			return false;
		}

	}

	/**
	 * 百度lbs云存储
	 * @author taoxd 修改一条数据
	 */
	public static boolean updateLBS(User user, String latitude, String longitude) throws ParseException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("latitude", latitude);
		params.put("longitude", longitude);
		params.put("coord_type", "1");
		params.put("geotable_id", GEOTABLEID);
		params.put("ak", AK);
		params.put("userid", String.valueOf(user.getUserid()));
		String result_str = MapPost.post(UPDATE_URL, params);
		log.info("lbs修改返回数据=" + result_str);
		Gson go = new Gson();
		LBSInsert lbs = go.fromJson(result_str, LBSInsert.class);
		if (lbs.getStatus() == 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 百度lbs云存储
	 * @author taoxd 插入一条数据
	 */
	public static boolean insertLBS(User user, String latitude, String longitude)
			throws ParseException {
		Map<String, String> params = new HashMap<String, String>();
		params.put("latitude", latitude);
		params.put("longitude", longitude);
		params.put("coord_type", "1");
		params.put("geotable_id", GEOTABLEID);
		params.put("ak", AK);
		params.put("userid", String.valueOf(user.getUserid()));
		params.put("title", String.valueOf(user.getUserid()));
		String result_str = MapPost.post(INSERT_URL, params);
		log.info("lbs插入返回数据=" + result_str);
		Gson go = new Gson();
		LBSInsert lbs = go.fromJson(result_str, LBSInsert.class);
		if (lbs.getStatus() == 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 百度lbs云存储
	 * @author taoxd 根据id查询一条数据
	 */
	public static String selectByUserid(int userid) {
		Map<String, String> params = new HashMap<String, String>();
		String id = String.valueOf(userid);
		params.put("userid", id + "," + id);
		params.put("title", id);
		params.put("geotable_id", GEOTABLEID);
		params.put("ak", AK);
		String result_str = sendGet(SELECT_URL, params);
		log.info("lbs查询返回数据=" + result_str);
		Gson go = new Gson();
		LBSInsert lbs = go.fromJson(result_str, LBSInsert.class);
		if (lbs.getStatus() == 0) {
			if (lbs.getSize() == 0) {
				return "1";// 云端无此用户数据
			} else {
				return "2";// 云端有此用户数据
			}
		} else {
			return "3";
		}

	}

	/**
	 * get
	 * @param url
	 * @param paramsMap
	 */
	public static String sendGet(String url, Map<String, String> paramsMap) {
		String result = "";
		try {
			List<String> paramList = new ArrayList<String>();
			for (Map.Entry<String, String> param : paramsMap.entrySet()) {
				NameValuePair pair = new BasicNameValuePair(param.getKey(), param.getValue());
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
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
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
