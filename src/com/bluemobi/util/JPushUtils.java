package com.bluemobi.util;

import cn.jpush.api.examples.PushExample;



/**
 *极光推送帮助类
 */
public class JPushUtils {
	
	public static void jpush(String pushCode,String title,String content) throws Exception{
		PushExample pushExample=new PushExample();
		pushExample.testSendPushWithCustomConfig(pushCode,title,content);
	}
	

}
