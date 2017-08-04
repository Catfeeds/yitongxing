
package com.bluemobi.job;
import java.text.SimpleDateFormat;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;



import cn.jpush.api.examples.PushExample;

import com.bluemobi.conf.StateUtil;
import com.bluemobi.po.Message;
import com.bluemobi.service.MaketransService;
import com.bluemobi.service.MessageService;
import com.bluemobi.service.OrderService;
import com.bluemobi.service.UserService;
import com.bluemobi.util.JPushUtils;
/**
 * 定时器
 * @author liuchuang
 *
 */
public class OrderJob {
	private static final Logger log = LoggerFactory.getLogger(OrderJob.class.getName());
	@Autowired
	private OrderService orderservice;
	@Autowired
	private MessageService messageService;
	@Autowired
	private UserService userService;
	@Autowired
	private MaketransService maketransservice;
	
	/**
	 * 更改订单状态/更新翻译取消次数
	 */
	public void updateOrderSend() {
		log.info("updateOrderSend------------------------定时器start");
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			//当订单预约日达到前1天消息提醒用户(推送)
			Calendar ca1 = Calendar.getInstance();
			ca1.setTime(new Date());
			ca1.add(Calendar.DATE, 1);//当前时间+24小时
			map.put("daytime", ca1.getTime());
			map.put("system", "1");//android
			List<String> androidlist=orderservice.findOrderDay(map);
			log.info("android-------------------------------"+androidlist.size());
			if(androidlist.size()>0) {
				for (int i = 0; i < androidlist.size(); i++) {
					JPushUtils.jpush(androidlist.get(i), "译同行", "离订单预约日还有1天时间!!!");
				}
			}
			map.put("system", "2");//ios
			List<String> ioslist=orderservice.findOrderDay(map);//当订单预约日达到前1天消息提醒
			log.info("ios-------------------------------"+ioslist.size());
			if(ioslist.size()>0) {
				for (int i = 0; i < androidlist.size(); i++) {
					JPushUtils.jpush(androidlist.get(i), "译同行", "新订单！！");
				}
			}
			//当订单预约日达到前1天消息提醒用户(消息)
			List<Map<String, Object>> maplist=orderservice.findMapList(map);
			log.info("all-------------------------------"+maplist.size());
			if(maplist.size()>0) {
				for(int i=0;i<maplist.size();i++) {
					Map<String, Object> mapm=maplist.get(i);
					//插入表e_maketrans
					Message mg=new Message();
					mg.setTitle("订单通知");
					mg.setContent("订单号" + mapm.get("orderid").toString() + ",离订单预约日还有1天时间");
					mg.setCreatetime(new Date());
					messageService.insertMe(mg);
					//插入表e_maketrans_user
					Map<String, Object> mapp = new HashMap<String, Object>();
					mapp.put("msgid", mg.getMsgid());
					mapp.put("userid", mapm.get("userid").toString());
					mapp.put("senduserid", "0");
					messageService.insertMeUser(mapp);
					orderservice.updateOrderDay(mapm);//修改消息提醒状态
				}
			}
			//48小时内未确认订单完成自动完成订单，进入待评价状态
			Calendar ca2 = Calendar.getInstance();
			ca2.setTime(new Date());
			ca2.add(Calendar.HOUR,48);//当前时间+48小时
			Map<String, Object> orderMap = new HashMap<String, Object>();
			orderMap.put("daytime", ca2.getTime());
			String orderid=orderservice.getunConfirmOrderId(orderMap);
			orderMap.put("orderId", orderid);
			orderMap.put("state", 6);
			orderservice.updateOrderTranslaApp(map);
		} catch (Exception e) {
			log.info("------------------------定时器出现异常");
			e.printStackTrace();
		}
		log.info("------------------------定时器end");
	}


}
