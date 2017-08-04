package com.bluemobi.conf;

import com.appcore.model.AbstractObject;

/*
 * 静态常量帮助类
 */
public class StateUtil extends AbstractObject {

	private static final long serialVersionUID = 1L;

	public static String statename = "待接单,待确认,待付订金,订单进行中,待付尾款,待评价,已完成,已取消";
	public static String resetname = "退钱,扣钱,退钱扣钱,未退未扣";
	//接单余额最低标准
	public static Integer MONEY = 360;
	//商务翻译每小时80
	public static Integer TRANMONEY = 80;
	//旅游向导每小时60
	public static Integer GUIDEMONEY = 60;
	//及时订单翻译取消阶梯上升价格
	public static Integer price = 10;
	//及时订单翻译取消免费次数
	public static Integer chargesum = 2;
	//及时订单翻译取消初始价格
	public static Float initialprice = 20f;//初始价格如果为n,则该处为n-10
	//极光推送(用户端)
	public static String appKey = "0df6feaa97c3eb8d20db51ec";
	public static String masterSecret = "45efbebc3275be9301599bd5";
	//极光推送(翻译端)
	public static String translaappKey = "fa6e12c7ff96822e6d73d85b";
	public static String translamasterSecret = "731f52350a19a7a49683d569";
	//百度lbs
	public static String AK = "EM02qil4bh0sZW0yBTjc4iZY";//ak
	public static String GEOTABLEID = "128943";//geotable_id
}