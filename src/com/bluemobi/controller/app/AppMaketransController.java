package com.bluemobi.controller.app;

import java.text.DateFormat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.conf.Config;
import com.bluemobi.conf.StateUtil;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.User;
import com.bluemobi.service.MaketransService;
import com.bluemobi.service.OrderService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.MakeBean;
import com.bluemobi.to.ResponseBean;
import com.bluemobi.util.JPushUtils;
import com.bluemobi.util.LBSUtil;

/**
 * 预约/评价管理
 */
@Controller
@RequestMapping("app/make")
public class AppMaketransController extends AbstractWebController {

	private static final Logger log = LoggerFactory
			.getLogger(AppMaketransController.class.getName());

	@Autowired
	private UserService userservice;

	@Autowired
	private OrderService orderservice;

	@Autowired
	private MaketransService maketransservice;

	/**
	 * 获取抢单列表
	 */
	@RequestMapping(value = "findMakeList", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean findMakeList(Integer userId) {
		log.info("findMakeList————>userId:" + userId);
		try {
			User translator = userservice.getUser(userId);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("imgurl", Config.IMG_URL);
			map.put("userId", userId);
			map.put("countryid", translator.getCountryid());
			map.put("level", translator.getLevel());
			map.put("provinceid", translator.getProvinceid());
			map.put("needlanguageid", translator.getNeedlanguageid());
			return maketransservice.findMaketransList(map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取抢单列表失败！");
		}
	}

	/**
	 * 用户下单
	 */
	@RequestMapping(value = "confirmMake", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean confirmMake(MakeBean makeMessage) {// TODO
		log.info("confirmMake————>userid:" + makeMessage.getUserid()
				+ ",countryid=" + makeMessage.getCountryid() + ",cityid="
				+ makeMessage.getCityid() + ",location="
				+ makeMessage.getLocation() + ",level="
				+ makeMessage.getLevel() + ",needLanguageid="
				+ makeMessage.getNeedLanguageid() + ",motherLanguageid="
				+ makeMessage.getMotherLanguageid() + ",begintime="
				+ makeMessage.getBegintime() + ",hour=" + makeMessage.getHour()
				+ ",remark=" + makeMessage.getRemark());
		try {
			// 查找相应的译员对应的pushCode
			Map<String, Object> transMap = new HashMap<String, Object>();
			transMap.put("countryId", makeMessage.getCountryid());
			transMap.put("provinceId", makeMessage.getCityid());
			transMap.put("level", makeMessage.getLevel());
			transMap.put("needlanguageId", makeMessage.getNeedLanguageid());
			List<String> transList = orderservice.findTranPushCode(transMap);
			List<String> transIdList = orderservice.findTranId(transMap);
			String[] pushCodes = transList
					.toArray(new String[transList.size()]);
			String[] transIds = transIdList.toArray(new String[transIdList
					.size()]);

			String endTimeResult = "";
			long hours = Long.parseLong(makeMessage.getHour());
			makeMessage.setBegintime(makeMessage.getBegintime() + ":00");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 小写的mm表示的是分钟
			long nh = 1000 * 60 * 60 * hours;
			Date date = sdf.parse(makeMessage.getBegintime());
			Long endTime = date.getTime() + nh;
			endTimeResult = sdf.format(new Date(endTime));
			// 判断是否可以发预约单
			User user = userservice.getUser(makeMessage.getUserid());
			// 判断是否在返现申请中
			if (user.getIsexit().equals(1)) {
				return new ResponseBean(ResponseBean.FAIL,
						"您的返现申请已在处理中，暂时无法确认预约单，请与客服联系");
			}
			if (user.getState().equals(1)) {
				return new ResponseBean(ResponseBean.FAIL, "您已被屏蔽,不可预约！");
			}
			// 判断是否有未完成的即时单
			Map<String, Object> instantMap = new HashMap<String, Object>();
			instantMap.put("userid", makeMessage.getUserid());
			List<Map<String, Object>> userlist = maketransservice
					.findUserIsList(instantMap);// 查询用户未完成的及时单
			DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// 判断时间是否冲突
			Map<String, Object> map = new HashMap<String, Object>();
			Calendar ca = Calendar.getInstance();
			ca.setTime(f1.parse(makeMessage.getBegintime()));
			ca.add(Calendar.SECOND, +1); // 秒加一
			map.put("instantbegintime", f1.format(ca.getTime()));// 即时单开始时间
			ca.setTime(f1.parse(endTimeResult));
			ca.add(Calendar.SECOND, -1); // 秒减一
			map.put("instantendtime", f1.format(ca.getTime()));// 即时单结束时间
			map.put("reservationbegintime", makeMessage.getBegintime());// 预约单开始时间
			map.put("reservationendtime", endTimeResult);// 预约单结束时间
			Map<String, Object> timeMap = maketransservice
					.findTranslaState(map);
			if (timeMap.get("type") == "1") {
				return new ResponseBean(ResponseBean.FAIL, "该时间段已有即时单！");
			} else if (timeMap.get("type") == "2") {
				return new ResponseBean(ResponseBean.FAIL, "该时间段已有预约单！");
			} else if (timeMap.get("type") == "3") {
				// 下单
				try {
					SimpleDateFormat fmt = new SimpleDateFormat(
							"yyyy-MM-dd HH:mm:ss");
					Date dateBegin = fmt.parse(makeMessage.getBegintime());
					Date dateEnd = fmt.parse(endTimeResult);
					Calendar calendarbegin = Calendar.getInstance();
					calendarbegin.setTime(dateBegin);
					Calendar calendarend = Calendar.getInstance();
					calendarend.setTime(dateEnd);
					long begin = calendarbegin.getTimeInMillis();
					long end = calendarend.getTimeInMillis();
					//  计算小时  
					// long hours = (end - begin)/(60*60*1000);

					Map<String, Object> userMap = new HashMap<String, Object>();
					userMap.put("userid", makeMessage.getUserid());
					userMap.put("hours", hours);
					userMap.put("begintime", makeMessage.getBegintime());
					userMap.put("endtime", endTimeResult);
					userMap.put("state", "1");
					userMap.put("createtime", new Date());
					userMap.put("countryid", makeMessage.getCountryid());
					userMap.put("cityid", makeMessage.getCityid());
					userMap.put("level", makeMessage.getLevel());
					userMap.put("needLanguageid",
							makeMessage.getNeedLanguageid());
					userMap.put("motherLanguageid",
							makeMessage.getMotherLanguageid());
					userMap.put("remark", makeMessage.getRemark());
					userMap.put("location", makeMessage.getLocation());
					userMap.put("address", makeMessage.getAddress());
					Float totalfare = 0f;
					if (makeMessage.getLevel().equals(1)) {
						totalfare = (float) (StateUtil.TRANMONEY * hours);
					}
					if (makeMessage.getLevel().equals(2)) {
						totalfare = (float) (StateUtil.GUIDEMONEY * hours);
					}
					if (makeMessage.getLevel().equals(3)) {
						totalfare = (float) (StateUtil.STUDENTMONEY * hours);
					}
					userMap.put("totalfare", totalfare);
					int result = maketransservice.insertMake(userMap);
					if (result == 1) {
						for (int i = 0; i < transIds.length; i++) {
							userMap.put("transId", transIds[i]);
							maketransservice.insertMakeUser(userMap);// 添加订单e_maketrans_user
						}
						for (int i = 0; i < pushCodes.length; i++) {
							JPushUtils.jpush(pushCodes[i], "译同行", "新订单！！");
						}
						return new ResponseBean(ResponseBean.SUCCESS, "下单成功！");
					}
				} catch (Exception e) {
					e.printStackTrace();
					return new ResponseBean(ResponseBean.FAIL, "下单失败！");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "下单失败！！");
		}

		return new ResponseBean(ResponseBean.FAIL, "下单失败！！");
	}

	@RequestMapping(value = "Test", method = { RequestMethod.POST,
			RequestMethod.GET })
	// TODO
	@ResponseBody
	public ResponseBean Test(String countryId, String cityId, String level,
			String needlanguageId) {
		try {
			Map<String, Object> transMap = new HashMap<String, Object>();
			transMap.put("countryId", countryId);
			transMap.put("provinceId", cityId);
			transMap.put("level", level);
			transMap.put("needlanguageId", needlanguageId);
			List<String> transList = orderservice.findTranPushCode(transMap);
			String[] pushcodes = transList
					.toArray(new String[transList.size()]);
			for (String string : transList) {
				System.out.println("111111————————>" + string);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseBean(ResponseBean.FAIL, "查询附近翻译人员失败！");
	}

//	/**
//	 * 查询附近翻译人员 location(经纬度,例:123.41462,41.922965)
//	 */
//	@RequestMapping(value = "findTranslator", method = RequestMethod.POST)
//	// TODO
//	@ResponseBody
//	public ResponseBean findTranslator(String location) {
//		log.info("findTranslator————>location:" + location);
//		try {
//			// location="121.366162851,31.226349264468";
//			List<Map<String, Object>> alllist = new ArrayList<Map<String, Object>>();
//			boolean flag = true;
//			String total = "0";// 总数量
//			Integer pageindex = 0;
//			Integer pagesize = 200;
//			while (flag) {
//				List<Map<String, Object>> list = LBSUtil.findLBS(location,
//						pageindex, pagesize);
//				if (list.size() > 1) {
//					for (int i = 0; i < list.size(); i++) {
//						Map<String, Object> map = list.get(i);
//						if (map.get("total") != null) {
//							total = map.get("total").toString();
//						} else {
//							Map<String, Object> userm = userservice
//									.findUserLBS(map);
//							if (userm != null) {
//								if (userm.get("usertype").toString()
//										.equals("2")) {
//									map.put("username", userm.get("name"));
//									map.put("sex", userm.get("sex"));
//									map.put("starlevel", userm.get("starlevel"));
//									if (userm.get("headurl") != null
//											&& !userm.get("headurl").toString()
//													.equals("")) {
//										map.put("headurl", Config.IMG_URL
//												+ userm.get("headurl")
//														.toString());
//									} else {
//										map.put("headurl", Config.STATIC_URL
//												+ "/user.jpg");// 设置默认头像
//									}
//									alllist.add(map);
//								}
//							}
//						}
//					}
//				}
//				if (Integer.valueOf(total) > (pagesize * (pageindex + 1))) {
//					pageindex++;
//				} else {
//					flag = false;
//				}
//			}
//			return new ResponseBean(ResponseBean.SUCCESS, "查询附近翻译人员成功！",
//					alllist);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return new ResponseBean(ResponseBean.FAIL, "查询附近翻译人员失败！");
//		}
//	}

	/**
	 * 译员抢单
	 */
	@RequestMapping(value = "receiveOrder", method = { RequestMethod.POST,
			RequestMethod.GET })
	// TODO
	@ResponseBody
	public ResponseBean receiveOrder(Integer tranId, String maketransId) {
		try {
			log.info("receiveOrder————>tranId:" + tranId + ",maketransId:"
					+ maketransId);
			// 查询译员接单是否冻结
			Map<String, Object> tranMap = new HashMap<String, Object>();
			tranMap.put("tranId", tranId);
			if (userservice.checkIsorder(tranMap) == 1) {
				// 查询译员是否有未确认订单
				List<Map<String, Object>> list = orderservice
						.checkOrder(tranMap);
				if (list.size() > 0) {
					return new ResponseBean(ResponseBean.FAIL,
							"您上一个订单正处于服务中,目前不能接单,如实际已完成,请您确认订单完成");
				} else {// 可接单3
						// 查询译员个人信息
					User tran = userservice.getUser(tranId);
					if (tran.getGuaranty() == 0) {
						return new ResponseBean(ResponseBean.FAIL, "您未交保证金");
					}
					tranMap.put("tranName", tran.getName());
					if (tran.getIsexit().equals(1)) {
						return new ResponseBean(ResponseBean.FAIL,
								"您已申请退出,无法抢单！");
					}
					Map<String, Object> makeMap = new HashMap<String, Object>();
					makeMap.put("maketransId", maketransId);
					// 查询预约单信息
					Map<String, Object> makeInfoMap = maketransservice
							.findMaketMap(makeMap);
					if (tran.getState().equals(1)) {
						return new ResponseBean(ResponseBean.FAIL,
								"您的账号已被屏蔽,不可抢单！");
					}
					if (tran.getGuaranty() == 0.00) {
						return new ResponseBean(ResponseBean.FAIL,
								"您的账号未交保证金,不可抢单！");
					}
					// 查询用户个人信息
					User user = userservice.getUser(Integer
							.parseInt(makeInfoMap.get("userid").toString()));
					if (user.getIsexit().equals(1)) {
						return new ResponseBean(ResponseBean.FAIL,
								"该单用户已申请退出,无法抢单！");
					}
					if (user.getState().equals(1)) {
						return new ResponseBean(ResponseBean.FAIL,
								"该单用户已被屏蔽,不可抢单！");
					}
					tranMap.put("countryid", makeInfoMap.get("countryid")
							.toString());
					Float moneyn = 0f;// 总金额
					// 获取订单时长
					int hour = maketransservice.getOrderHour(makeMap);
					if (makeInfoMap.get("level").equals(1)) {
						moneyn = (float) (StateUtil.TRANMONEY * hour);
					}
					if (makeInfoMap.get("level").equals(2)) {
						moneyn = (float) (StateUtil.GUIDEMONEY * hour);
					}
					if (makeInfoMap.get("level").equals(3)) {
						moneyn = (float) (StateUtil.STUDENTMONEY * hour);
					}
					Float total = moneyn;
					DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					Calendar ca = Calendar.getInstance();
					ca.setTime(f1
							.parse(makeInfoMap.get("begintime").toString()));
					ca.add(Calendar.SECOND, +1);
					tranMap.put("begintime", f1.format(ca.getTime()));// 开始时间
					ca.setTime(f1.parse(makeInfoMap.get("endtime").toString()));
					ca.add(Calendar.SECOND, -1);
					tranMap.put("endtime", f1.format(ca.getTime()));// 结束时间
					// 查询译员是否可以接单
					List<Map<String, Object>> isList = maketransservice
							.findMaketMapList(tranMap);
					if (isList.size() > 0) {
						return new ResponseBean(ResponseBean.FAIL,
								"该时间段已有预约单或订单！");
					} else {
						if (makeInfoMap.get("state").toString().equals("1")) {
							tranMap.put("maketransId", maketransId);
							tranMap.put("totalfare", total);
							tranMap.put("userId", makeInfoMap.get("userid"));
							maketransservice.updateOrderC(tranMap);
							Map<String, Object> userMap = new HashMap<>();
							userMap.put("userId", user.getUserid());
							String userPushCode = userservice
									.getPushCodeById(userMap).get("pushcode")
									.toString();
							JPushUtils.jpush(userPushCode, "译同行", "用户抢单通知");
							String headurl = "";
							if (tran.getHeadurl() != null
									&& !tran.getHeadurl().equals("")) {
								headurl = Config.IMG_URL + tran.getHeadurl();
							}
							Map<String, Object> tranPushMap = new HashMap<>();
							tranPushMap.put("userId", tranMap.get("tranId"));
							String tranPushCode = userservice
									.getPushCodeById(tranPushMap)
									.get("pushcode").toString();
							JPushUtils.jpush(tranPushCode, "译用行", "译员抢单通知");
							return new ResponseBean(ResponseBean.SUCCESS,"抢单成功！");
						} else {
							return new ResponseBean(ResponseBean.FAIL,
									"抢单失败,该单已经被抢！");
						}
					}
				}
			} else {
				return new ResponseBean(ResponseBean.FAIL, "账户已冻结");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "抢单失败！");
		}

	}

	/**
	 * 用户确认订单
	 */
	@RequestMapping(value = "affirmOrder", method = { RequestMethod.POST,
			RequestMethod.GET })
	// TODO
	@ResponseBody
	public ResponseBean affirmOrder(Integer userId, Integer tranId) {
		log.info("affirmOrder————>userId:" + userId + ",tranId:" + tranId);
		try {
			// 查询译员是否抢该用户的预约单
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("truserid", tranId);
			map.put("userid", userId);
			Map<String, Object> makeMap = maketransservice.findMakeTran(map);
			map.put("maketransId", makeMap.get("maketransId"));
			if ("1".equals(makeMap.get("state"))) {
				List<Map<String, Object>> list = new ArrayList<>();
				User user = userservice.getUser(userId);
				if (user.getIsexit().equals(1)) {
					return new ResponseBean(ResponseBean.FAIL,
							"您的返现申请已在处理中，暂时无法下单，请与客服联系");
				}
				Map<String, Object> makeInfoMap = maketransservice
						.findMaketMap(makeMap);
				SimpleDateFormat df = new SimpleDateFormat(
						"yyyy-MM-dd HH:mm:ss");// 设置日期格式
				Date paytime = df.parse(df.format(new Date()));
				makeInfoMap.put("orderid", getOrderTableKey());
				makeInfoMap.put("paytime", paytime);
				makeInfoMap.put("state", 3);
				orderservice.insertOrder(makeInfoMap);// 添加到e_order
				Map<String, Object> orderMap = new HashMap<>();
				orderMap.put("orderId", makeInfoMap.get("orderid"));
				Map<String, Object> order = orderservice
						.findOrderInfoById(orderMap);
				list.add(order);
				return new ResponseBean(ResponseBean.SUCCESS, "确认订单成功！", list);
			} else {
				return new ResponseBean(ResponseBean.FAIL, "确认订单失败！");
			}

		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "确认订单失败！");
		}
	}

	/**
	 * 获取订单编码
	 */
	public String getOrderTableKey() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmSSS");
		return "D" + sdf.format(new Date())
				+ String.valueOf((int) ((Math.random() * 9 + 1) * 1000));
	}

	// /**
	// * 判断是否支付成功
	// */
	// @RequestMapping(value = "judgePay", method =
	// {RequestMethod.POST,RequestMethod.GET})//TODO
	// @ResponseBody
	// public ResponseBean judgePay(Integer payReault,String orderId) {
	// log.info("judgePay————>payReault:" + payReault+",orderId:"+orderId);
	// try {
	// if (payReault==0) {//支付成功
	// Map<String, Object> map=new HashMap<String, Object>();
	// map.put("orderId", orderId);
	// map.put("state", 4);
	// Order order=orderservice.findOrderById(map);
	// orderservice.updateOrder(map);
	// User tran=userservice.getUser(order.getTranuserid());
	// Double balance=tran.getBalance()+order.getTotalfare()*0.9;
	// map.put("balance", balance.toString());
	// map.put("userId", order.getTranuserid());
	// userservice.updateUserInfo(map);
	// return new ResponseBean(ResponseBean.SUCCESS, "支付成功！");
	// }
	// else {
	// return new ResponseBean(ResponseBean.FAIL, "支付失败！");
	// }
	// } catch (Exception e) {
	// e.printStackTrace();
	// return new ResponseBean(ResponseBean.FAIL, "支付失败！");
	// }
	// }

}