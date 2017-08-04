package com.bluemobi.controller.app;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import java.util.List;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.jpush.api.examples.PushExample;

import com.bluemobi.conf.Config;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.User;
import com.bluemobi.service.UserAuditService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.TranBean;
import com.bluemobi.to.UserInfoBean;
import com.bluemobi.to.ResponseBean;
import com.bluemobi.to.UserBean;
import com.bluemobi.util.CommonUtils;
import com.bluemobi.util.ImageUtil;

@Controller
@RequestMapping("app/user")
public class APPUserController extends AbstractWebController {

	private static final Logger log = LoggerFactory
			.getLogger(APPUserController.class);

	@Autowired
	private UserService userService;

	@Autowired
	private UserAuditService userAuditService;

	/**
	 * 登录
	 * 
	 * @author Amiee
	 * @param account
	 *            账号
	 * @param code
	 *            验证码
	 * @param system
	 *            1 android，2 ios
	 * @param areaCode
	 *            区号(中国 86)
	 * @return
	 */
	@RequestMapping(value = "login", method = { RequestMethod.POST,
			RequestMethod.GET })
	// TODO
	@ResponseBody
	public ResponseBean login(String account, String code, Integer system,
			String areaCode, String pushCode) {
		log.info("login————>account:" + account + ",code:" + code + ",system:"
				+ system + ",areaCode:" + areaCode + ",pushCode:" + pushCode);
		try {
			String appkey = "";
			if (system == 1) {
				appkey = Config.MOB_APPKEY_Android;
			} else {
				appkey = Config.MOB_APPKEY_IOS;
			}
			if (StringUtils.isBlank(account)) {
				return new ResponseBean(ResponseBean.FAIL, "账号输入不正确");
			} else if (StringUtils.isBlank(code) || code.length() != 4) {
				return new ResponseBean(ResponseBean.FAIL, "验证码输入不正确");
			} else if (system == null
					|| (system != 1 && system != 2)) {
				return new ResponseBean(ResponseBean.FAIL, "参数错误");
			}
			User userRegister = userService.getUserByUserName(account, null);
			if (userRegister == null) {
				userService.userRegister(account);
				userRegister = userService.getUserByUserName(account, null);
			} else if (userRegister.getUsertype().equals(1)) {
				return new ResponseBean(ResponseBean.FAIL, "账号不存在");
			} else if (userRegister.getState().equals(1)) {
				return new ResponseBean(ResponseBean.FAIL, "账号已被禁用,请联系管理员");
			}
			UserBean userBean = new UserBean();
			BeanUtils.copyProperties(userRegister, userBean);
			List<UserBean> userlist = new ArrayList<UserBean>();
			userlist.add(userBean);
			String documentStr = "appkey=" + appkey + "&phone=" + account
					+ "&zone=" + areaCode + "&code=" + code;
			String result = "";
			String payUrl = "https://webapi.sms.mob.com/sms/verify";
			HttpClient client = new HttpClient();
			PostMethod method = new PostMethod(payUrl);
			RequestEntity requestEntity;
			requestEntity = new StringRequestEntity(documentStr,
					"Content-Type", "UTF-8");
			method.setRequestEntity(requestEntity);
			client.executeMethod(method);
			result = method.getResponseBodyAsString();
			String resultMessage = result.substring(10, 13);
			if (method.getStatusCode() == 200) {
				if ("200".equals(resultMessage)) {
					// User userRegister =
					// userService.getUserByUserName(account, null);
					// if(userRegister == null) {
					// userService.userRegister(account,userType);
					// userRegister = userService.getUserByUserName(account,
					// null);
					// } else if(userRegister.getUsertype().equals(1)) {
					// return new ResponseBean(ResponseBean.FAIL, "账号不存在");
					// } else if(userRegister.getState().equals(1)) {
					// return new ResponseBean(ResponseBean.FAIL,
					// "账号已被禁用,请联系管理员");
					// }
					// UserBean userBean= new UserBean();
					// BeanUtils.copyProperties(userRegister, userBean);
					// List<UserBean> userlist = new ArrayList<UserBean>();
					// userlist.add(userBean);
					userService.updatePushCode(userBean.getUserid(), pushCode);
					return new ResponseBean(ResponseBean.SUCCESS, "登录成功",
							userlist);
				}
				if ("468".equals(resultMessage)) {
					return new ResponseBean(ResponseBean.FAIL, "验证码错误，请重试");
				}
				if ("466".equals(resultMessage)) {
					return new ResponseBean(ResponseBean.FAIL, "请填写证码 ");
				} else {
					return new ResponseBean(ResponseBean.FAIL, "验证码异常");
				}
			} else {
				return new ResponseBean(ResponseBean.FAIL, "网络请求超时，请稍后重试");
			}
		} catch (Exception e) {
			e.getStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "登录失败，请重试");
		}
	}

	/**
	 * 获取当前登录人信息 通过用户id获取用户信息
	 */
	@RequestMapping(value = "getLoginUserInfo", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean getLoginUserInfo(Integer userId) {
		log.info("getLoginUserInfo————>userid:" + userId);
		try {
			User user = userService.getUser(userId);
			UserInfoBean userInfoBean = new UserInfoBean();
			BeanUtils.copyProperties(user, userInfoBean);
			userInfoBean
					.setPassporturl(userInfoBean.getPassporturl() == null ? ""
							: Config.IMG_URL + userInfoBean.getPassporturl());
			userInfoBean
					.setPassporturlmin(userInfoBean.getPassporturlmin() == null ? ""
							: Config.IMG_URL + userInfoBean.getPassporturlmin());
			userInfoBean.setVisaurl(userInfoBean.getVisaurl() == null ? ""
					: Config.IMG_URL + userInfoBean.getVisaurl());
			userInfoBean
					.setVisaurlmin(userInfoBean.getVisaurlmin() == null ? ""
							: Config.IMG_URL + userInfoBean.getVisaurlmin());
			// userInfoBean.setStudentupurl(userInfoBean.getStudentupurl() ==
			// null ? "" : Config.IMG_URL + userInfoBean.getStudentupurl());
			// userInfoBean.setStudentupurlmin(userInfoBean.getStudentupurlmin()
			// == null ? "" : Config.IMG_URL +
			// userInfoBean.getStudentupurlmin());
			// userInfoBean.setStudentdownurl(userInfoBean.getStudentdownurl()
			// == null ? "" : Config.IMG_URL +
			// userInfoBean.getStudentdownurl());
			// userInfoBean.setStudentdownurlmin(userInfoBean.getStudentdownurlmin()
			// == null ? "" : Config.IMG_URL +
			// userInfoBean.getStudentdownurlmin());
			userInfoBean.setHeadurl(userInfoBean.getHeadurl() == null ? ""
					: Config.IMG_URL + userInfoBean.getHeadurl());
			List<UserInfoBean> list = new ArrayList<UserInfoBean>();
			list.add(userInfoBean);
			return new ResponseBean(ResponseBean.SUCCESS, "获取成功", list);
		} catch (BeansException e) {
			e.getStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常,请稍后重试");
		}
	}

	/**
	 * 修改个人信息
	 */
	@RequestMapping(value = "updateUserInfo", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean updateUserInfo(Integer userId, String name,
			String position) {
		log.info("updateUserInfo————>userId:" + userId + ",name:" + name
				+ ",position:" + position);
		try {
			if (name == null && position == null) {
				return new ResponseBean(ResponseBean.FAIL, "参数不可全部为空");
			}
			User user = userService.getUser(userId);
			if (user == null) {
				return new ResponseBean(ResponseBean.NOLOGIN, "登录超时，请重新登录");
			}
			if (user.getState().equals(1)) {
				return new ResponseBean(ResponseBean.FAIL, "账号已被禁用，请联系管理员");
			}
			if (!StringUtils.isBlank(name) && name.length() > 20) {
				return new ResponseBean(ResponseBean.FAIL, "姓名不能超过20个字符");
			}
			Map<String, Object> map = new HashMap<>();
			map.put("userId", userId);
			map.put("name", name);
			map.put("position", position);
			userService.updateUserInfo(map);
			return new ResponseBean(ResponseBean.SUCCESS, "修改成功");
		} catch (Exception e) {
			e.getStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "修改失败,请稍后重试");
		}
	}

	@RequestMapping(value = "jpush", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean jpush(String pushCode, String title, String content) {
		log.info("jpush————>pushCode:" + pushCode + ",title:" + title
				+ ",content:" + content);
		try {
			String contentStr = new String(content.getBytes("ISO-8859-1"),
					"UTF-8");
			String titleStr = new String(title.getBytes("ISO-8859-1"), "UTF-8");
			System.out.println(contentStr);
			PushExample pushExample = new PushExample();
			pushExample.testSendPushWithCustomConfig(pushCode, titleStr,
					contentStr);
			return new ResponseBean(ResponseBean.SUCCESS, "推送成功");
		} catch (Exception e) {
			return new ResponseBean(ResponseBean.FAIL, "推送失败");
		}
	}

	/**
	 * 上传头像
	 */
	@RequestMapping(value = "upload", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean upload(@RequestParam() MultipartFile imagefile,
			Integer userId) {
		log.info("upload————>imagefile:" + imagefile + ",userId:" + userId);
		try {
			if (imagefile.isEmpty()) {
				return new ResponseBean(ResponseBean.FAIL, "请选择上传图片");
			} else {
				StringBuilder sb = new StringBuilder();
				String filename = imagefile.getOriginalFilename();
				String suffix = filename.substring(filename.lastIndexOf("."))
						.toLowerCase();
				String suffixArray = ".jpg,.jpeg,.png";
				if (suffixArray.indexOf(suffix) < 0) {
					return new ResponseBean(ResponseBean.FAIL, "只能上传【"
							+ suffixArray + "】类型的图片");
				}
				String num = CommonUtils.getUUID();
				File image = new File(getTomcatPath() + num + suffix);
				File dir = image.getParentFile();
				if (!dir.exists()) {
					dir.mkdirs();
				}
				FileCopyUtils.copy(imagefile.getBytes(), image);
				ImageUtil imageUtil = new ImageUtil();
				Boolean result = imageUtil.connect(Config.FTP_SAVE_PATH,
						Config.FTP_HOST, Integer.parseInt(Config.FTP_PORT),
						Config.FTP_USERNAME, Config.FTP_PASSWORD);
				if (result) {
					imageUtil.upload(image);
					String imageUrl = image.toString()
							.substring(image.toString().lastIndexOf("\\") + 1)
							.toLowerCase();
					Map<String, Object> map = new HashMap<>();
					map.put("userId", userId);
					map.put("headurl", imageUrl);
					userService.updateUserInfo(map);
				} else {
					return new ResponseBean(ResponseBean.FAIL, "连接ftp服务器失败");
				}
				return new ResponseBean(ResponseBean.SUCCESS, "文件上传成功");
			}
		} catch (Exception e) {
			return new ResponseBean(ResponseBean.FAIL, "文件上传失败");
		}
	}

	/**
	 * 判断译员是否通过审核(0否 1是)
	 */
	@RequestMapping(value = "checkTrain", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean checkTrain(Integer userId) {
		log.info("checkTrain————>userId:" + userId);
		try {
			List<Map<String, Object>> list = new ArrayList<>();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			User user = userService.getUser(userId);
			resultMap.put("result", user.getAuditstate());
			list.add(resultMap);
			return new ResponseBean(ResponseBean.SUCCESS, "审核成功", list);
		} catch (Exception e) {
			return new ResponseBean(ResponseBean.FAIL, "审核失败");
		}
	}

	// @RequestMapping(value="uploadImages", method=RequestMethod.POST)
	// @ResponseBody
	// public ResponseBean uploadImages(@RequestParam() List<MultipartFile>
	// imagefile,Integer userId) {
	// log.info("upload————>imagefiles:"+imagefile+",userId:"+userId);
	// try {
	//
	// } catch (Exception e) {
	// return new ResponseBean(ResponseBean.FAIL, "文件上传失败");
	// }
	// }

	/**
	 * 译员申请
	 */
	@RequestMapping(value = "applyTranInfo", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean applyTranInfo(
			@RequestParam() List<MultipartFile> imagefile, TranBean tranInfo) {
		try {
			log.info("upload————>imagefiles:" + imagefile + ",tranInfo:"
					+ tranInfo);
			User tran = userService.getUser(tranInfo.getUserid());
			if (!tran.getAuditstate().equals(0)) {
				return new ResponseBean(ResponseBean.SUCCESS,
						"您已提交申请资料，请耐心等待管理员审核");
			}
			String imageUrl = "";
			for (int i = 0; i < imagefile.size(); i++) {
				if (imagefile.get(i).isEmpty()) {
					return new ResponseBean(ResponseBean.SUCCESS, "请选择上传图片");
				} else {
					// StringBuilder sb = new StringBuilder();
					String filename = imagefile.get(i).getOriginalFilename();
					String suffix = filename.substring(
							filename.lastIndexOf(".")).toLowerCase();
					String suffixArray = ".jpg,.jpeg,.png";
					if (suffixArray.indexOf(suffix) < 0) {
						return new ResponseBean(ResponseBean.FAIL, "只能上传【"
								+ suffixArray + "】类型的图片");
					}
					String num = CommonUtils.getUUID();
					File image = new File(getTomcatPath() + num + suffix);
					File dir = image.getParentFile();
					if (!dir.exists()) {
						dir.mkdirs();
					}
					FileCopyUtils.copy(imagefile.get(i).getBytes(), image);
					ImageUtil imageUtil = new ImageUtil();
					Boolean result = imageUtil.connect(Config.FTP_SAVE_PATH,
							Config.FTP_HOST, Integer.parseInt(Config.FTP_PORT),
							Config.FTP_USERNAME, Config.FTP_PASSWORD);
					if (result) {
						imageUtil.upload(image);
						if (imageUrl == null || imageUrl == "") {
							imageUrl = image
									.toString()
									.substring(
											image.toString().lastIndexOf("\\") + 1)
									.toLowerCase();
						} else {
							imageUrl = image
									.toString()
									.substring(
											image.toString().lastIndexOf("\\") + 1)
									.toLowerCase()
									+ "," + imageUrl;
						}
					} else {
						return new ResponseBean(ResponseBean.FAIL, "连接ftp服务器失败");
					}
				}
			}
			tran.setUserid(tranInfo.getUserid());
			tran.setName(tranInfo.getName());
			tran.setSex(tranInfo.getSex());
			tran.setAge(tranInfo.getAge());
			tran.setProfession(tranInfo.getProfession());
			tran.setSchool(tranInfo.getSchool());
			tran.setMajorid(tranInfo.getMajorid());
			tran.setRemark(tranInfo.getRemark());
			tran.setCountryid(tranInfo.getCountryid());
			tran.setProvinceid(tranInfo.getProvinceid());
			tran.setNeedlanguageid(tranInfo.getNeedlanguageid());
			tran.setLevel(tranInfo.getLevel());
			tran.setAuditstate(1);
			tran.setApplytime(new Date());
			tran.setIdentificationPhoto(imageUrl);
			userAuditService.updateTranUser(tran);
			log.info("用户：" + tran.getAccount() + ",申请译员成功");
			return new ResponseBean(ResponseBean.SUCCESS, "申请成功，请等待管理员审核");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常，请稍后重试");
		}
	}

	/**
	 * 修改译员信息
	 */
	@RequestMapping(value = "updateTranInfo", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean updateTranInfo(
			@RequestParam() List<MultipartFile> imagefile, TranBean tranInfo) {
		try {
			log.info("upload————>imagefiles:" + imagefile + ",tranInfo:"
					+ tranInfo);
			User tran = userService.getUser(tranInfo.getUserid());
			String imageUrl = "";
			for (int i = 0; i < imagefile.size(); i++) {
				if (imagefile.get(i).isEmpty()) {
					return new ResponseBean(ResponseBean.FAIL, "请选择上传图片");
				} else {
					StringBuilder sb = new StringBuilder();
					String filename = imagefile.get(i).getOriginalFilename();
					String suffix = filename.substring(
							filename.lastIndexOf(".")).toLowerCase();
					String suffixArray = ".jpg,.jpeg,.png";
					if (suffixArray.indexOf(suffix) < 0) {
						return new ResponseBean(ResponseBean.FAIL, "只能上传【"
								+ suffixArray + "】类型的图片");
					}
					String num = CommonUtils.getUUID();
					File image = new File(getTomcatPath() + num + suffix);
					File dir = image.getParentFile();
					if (!dir.exists()) {
						dir.mkdirs();
					}
					FileCopyUtils.copy(imagefile.get(i).getBytes(), image);
					ImageUtil imageUtil = new ImageUtil();
					Boolean result = imageUtil.connect(Config.FTP_SAVE_PATH,
							Config.FTP_HOST, Integer.parseInt(Config.FTP_PORT),
							Config.FTP_USERNAME, Config.FTP_PASSWORD);
					if (result) {
						imageUtil.upload(image);
						if (imageUrl == null || imageUrl == "") {
							imageUrl = image
									.toString()
									.substring(
											image.toString().lastIndexOf("\\") + 1)
									.toLowerCase();
						} else {
							imageUrl = image
									.toString()
									.substring(
											image.toString().lastIndexOf("\\") + 1)
									.toLowerCase()
									+ "," + imageUrl;
						}
					} else {
						return new ResponseBean(ResponseBean.FAIL, "连接ftp服务器失败");
					}
				}
			}
			Map<String, Object> map = new HashMap<>();
			map.put("userId", tranInfo.getUserid());
			map.put("name", tranInfo.getName());
			map.put("sex", tranInfo.getSex());
			map.put("age", tranInfo.getAge());
			map.put("profession", tranInfo.getProfession());
			map.put("school", tranInfo.getSchool());
			map.put("major", tranInfo.getMajorid());
			map.put("remark", tranInfo.getRemark());
			map.put("countryid", tranInfo.getCountryid());
			map.put("provinceid", tranInfo.getProvinceid());
			map.put("needlanguageid", tranInfo.getNeedlanguageid());
			map.put("level", tranInfo.getLevel());
			map.put("auditstate", 4);
			map.put("applytime", new Date());
			map.put("identificationphoto", imageUrl);
			userAuditService.updateTranInfo(map);
			return new ResponseBean(ResponseBean.SUCCESS, "修改译员信息成功");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "修改译员信息成功");
		}
	}
}