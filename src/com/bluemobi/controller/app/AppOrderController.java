package com.bluemobi.controller.app;

import java.text.SimpleDateFormat;

import java.util.ArrayList;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


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
import com.bluemobi.po.Order;
import com.bluemobi.po.RefundApply;
import com.bluemobi.po.User;
import com.bluemobi.service.MaketransService;
import com.bluemobi.service.OrderService;
import com.bluemobi.service.RefundApplyService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;
import com.bluemobi.util.PreciseCompute;

/**
 * 订单管理
 *
 */
@Controller
@RequestMapping("app/order")
public class AppOrderController extends AbstractWebController {
	private static final Logger log = LoggerFactory.getLogger(AppOrderController.class.getName());
	@Autowired
	private OrderService orderservice;
	
	@Autowired
	private UserService userservice;
	
	@Autowired
	private MaketransService maketransservice;
	
	@Autowired
	private RefundApplyService refundApplyService;
	/**
	 * 用户的订单列表
	 */
	@RequestMapping(value = "findOrderListApp", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findOrderListApp(Integer userid, Integer pageIndex,Integer pageSize,String state) {//TODO
		log.info("findOrderListApp————>userid:" + userid+",pageIndex="+pageIndex+",pageSize="+pageSize+",state="+state);
		try {
			Map<String, Object> map=new HashMap<>();
			 int offset = (pageIndex - 1) * pageSize;
			map.put("userid", userid);
			map.put("state", state);
			map.put("offset", offset);
		    map.put("rows", pageSize);
			if(pageIndex==null) {
				pageIndex=1;
			}
			pageSize=10;
			String stateMessages=StateUtil.statename;
			String imageUrl = Config.IMG_URL;
			List<Map<String, Object>> list=orderservice.findOrderListApp(imageUrl,pageIndex,pageSize,userid,stateMessages,state);
//			User tran=userservice.getUser(list.get)
			List<Map<String, Object>> maketramslist=maketransservice.findMakeTransListApp(map);
			list.addAll(maketramslist);
			return new ResponseBean(ResponseBean.SUCCESS, "获取订单列表成功",list);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取订单列表失败！");
		}           
	}
	
	/**
	 * 译员的订单列表
	 */
	@RequestMapping(value = "findOrderTranListApp", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findOrderTranListApp(HttpServletRequest request,Integer userId, Integer pageIndex,Integer pageSize,String state) {
		log.info("findOrderTranListApp————>userId:" + userId+",pageIndex="+pageIndex+",state="+state);
		try {                                                                 
			User user=userservice.getUser(userId);
			if(user==null) {
				return new ResponseBean(ResponseBean.NOLOGIN, "请您先登录！");
			}
			if(pageIndex==null) {
				pageIndex=1;
			}
			pageSize=10;
			String staten=StateUtil.statename;
			String imageUrl = Config.IMG_URL;
			return orderservice.findOrderFyListApp(imageUrl,pageIndex,pageSize,state,user,staten,request);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取订单列表失败！");
		}
	}
	
	
//	/**
//	 * 我的订单(各状态的数量)
//	 */
//	@RequestMapping(value = "findOrderCount", method = {RequestMethod.POST,RequestMethod.GET})
//	@ResponseBody
//	public ResponseBean findOrderCount(Integer userId,String state) {//TODO
//		log.info("findOrderCount————>userId:" + userId+",state"+state);
//		try {
//			List<Map<String, Object>> list=new ArrayList<>();
//			Map<String, Object> map=new HashMap<String, Object>();
//			Map<String, Object> totalMap=new HashMap<String, Object>();
//			map.put("userId", userId);
//			map.put("state", state);
//			String totalCount=orderservice.findOrderCount(map);
//			totalMap.put("totalCount", totalCount);
//			list.add(totalMap);
//			return new ResponseBean(ResponseBean.SUCCESS, "获取订单数量成功",list);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return new ResponseBean(ResponseBean.FAIL, "获取订单数量失败！");
//		}
//	}
	/**
	 * 我的订单(各状态的数量 汇总)
	 */
	@RequestMapping(value = "findOrderCountByState", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findOrderCountByState(Integer userId) {//TODO
		log.info("findOrderCountByState————>userId:" + userId);
		try {
			List<Map<String, Object>> list=new ArrayList<>();
			Map<String, Object> totalMap=new HashMap<String, Object>();//全部
			Map<String, Object> unpaidMap=new HashMap<String, Object>();//待支付
			Map<String, Object> underwayMap=new HashMap<String, Object>();//进行中
			Map<String, Object> unappraiseMap=new HashMap<String, Object>();//待评价
			
			totalMap.put("userId", userId);
			totalMap.put("state", "1,2,3,4,5,6,7,8");
			String makeCount=maketransservice.findMakeTransListAppCount(totalMap);
			String totalCount=orderservice.findOrderCount(totalMap);
			Integer resultCount=Integer.parseInt(makeCount)+Integer.parseInt(totalCount);
			totalMap.put("totalCount", resultCount);
			list.add(totalMap);
			
			unpaidMap.put("userId", userId);
			unpaidMap.put("state", "3");
			String unpaidCount=orderservice.findOrderCount(unpaidMap);
			unpaidMap.put("totalCount", unpaidCount);
			list.add(unpaidMap);
			
			underwayMap.put("userId", userId);
			underwayMap.put("state", "4,5");
			String underwayCount=orderservice.findOrderCount(underwayMap);
			underwayMap.put("totalCount", underwayCount);
			list.add(underwayMap);
			
			unappraiseMap.put("userId", userId);
			unappraiseMap.put("state", "6");
			String unappraiseCount=orderservice.findOrderCount(unappraiseMap);
			unappraiseMap.put("totalCount", unappraiseCount);
			list.add(unappraiseMap);
			
			return new ResponseBean(ResponseBean.SUCCESS, "获取订单数量成功",list);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取订单数量失败！");
		}
	}
	
	
	
//	/**
//	 * 查询订单详情(app用户端)
//	 */
//	@RequestMapping(value = "findOrderMessage", method = {RequestMethod.POST,RequestMethod.GET})
//	@ResponseBody
//	public ResponseBean findOrderMessage(String orderId) {//TODO
//		log.info("findOrderMessage————>orderId:" + orderId);
//		try {
//			Map<String, Object> map=new HashMap<String, Object>();
//			map.put("orderId", orderId);
//			return orderservice.findOrderMessage(map);
//		} catch (Exception e) {
//			e.printStackTrace();
//			return new ResponseBean(ResponseBean.FAIL, "获取订单详情失败！");
//		}
//	}
	/**
	 * 用户确认完成订单
	 */
	@RequestMapping(value = "CompleteOrder", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean CompleteOrder(String orderId) {//TODO
		log.info("CompleteOrder————>orderId:" + orderId);
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("orderId", orderId);
			map.put("state", 5);
			return orderservice.updateOrderTranslaApp(map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "确认完成订单失败！");
		}
	}
	
	
	/**
	 * 我的订单(评价)
	 * usertype(1用户,2翻译)
	 * starlevel 星等级
	 */
	@RequestMapping(value = "insertOrderComment", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean insertOrderComment(Integer userId, String orderId,String starlevel,String content,String usertype) {
		log.info("insertOrderComment————>userId:" + userId+",orderId="+orderId+",usertype="+usertype+",starlevel="+starlevel+",content="+content);
		try {
			String commentContent=new String(content.getBytes("ISO-8859-1"),"UTF-8");
			User user=userservice.getUser(userId);
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("starlevel", starlevel);
			map.put("content", commentContent);
			map.put("createtime", new Date());
			map.put("fromuserid", user.getUserid());
			map.put("orderId", orderId);
			map.put("usertype", usertype);
			return orderservice.insertOrderComment(map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "评价失败！");
		}
	}
	
	
	
	/**
	 *删除订单
	 *usertype(1用户,2翻译)
	 *取消订单(未被译员接单)
	 */
	@RequestMapping(value = "deleteOrderApp", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean deleteOrderApp(String orderid,String usertype) {
		log.info("deleteOrderApp————>orderid="+orderid+",usertype="+usertype);
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("orderId", orderid);
			map.put("usertype", usertype);//1用户删除订单 2译员删除订单
			orderservice.deleteOrderApp(map);
			return new ResponseBean(ResponseBean.SUCCESS, "删除订单成功！");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "删除订单失败！");
		}
	}      
	
	/**
	 *我的订单(取消订单)
	 *译员接单后 
	 */
	@RequestMapping(value = "updateOrderCancel", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean updateOrderCancel(Integer userId, String orderId) {
		log.info("updateOrderCancel————>userId:" + userId+",orderId="+orderId);
		try {
			User user=userservice.getUser(userId);
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("orderId", orderId);
			map.put("userid", userId);
			map.put("username", user.getName());
			
			User usertr=orderservice.findOrderCancelApp(map);
			if(usertr==null) {
				return new ResponseBean(ResponseBean.FAIL, "订单不存在！");
			}
			Map<String, Object> params=new HashMap<String, Object>();
			Order order=orderservice.findOrderById(map);
			params.put("userid", order.getUserid());
			params.put("tranuserid", order.getTranuserid());
			if(usertr.getSystem()!=null) {
				//翻译推送
//				String[] push=usertr.getToken().split(",");
//				JPushUtils.sendPushmm("用户取消订单通知", push, String.valueOf(usertr.getSystem()),"","","","",StateUtil.translaappKey,StateUtil.translamasterSecret,params);//按别名发送
			}
			List<Map<String, Object>> list=new ArrayList<Map<String, Object>>();
			list.add(params);
			return new ResponseBean(ResponseBean.SUCCESS, "取消订单成功！",list);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "取消订单失败！");
		}
	}
	
	/**
	 *判断是否支付成功
	 */
	@RequestMapping(value = "judgePay", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean judgePay(String orderId) {
		log.info("deleteOrderApp————>orderId="+orderId);
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("orderId", orderId);
			Order order=orderservice.findOrderById(map);
			if (order.getState() == 4) {
				return new ResponseBean(ResponseBean.SUCCESS, "支付成功！");
			}
			else {
				return new ResponseBean(ResponseBean.FAIL, "订单处理中，等待支付");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "支付失败！");
		}
	}      
	
	
	
	/**
	 *用户取消订单
	 *isOrder 0接单 1未接单
	 */
	@RequestMapping(value = "cancelOrderByUser", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean cancelOrderByUser(String orderId,Integer isOrder,RefundApply refundApply) {
		log.info("cancelOrderByUser————>orderId="+orderId+",isOrder:"+isOrder);
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("orderId", orderId);
			Order order=orderservice.findOrderById(map);
			map.put("caceltype", 1);//1用户取消订单 2译员取消订单
			if (isOrder == 1) {//未接单
				orderservice.deleteOrderApp(map);
				return new ResponseBean(ResponseBean.SUCCESS, "订单取消成功，译员未接单不扣钱");
			}
			else {//已接单
				if (order.getState() == 3) {
					orderservice.deleteOrderApp(map);
					return new ResponseBean(ResponseBean.SUCCESS, "订单取消成功，译员待付款不扣钱");
				}
				if (order.getState() == 4) {
					SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					Calendar cacel = Calendar.getInstance();
					cacel.setTime(refundApply.getApplytime());

			        Calendar begin = Calendar.getInstance();
			        begin.setTime(order.getPaytime());

			        Calendar end = Calendar.getInstance();
			        end.setTime(order.getBegintime());

			        if (cacel.after(begin) && cacel.before(end)) {//取消时间在付款时间和订单开始时间之中
			        	if (order.getLevel() == 1) {
							refundApply.setMoney(PreciseCompute.sub(order.getTotalfare()+"",StateUtil.TRANMONEY+""));
						}
						if (order.getLevel() == 2) {
							refundApply.setMoney(PreciseCompute.sub(order.getTotalfare()+"",StateUtil.GUIDEMONEY+""));						
												}
						if (order.getLevel() == 3) {
							refundApply.setMoney(PreciseCompute.sub(order.getTotalfare()+"",StateUtil.STUDENTMONEY+""));
						}
			        	orderservice.deleteOrderApp(map);
			        	refundApplyService.insertRefundApply(refundApply);
			        	return new ResponseBean(ResponseBean.SUCCESS, "订单取消成功，取消时间在付款时间和订单开始时间之中，扣一个小时的钱");
			        } else {
			        	orderservice.deleteOrderApp(map);
			        	return new ResponseBean(ResponseBean.SUCCESS, "订单取消成功，扣全款");
			        }
				}
				else {
					return new ResponseBean(ResponseBean.FAIL, "订单处理中，等待支付");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "支付失败！");
		}
	}      
	
	
	  
}