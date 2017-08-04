package com.bluemobi.controller.app;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.domain.AlipayTradeAppPayModel;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradeAppPayRequest;
import com.alipay.api.response.AlipayTradeAppPayResponse;
import com.bluemobi.conf.Config;
import com.bluemobi.conf.StateUtil;
import com.bluemobi.po.Order;
import com.bluemobi.po.TransPay;
import com.bluemobi.po.User;
import com.bluemobi.service.OrderService;
import com.bluemobi.service.TransPayService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.PayBean;
import com.bluemobi.to.ResponseBean;
import com.bluemobi.util.CommonUtils;
import com.bluemobi.util.WXPayUtil;

@Controller
@RequestMapping("app/pay")
public class AppPayController {
	
	private static final Logger log = LoggerFactory.getLogger(AppPayController.class);
	private static String ALIPAY_APPID = Config.ALIPAY_APPID;
	private static String ALIPAY_PRIVATEKEY = Config.ALIPAY_PRIVATEKEY;
	private static String ALIPAY_PUBLICKEY = Config.ALIPAY_PUBLICKEY;
	
	@Autowired
	private UserService userService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private TransPayService transPayService;
	
	/**
	 * 支付宝获取签名
	 */
	@RequestMapping(value="getAlipaySign", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getAlipaySign(String totalAmount,String orderId) {
		log.info("getAlipaySign————>totalAmount:"+totalAmount+"orderId"+orderId);
		List<Map<String, String>> signList=new ArrayList<>();
		Map<String, String> signMap=new HashMap<String, String>();
		// 实例化客户端
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do",ALIPAY_APPID, ALIPAY_PRIVATEKEY, "json", "utf-8", ALIPAY_PUBLICKEY, "RSA2");
		// 实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
		AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
		// SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
		AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
	
		model.setSubject("译同行订单");
		model.setOutTradeNo(orderId);
		model.setTotalAmount(totalAmount);
		model.setProductCode("QUICK_MSECURITY_PAY");
		request.setBizModel(model);
		request.setNotifyUrl("http://www.5aabc.com/gate/app/pay/alipay_notify_url");
				try {
				        //这里和普通的接口调用不同，使用的是sdkExecute
				        AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
				        signMap.put("AlipaySign", response.getBody());
				        signList.add(signMap);
				        System.out.println(response.getBody());
				        return new ResponseBean(ResponseBean.SUCCESS, "获取支付签名成功",signList);
				    } catch (AlipayApiException e) {
				        e.printStackTrace();
				        return new ResponseBean(ResponseBean.FAIL, "获取支付签名失败");
				}
			}
	
	
	/**
	 * @author xiaojin_wu
	 * @datetime 2017年7月20日
	 * @return 
	 * 		支付宝支付异步回调接口
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "alipay_notify_url", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public void validateAlipaySign(HttpServletRequest request,HttpServletResponse response) {
		log.info("---------进行支付宝回调验签start-----------");
		// 获取支付宝POST过来反馈信息
		Map<String, String> params = new HashMap<String, String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			// 乱码解决，这段代码在出现乱码时使用。如果mysign和sign不相等也可以使用这段代码转化
			// valueStr = new String(valueStr.getBytes("ISO-8859-1"), "gbk");
			params.put(name, valueStr);
		}
		// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		try {
			// 商户订单号,根据此来执行订单受理情况
			String out_trade_no = new String(request.getParameter(
					"out_trade_no").getBytes("ISO-8859-1"), "UTF-8");
			// 支付宝交易号
			String trade_no = new String(request.getParameter("trade_no")
					.getBytes("ISO-8859-1"), "UTF-8");
			// 交易状态
			String trade_status = new String(request.getParameter(
					"trade_status").getBytes("ISO-8859-1"), "UTF-8");

			log.info("-------------支付宝订单号："+out_trade_no+",交易状态:"+trade_status+"-----------------");
			
			// 获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以上仅供参考)//
			// 计算得出通知验证结果
			// boolean AlipaySignature.rsaCheckV1(Map<String, String> params,
			// String publicKey, String charset, String sign_type)
			boolean verify_result = AlipaySignature.rsaCheckV1(params,
					ALIPAY_PUBLICKEY, "utf-8", "RSA2");
			
			log.info("支付宝回调验签结果："+verify_result);
			
			if (verify_result) {
				// 验证成功,进行业务处理
				log.info("-------------验签成功-------------");
				if (trade_status.equals("TRADE_FINISHED")) {
					// 判断该笔订单是否在商户网站中已经做过处理
					// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					// 请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					// 如果有做过处理，不执行商户的业务程序
					// 这里的订单不可进行退款
					Map<String, Object> map=new HashMap<>();
					map.put("orderId", out_trade_no);
					Order order=orderService.findOrderById(map);
					map.put("state", 4);
					orderService.updateOrder(map);
					User tran=userService.getUser(order.getTranuserid());
					Double balance=tran.getBalance()+order.getTotalfare()*0.9;
					map.put("balance", balance.toString());
					map.put("userId", order.getTranuserid());
					userService.updateUserInfo(map);
					log.info("-------------TRADE_FINISHED-------------");
				} else if (trade_status.equals("TRADE_SUCCESS")) {
					// 判断该笔订单是否在商户网站中已经做过处理
					// 如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
					// 请务必判断请求时的total_fee、seller_id与通知时获取的total_fee、seller_id为一致的
					// 如果有做过处理，不执行商户的业务程序
					// 这里的订单可以进行退款
					Map<String, Object> map=new HashMap<>();
					map.put("orderId", out_trade_no);
					Order order=orderService.findOrderById(map);
					map.put("state", 4);
					orderService.updateOrder(map);
					User tran=userService.getUser(order.getTranuserid());
					Double balance=tran.getBalance()+order.getTotalfare()*0.9;
					map.put("balance", balance.toString());
					map.put("userId", order.getTranuserid());
					userService.updateUserInfo(map);
					log.info("-------------TRADE_SUCCESS-------------");
				}

				
				response.getWriter().write("success");// 只向页面返回success，请不要修改或删除

			} else {// 验证失败
				response.getWriter().write("fail");
			}
		} catch (Exception e) {
			log.error("支付宝支付回调异常");
			e.printStackTrace();
		}

	}
	
//	/**
//	 * 支付宝验证签名
//	 */
//	@RequestMapping(value="validateAlipaySign", method={RequestMethod.POST,RequestMethod.GET})
//	@ResponseBody
//	public ResponseBean validateAlipaySign(HttpServletRequest request) {
//		log.info("validateAlipaySign————>");
//		List<Map<String, String>> validateSignList=new ArrayList<>();
//		Map<String, String> validateSignMap=new HashMap<String, String>();
//		//获取支付宝POST过来反馈信息
//		Map<String,String> params = new HashMap<String,String>();
//		Map requestParams = request.getParameterMap();
//		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
//		    String name = (String) iter.next();
//		    String[] values = (String[]) requestParams.get(name);
//		    String valueStr = "";
//		    for (int i = 0; i < values.length; i++) {
//		        valueStr = (i == values.length - 1) ? valueStr + values[i]
//		                    : valueStr + values[i] + ",";
//		  }
//		  //乱码解决，这段代码在出现乱码时使用。
//		  //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
//		  params.put(name, valueStr);
//		 }
//		//切记alipaypublickey是支付宝的公钥，请去open.alipay.com对应应用下查看。
//		//boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type)
//		try {
//			boolean flag = AlipaySignature.rsaCheckV1(params, ALIPAY_PUBLICKEY, "utf-8", "RSA2");
//			validateSignMap.put("flag", flag+"");
//			validateSignList.add(validateSignMap);
//			return new ResponseBean(ResponseBean.SUCCESS, "获取支付签名成功",validateSignList);
//		} catch (AlipayApiException e) {
//			e.printStackTrace();
//			return new ResponseBean(ResponseBean.FAIL, "验证支付签名失败");
//		}
//
//			}
	
	/**
	 * 用户端微信支付获取预支付交易会话标识
	 */
	@RequestMapping(value="getWeChatPrepayId", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getWeChatPrepayId(Integer userId, String orderId,Integer account) {
		log.info("getWeChatPrepayId————>userId:" + userId + ",orderId:" + orderId);
		try {
			if(userId==null || StringUtils.isBlank(orderId))
				return new ResponseBean(ResponseBean.FAIL, "参数错误");
			User user = userService.getUser(userId);
			if(user == null)
				return new ResponseBean(ResponseBean.NOLOGIN, "登录超时，请重新登录");
			Order order = orderService.getOrderInfoByUserIdAndOrderId(orderId, userId);
			if(order == null)
				return new ResponseBean(ResponseBean.FAIL, "订单不存在");
//			if(order.getBondmoney() == null || order.getBondmoney().compareTo(0f) <= 0)
//				return new ResponseBean(ResponseBean.FAIL, "订单金额错误");
			int total=new Double(account * 100).intValue();
//			int amount = new Double(order.getBondmoney() * 100).intValue();
			String nonce_str = CommonUtils.getUUID();
			SortedMap<String, Object> signParams = new TreeMap<String, Object>();
			signParams.put("appid", Config.Y_APPID);
			signParams.put("mch_id", Config.Y_MCHID);
			signParams.put("nonce_str", nonce_str);
			signParams.put("body", "译同行订单");
			signParams.put("attach", "3");
			signParams.put("out_trade_no", orderId);
			signParams.put("fee_type", "CNY");
			signParams.put("total_fee", String.valueOf(total)); // 金额
			signParams.put("spbill_create_ip", "103.21.116.228");
			signParams.put("notify_url", Config.BASE_URL + "/app/pay/weChatNotify"); // 回调地址
			signParams.put("trade_type", "APP");
			String sign = WXPayUtil.createMD5SignY(signParams);
			log.info("微信用户端支付签名，sign：" + sign);
			String xml = "<xml>" +
						"   <appid><![CDATA[" + Config.Y_APPID + "]]></appid>" +
						"   <mch_id><![CDATA[" + Config.Y_MCHID + "]]></mch_id>" +
						"   <nonce_str><![CDATA[" + nonce_str + "]]></nonce_str>" +
						"   <body><![CDATA[译同行订单]]></body>" +
						"   <attach><![CDATA[3]]></attach>" +
						"   <out_trade_no><![CDATA[" + orderId + "]]></out_trade_no>" +
						"   <fee_type><![CDATA[CNY]]></fee_type>" +
						"   <total_fee><![CDATA[" + String.valueOf(total) + "]]></total_fee>" + // 金额
						"   <spbill_create_ip><![CDATA[103.21.116.228]]></spbill_create_ip>" +
						"   <notify_url><![CDATA[" + Config.BASE_URL + "/app/pay/weChatNotify" + "]]></notify_url>" + // 回调地址
						"   <trade_type><![CDATA[APP]]></trade_type>" +
						"   <sign><![CDATA[" + sign + "]]></sign>" +
						"</xml>";
			String returnXml = WXPayUtil.post("https://api.mch.weixin.qq.com/pay/unifiedorder", xml);
			Document doc = DocumentHelper.parseText(returnXml);
			// 获取根节点
			Element root = doc.getRootElement();
			String returnCode = root.selectSingleNode("return_code").getText();
			if("SUCCESS".equals(returnCode)) {
				String resultCode = root.selectSingleNode("result_code").getText();
				if("SUCCESS".equals(resultCode)) {
					String prepayId = root.selectSingleNode("prepay_id").getText(); // 预支付交易会话标识
					PayBean payTO = new PayBean();
					payTO.setPrepayId(prepayId);
					List<PayBean> list = new ArrayList<PayBean>();
					list.add(payTO);
					return new ResponseBean(ResponseBean.SUCCESS, "成功", list);
				} else {
					String errCodeDes = root.selectSingleNode("err_code_des").getText();
					return new ResponseBean(ResponseBean.FAIL, errCodeDes);
				}
			} else {
				String returnMsg = root.selectSingleNode("return_msg").getText();
				return new ResponseBean(ResponseBean.FAIL, returnMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常,请稍后重试");
		}
	}
	
	
	/**
	 * 翻译端微信充值获取订单号及微信预支付订单号
	 * 微信充值
	 */
	@RequestMapping(value="getWeChatOrderId", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getWeChatOrderId(Integer userId, String amount) {
		log.info("getWeChatOrderId————>userId:" + userId + ",amount:" + amount);
		try {
			if(userId==null || StringUtils.isBlank(amount))
				return new ResponseBean(ResponseBean.FAIL, "参数错误");
			if(!CommonUtils.isNum(amount))
				return new ResponseBean(ResponseBean.FAIL, "充值金额错误");
			User user = userService.getUser(userId);
			if(user == null)
				return new ResponseBean(ResponseBean.NOLOGIN, "登录超时，请重新登录");
			String transpayid = CommonUtils.getUUID();
			int amounts = new Double(Double.parseDouble(amount) * 100).intValue();
			String nonce_str = CommonUtils.getUUID();
			SortedMap<String, Object> signParams = new TreeMap<String, Object>();
			signParams.put("appid", Config.F_APPID);
			signParams.put("mch_id", Config.F_MCHID);
			signParams.put("nonce_str", nonce_str);
			signParams.put("body", "译同行订单");
			signParams.put("attach", "2");
			signParams.put("out_trade_no", transpayid);
			signParams.put("fee_type", "CNY");
			signParams.put("total_fee", String.valueOf(amounts)); // 金额
			signParams.put("spbill_create_ip", "103.21.116.228");
			signParams.put("notify_url", Config.BASE_URL + "/app/pay/weChatNotify"); // 回调地址
			signParams.put("trade_type", "APP");
			String sign = WXPayUtil.createMD5SignF(signParams);
			log.info("微信翻译端支付签名，sign：" + sign);
			String xml = "<xml>" +
						"   <appid><![CDATA[" + Config.F_APPID + "]]></appid>" +
						"   <mch_id><![CDATA[" + Config.F_MCHID + "]]></mch_id>" +
						"   <nonce_str><![CDATA[" + nonce_str + "]]></nonce_str>" +
						"   <body><![CDATA[译同行订单]]></body>" +
						"   <attach><![CDATA[2]]></attach>" +
						"   <out_trade_no><![CDATA[" + transpayid + "]]></out_trade_no>" +
						"   <fee_type><![CDATA[CNY]]></fee_type>" +
						"   <total_fee><![CDATA[" + String.valueOf(amounts) + "]]></total_fee>" + // 金额
						"   <spbill_create_ip><![CDATA[103.21.116.228]]></spbill_create_ip>" +
						"   <notify_url><![CDATA[" + Config.BASE_URL + "/app/pay/weChatNotify" + "]]></notify_url>" + // 回调地址
						"   <trade_type><![CDATA[APP]]></trade_type>" +
						"   <sign><![CDATA[" + sign + "]]></sign>" +
						"</xml>";
			String returnXml = WXPayUtil.post("https://api.mch.weixin.qq.com/pay/unifiedorder", xml);
			Document doc = DocumentHelper.parseText(returnXml);
			// 获取根节点
			Element root = doc.getRootElement();
			String returnCode = root.selectSingleNode("return_code").getText();
			if("SUCCESS".equals(returnCode)) {
				String resultCode = root.selectSingleNode("result_code").getText();
				if("SUCCESS".equals(resultCode)) {
					TransPay transPay = new TransPay();
					transPay.setTranspayid(transpayid);
					transPay.setUserid(userId);
					transPay.setAmount(Float.valueOf(amount));
					transPay.setPaytype(2);
					transPay.setCreatetime(new Date());
					transPayService.insert(transPay);
					String prepayId = root.selectSingleNode("prepay_id").getText(); // 预支付交易会话标识
					PayBean payBean = new PayBean();
					payBean.setPrepayId(prepayId);
					payBean.setOrderid(transpayid);
					List<PayBean> list = new ArrayList<PayBean>();
					list.add(payBean);
					return new ResponseBean(ResponseBean.SUCCESS, "成功", list);
				} else {
					String errCodeDes = root.selectSingleNode("err_code_des").getText();
					return new ResponseBean(ResponseBean.FAIL, errCodeDes);
				}
			} else {
				String returnMsg = root.selectSingleNode("return_msg").getText();
				return new ResponseBean(ResponseBean.FAIL, returnMsg);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常,请稍后重试");
		}
	}
	
	/**
	 * 查询翻译余额满足条件
	 */
	@RequestMapping(value = "findPriceSatisfy", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findPriceSatisfy(String countryid,String level) {
		log.info("findPriceSatisfy————>countryid:"+countryid+",level:"+level);
		try {
			if(level.equals("2")) {
				level="6";
			} else {
				level="8";
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("countryid", countryid);
			map.put("type", level);
			map.put("money", StateUtil.MONEY);
			return userService.findPriceSatisfy(map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "查询翻译余额满足条件失败！");
		}
	}
	
	/**
	 * 翻译端支付宝充值获取订单号和回调地址
	 * 支付宝充值
	 */
	@RequestMapping(value="getAliPayOrderId", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getAliPayOrderId(Integer userId, String totalAmount,String orderId) {//TODO
		log.info("getAliPayOrderId————>userId:" + userId + ",totalAmount:" + totalAmount);
//		List<Map<String, String>> signList=new ArrayList<>();
//		Map<String, String> signMap=new HashMap<String, String>();
		// 实例化客户端
		AlipayClient alipayClient = new DefaultAlipayClient("https://openapi.alipay.com/gateway.do",ALIPAY_APPID, ALIPAY_PRIVATEKEY, "json", "utf-8", ALIPAY_PUBLICKEY, "RSA2");
		// 实例化具体API对应的request类,类名称和接口名称对应,当前调用接口名称：alipay.trade.app.pay
		AlipayTradeAppPayRequest request = new AlipayTradeAppPayRequest();
		// SDK已经封装掉了公共参数，这里只需要传入业务参数。以下方法为sdk的model入参方式(model和biz_content同时存在的情况下取biz_content)。
		AlipayTradeAppPayModel model = new AlipayTradeAppPayModel();
	
		model.setSubject("译同行订单");
		model.setOutTradeNo(orderId);
		model.setTotalAmount(totalAmount);
		model.setProductCode("QUICK_MSECURITY_PAY");
		request.setBizModel(model);
		request.setNotifyUrl(Config.BASE_URL + "/app/pay/aliPayNotify");
		try {
			if(userId==null || StringUtils.isBlank(totalAmount))
				return new ResponseBean(ResponseBean.FAIL, "参数错误");
			if(!CommonUtils.isNum(totalAmount))
				return new ResponseBean(ResponseBean.FAIL, "充值金额错误");
			User user = userService.getUser(userId);
			
	        //这里和普通的接口调用不同，使用的是sdkExecute
	        AlipayTradeAppPayResponse response = alipayClient.sdkExecute(request);
//	        signMap.put("AlipaySign", response.getBody());
			
			String transpayid = CommonUtils.getUUID();
			TransPay transPay = new TransPay();
			transPay.setTranspayid(transpayid);
			transPay.setUserid(user.getUserid());
			transPay.setAmount(Float.valueOf(totalAmount));
			transPay.setPaytype(2);
			transPay.setCreatetime(new Date());
			transPayService.insert(transPay);
			PayBean payBean = new PayBean();
			payBean.setOrderid(transpayid);
			payBean.setNotifyurl(Config.BASE_URL + "/app/pay/aliPayNotify");
			payBean.setAmount(totalAmount);
			payBean.setAlipaySign(response.getBody());
			List<PayBean> list = new ArrayList<PayBean>();
			list.add(payBean);
			return new ResponseBean(ResponseBean.SUCCESS, "成功", list);
		} catch (AlipayApiException e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常,请稍后重试");
		}
	}
	
	/**
	 * @description
	 * 			微信支付异步回调路径，支付成功后微信将报文返回在此路径
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "wxpay_notify_url", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public void notify(HttpServletRequest request,
			HttpServletResponse response){
		
		log.info("微信支付回调数据开始");
		//示例报文
//		String xml = "<xml><appid><![CDATA[wxb4dc385f953b356e]]></appid><bank_type><![CDATA[CCB_CREDIT]]></bank_type><cash_fee><![CDATA[1]]></cash_fee><fee_type><![CDATA[CNY]]></fee_type><is_subscribe><![CDATA[Y]]></is_subscribe><mch_id><![CDATA[1228442802]]></mch_id><nonce_str><![CDATA[1002477130]]></nonce_str><openid><![CDATA[o-HREuJzRr3moMvv990VdfnQ8x4k]]></openid><out_trade_no><![CDATA[1000000000051249]]></out_trade_no><result_code><![CDATA[SUCCESS]]></result_code><return_code><![CDATA[SUCCESS]]></return_code><sign><![CDATA[1269E03E43F2B8C388A414EDAE185CEE]]></sign><time_end><![CDATA[20150324100405]]></time_end><total_fee>1</total_fee><trade_type><![CDATA[JSAPI]]></trade_type><transaction_id><![CDATA[1009530574201503240036299496]]></transaction_id></xml>";
		String inputLine;
		StringBuffer notityXml = new StringBuffer();
		String resXml = "";

		try {
			while ((inputLine = request.getReader().readLine()) != null) {
				notityXml.append(inputLine);
			}
			request.getReader().close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		log.info("接收到的报文：" + notityXml);
		
		Map<String,Object> m = parseXmlToList2(notityXml.toString());
//		WxPayResult wpr = new WxPayResult();
		m.get("appid").toString();
//		wpr.setAppid(m.get("appid").toString());
//		wpr.setBankType(m.get("bank_type").toString());
//		wpr.setCashFee(m.get("cash_fee").toString());
//		wpr.setFeeType(m.get("fee_type").toString());
//		wpr.setIsSubscribe(m.get("is_subscribe").toString());
//		wpr.setMchId(m.get("mch_id").toString());
//		wpr.setNonceStr(m.get("nonce_str").toString());
//		wpr.setOpenid(m.get("openid").toString());
//		wpr.setOutTradeNo(m.get("out_trade_no").toString());
//		wpr.setResultCode(m.get("result_code").toString());
//		wpr.setReturnCode(m.get("return_code").toString());
//		wpr.setSign(m.get("sign").toString());
//		wpr.setTimeEnd(m.get("time_end").toString());
//		wpr.setTotalFee(m.get("total_fee").toString());
//		wpr.setTradeType(m.get("trade_type").toString());
//		wpr.setTransactionId(m.get("transaction_id").toString());
		
//		if("SUCCESS".equals(wpr.getResultCode())){
//			//支付成功
//			resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
//			+ "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
//		}else{
//			resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
//			+ "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
//		}

		try {
			response.getWriter().write(resXml);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * @description
	 * 			 解析微信返回的xml
	 * @param xml
	 * 			微信异步回调返回报文
	 * @author 
	 * 			xiaojin_wu
	 * @return
	 * 			微信异步回调返回报文转换成map
	 */
	private static Map<String,Object> parseXmlToList2(String xml) {
		Map<String,Object> retMap = new HashMap<>();
		try {
		} catch (Exception e) {
			e.printStackTrace();
		}
		return retMap;
	}
}
