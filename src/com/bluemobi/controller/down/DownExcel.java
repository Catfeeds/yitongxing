package com.bluemobi.controller.down;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.bluemobi.conf.StateUtil;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.service.OrderService;
/**
 * 导出订单Excel
 * 
 * @author LiuChuang
 * 
 */
@Controller
@RequestMapping("/background/excel/")
public class DownExcel extends AbstractWebController {
	private static final Logger log = LoggerFactory.getLogger(DownExcel.class.getName());
	@Autowired
	private OrderService orderservice;

	/**
	 * 导出订单excel
	 */
	@RequestMapping("downOrder")
	public void downOrder(OutputStream os,HttpServletRequest request,HttpServletResponse response,@RequestParam Map<String, Object> mapn) throws Exception {
		log.info("downOrder-->username:" + mapn.get("username") + ",orderid:" + mapn.get("orderid") + ",languageid:" + mapn.get("languageid")+ ",level:" + mapn.get("level")
    			+ ",specialtyid:" + mapn.get("specialtyid")+ ",state:" + mapn.get("state")+ ",begintime:" + mapn.get("begintime")+ ",endtime:" + mapn.get("endtime"));
		mapn.put("username", new String(mapn.get("username").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	mapn.put("begintime", new String(mapn.get("begintime").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	mapn.put("endtime", new String(mapn.get("endtime").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	if(mapn.get("endtime")!=null && !mapn.get("endtime").toString().equals("")) {
			DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd");
    		Calendar ca = Calendar.getInstance();
    		try {
    			ca.setTime(f1.parse(mapn.get("endtime").toString()));
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}
    		ca.add(Calendar.DATE, 1);
        	mapn.put("endtime", ca.getTime());
		}
		List<Map<String, Object>> list=orderservice.findDownOrder(mapn);
		try {
			//创建excel表格
			WritableWorkbook wwb = Workbook.createWorkbook(os);
			response.setContentType("application/vnd.ms-excel");
			//文件名称
			response.setHeader("Content-disposition","attachment; filename="+new String(("订单列表").getBytes("gbk"),"iso8859-1")+".xls");
			WritableSheet ws = wwb.createSheet("订单列表", 0);//页码名称
			WritableFont wfc =new WritableFont(WritableFont.ARIAL,10,WritableFont.BOLD,false,UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK);
			WritableCellFormat cellFormat=new WritableCellFormat(wfc);
			cellFormat.setAlignment(jxl.format.Alignment.CENTRE);//标题
			WritableCellFormat cellFormatn=new WritableCellFormat();
			cellFormatn.setAlignment(jxl.format.Alignment.CENTRE);//内容
			Label labelC = new Label(0, 0, "用户ID");
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			ws.setColumnView(0,20);
			ws.setRowView(0,300); 
			labelC = new Label(1, 0, "用户名");
			ws.setColumnView(1,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(2, 0, "推荐人");
			ws.setColumnView(2,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(3, 0, "订单号");
			ws.setColumnView(3,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(4, 0, "目的地");
			ws.setColumnView(4,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(5, 0, "开始时间");
			ws.setColumnView(5,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(6, 0, "结束时间");
			ws.setColumnView(6,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(7, 0, "语种");
			ws.setColumnView(7,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(8, 0, "等级");
			ws.setColumnView(8,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(9, 0, "专业");
			ws.setColumnView(9,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(10, 0, "是否退款");
			ws.setColumnView(10,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
//			labelC = new Label(10, 0, "价格(￥)");
//			ws.setColumnView(10,20);
//			ws.setRowView(0,300);
//			labelC.setCellFormat(cellFormat);
//			ws.addCell(labelC);
//			labelC = new Label(11, 0, "总价格(￥)");
//			ws.setColumnView(11,20);
//			ws.setRowView(0,300);
//			labelC.setCellFormat(cellFormat);
//			ws.addCell(labelC);
			labelC = new Label(11, 0, "担保金(￥)");
			ws.setColumnView(11,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(12, 0, "备注");
			ws.setColumnView(12,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(13, 0, "发布时间");
			ws.setColumnView(13,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(14, 0, "状态");
			ws.setColumnView(14,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(15, 0, "支付方式");
			ws.setColumnView(15,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(16, 0, "支付订单号");
			ws.setColumnView(16,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(17, 0, "订单类型");
			ws.setColumnView(17,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			String[] statn=StateUtil.statename.split(",");
			DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(int i=0;i<list.size();i++) {
				Map<String, Object> ac=list.get(i);
				if(ac!=null) {
					labelC = new Label(0, i+1, ac.get("userid").toString());//用户ID
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String un="";
					if(ac.get("username")!=null) {
						un=ac.get("username").toString();
					}
					labelC = new Label(1, i+1, un);//用户名
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String in="";
					if(ac.get("invitation")!=null) {
						in=ac.get("invitation").toString();
					}
					labelC = new Label(2, i+1, in);//推荐人
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(3, i+1, ac.get("orderid").toString());//订单ID
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String an="";
					if(ac.get("countryn")!=null) {
						an=ac.get("countryn").toString();
					}
					if(ac.get("provincen")!=null) {
						an+=ac.get("provincen").toString();
					}
					if(ac.get("cityn")!=null) {
						an+=ac.get("cityn").toString();
					}
					labelC = new Label(4, i+1, an);//目的地
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(5, i+1, f1.format(ac.get("begintime")));//开始时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(6, i+1, f1.format(ac.get("endtime")));//结束时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(7, i+1, ac.get("languagename").toString());//语种
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String level="";
					if(ac.get("level").toString().equals("2")) {
						level="口译员";
					} else if(ac.get("level").toString().equals("3")) {
						level="高级口译员";
					}
					labelC = new Label(8, i+1, level);//等级
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String sp="";
					if(ac.get("specialtyname")!=null) {
						sp=ac.get("specialtyname").toString();
					}
					labelC = new Label(9, i+1, sp);//专业
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String cn="已退";
					if(ac.get("confirm").toString().equals("0")) {
						cn="未退";
					}
					labelC = new Label(10, i+1, cn);//是否退款
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
//					labelC = new Label(10, i+1, ac.get("price").toString());//价格
//					labelC.setCellFormat(cellFormatn);
//					ws.addCell(labelC);
//					
//					labelC = new Label(11, i+1, ac.get("money").toString());//总金额
//					labelC.setCellFormat(cellFormatn);
//					ws.addCell(labelC);
					
					labelC = new Label(11, i+1, ac.get("bondmoney").toString());//担保金
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String rm="";
					if(ac.get("remark")!=null) {
						rm=ac.get("remark").toString();
					}
					labelC = new Label(12, i+1, rm);//备注
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(13, i+1, f1.format(ac.get("createtime")));//发布时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(14, i+1, statn[Integer.valueOf(ac.get("state").toString())]);//状态
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String opaytype="";
					if(ac.get("opaytype").toString().equals("0")) {
						opaytype="支付宝";
	            	} else if(ac.get("opaytype").toString().equals("1")) {
	            		opaytype="微信";
	            	} else if(ac.get("opaytype").toString().equals("2")) {
	            		opaytype="余额";
	            	}
					labelC = new Label(15, i+1, opaytype);//支付方式
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(16, i+1, ac.get("odealorderid").toString());//支付订单号
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String istime="普通订单";
					if(ac.get("istimely").toString().equals("1")) {
						istime="即时订单";
					}
					labelC = new Label(17, i+1, istime);//订单类型
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
				}
			}
			
			// 合并单元格
			//ws.mergeCells(3, 0, 4, 0);//竖、横、竖、横
			wwb.write();
			wwb.close();

		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 导出订单excel(取消订单)
	 */
	@RequestMapping("downCancelOrder")
	public void downCancelOrder(OutputStream os,HttpServletRequest request,HttpServletResponse response,@RequestParam Map<String, Object> mapn) throws Exception {
		log.info("downCancelOrder-->username:" + mapn.get("username") + ",orderid:" + mapn.get("orderid") + ",languageid:" + mapn.get("languageid")+ ",level:" + mapn.get("level")
    			+ ",specialtyid:" + mapn.get("specialtyid")+ ",reset:" + mapn.get("reset")+ ",begintime:" + mapn.get("begintime")+ ",endtime:" + mapn.get("endtime"));
		mapn.put("username", new String(mapn.get("username").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	mapn.put("begintime", new String(mapn.get("begintime").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	mapn.put("endtime", new String(mapn.get("endtime").toString().getBytes("ISO-8859-1"),"UTF-8"));
    	if(mapn.get("endtime")!=null && !mapn.get("endtime").toString().equals("")) {
			DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd");
    		Calendar ca = Calendar.getInstance();
    		try {
    			ca.setTime(f1.parse(mapn.get("endtime").toString()));
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}
    		ca.add(Calendar.DATE, 1);
        	mapn.put("endtime", ca.getTime());
		}
		List<Map<String, Object>> list=orderservice.findDownCancelOrder(mapn);
		try {
			//创建excel表格
			WritableWorkbook wwb = Workbook.createWorkbook(os);
			response.setContentType("application/vnd.ms-excel");
			//文件名称
			response.setHeader("Content-disposition","attachment; filename="+new String(("取消订单列表").getBytes("gbk"),"iso8859-1")+".xls");
			WritableSheet ws = wwb.createSheet("取消订单列表", 0);//页码名称
			WritableFont wfc =new WritableFont(WritableFont.ARIAL,10,WritableFont.BOLD,false,UnderlineStyle.NO_UNDERLINE,jxl.format.Colour.BLACK);
			WritableCellFormat cellFormat=new WritableCellFormat(wfc);
			cellFormat.setAlignment(jxl.format.Alignment.CENTRE);//标题
			WritableCellFormat cellFormatn=new WritableCellFormat();
			cellFormatn.setAlignment(jxl.format.Alignment.CENTRE);//内容
			Label labelC = new Label(0, 0, "用户ID");
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			ws.setColumnView(0,20);
			ws.setRowView(0,300); 
			labelC = new Label(1, 0, "用户名");
			ws.setColumnView(1,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(2, 0, "推荐人");
			ws.setColumnView(2,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(3, 0, "订单号");
			ws.setColumnView(3,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(4, 0, "目的地");
			ws.setColumnView(4,20);
			ws.setRowView(0,300); 
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(5, 0, "开始时间");
			ws.setColumnView(5,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(6, 0, "结束时间");
			ws.setColumnView(6,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(7, 0, "语种");
			ws.setColumnView(7,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(8, 0, "等级");
			ws.setColumnView(8,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(9, 0, "专业");
			ws.setColumnView(9,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(10, 0, "是否退款");
			ws.setColumnView(10,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
//			labelC = new Label(10, 0, "价格(￥)");
//			ws.setColumnView(10,20);
//			ws.setRowView(0,300);
//			labelC.setCellFormat(cellFormat);
//			ws.addCell(labelC);
//			labelC = new Label(11, 0, "总价格(￥)");
//			ws.setColumnView(11,20);
//			ws.setRowView(0,300);
//			labelC.setCellFormat(cellFormat);
//			ws.addCell(labelC);
			labelC = new Label(11, 0, "退钱/扣钱详情");
			ws.setColumnView(11,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(12, 0, "备注");
			ws.setColumnView(12,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(13, 0, "发布时间");
			ws.setColumnView(13,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(14, 0, "状态");
			ws.setColumnView(14,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(15, 0, "取消人");
			ws.setColumnView(15,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(16, 0, "取消时间");
			ws.setColumnView(16,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(17, 0, "支付方式");
			ws.setColumnView(17,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(18, 0, "支付订单号");
			ws.setColumnView(18,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			labelC = new Label(19, 0, "订单类型");
			ws.setColumnView(19,20);
			ws.setRowView(0,300);
			labelC.setCellFormat(cellFormat);
			ws.addCell(labelC);
			String[] statn=StateUtil.resetname.split(",");
			DateFormat f1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			for(int i=0;i<list.size();i++) {
				Map<String, Object> ac=list.get(i);
				if(ac!=null) {
					labelC = new Label(0, i+1, ac.get("userid").toString());//用户ID
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String un="";
					if(ac.get("username")!=null) {
						un=ac.get("username").toString();
					}
					labelC = new Label(1, i+1, un);//用户名
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String in="";
					if(ac.get("invitation")!=null) {
						in=ac.get("invitation").toString();
					}
					labelC = new Label(2, i+1, in);//推荐人
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(3, i+1, ac.get("orderid").toString());//订单ID
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String an="";
					if(ac.get("countryn")!=null) {
						an=ac.get("countryn").toString();
					}
					if(ac.get("provincen")!=null) {
						an+=ac.get("provincen").toString();
					}
					if(ac.get("cityn")!=null) {
						an+=ac.get("cityn").toString();
					}
					labelC = new Label(4, i+1, an);//目的地
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(5, i+1, f1.format(ac.get("begintime")));//开始时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(6, i+1, f1.format(ac.get("endtime")));//结束时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(7, i+1, ac.get("languagename").toString());//语种
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String level="";
					if(ac.get("level").toString().equals("2")) {
						level="口译员";
					} else if(ac.get("level").toString().equals("3")) {
						level="高级口译员";
					}
					labelC = new Label(8, i+1, level);//等级
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String st="";
					if(ac.get("specialtyname")!=null) {
						st=ac.get("specialtyname").toString();
					}
					labelC = new Label(9, i+1, st);//专业
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String cn="已退";
					if(ac.get("cancel").toString().equals("0")) {
						cn="未退";
					}
					labelC = new Label(10, i+1, cn);//是否退款
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
//					labelC = new Label(10, i+1, ac.get("price").toString());//价格
//					labelC.setCellFormat(cellFormatn);
//					ws.addCell(labelC);
//					
//					labelC = new Label(11, i+1, ac.get("money").toString());//总金额
//					labelC.setCellFormat(cellFormatn);
//					ws.addCell(labelC);
					
					String mo="";
					if(ac.get("istimely").toString().equals("0")) {
						if(ac.get("reset").toString().equals("2")) {
		            		//翻译取消(用户预约在48小时之外,取消时间离预约时间在48小时之内)
			            	mo="用户退钱￥"+ac.get("bondmoney").toString()+",翻译扣钱$"+ac.get("fanyifine").toString();
		            	} else if(ac.get("reset").toString().equals("0")) {
		            		//用户取消或翻译取消(用户预约在48小时之内或用户预约在48小时之外,取消时间离预约时间在48小时之外)
		            		mo="用户退钱￥"+ac.get("bondmoney").toString();
		            	} else if(ac.get("reset").toString().equals("1")) {
		            		//用户取消(用户预约在48小时之外,取消时间离预约时间在48小时之内)
		            		mo="用户扣钱￥"+ac.get("userfine").toString();
		            	}
					} else {
						if(ac.get("state").toString().equals("6")) {
	            			mo="不退不扣";
	            		} else {
	            			mo="翻译扣钱￥"+ac.get("isprice").toString();
	            		}
					}
					labelC = new Label(11, i+1, mo);//退钱/扣钱详情
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String rm="";
					if(ac.get("remark")!=null) {
						rm=ac.get("remark").toString();
					}
					labelC = new Label(12, i+1, rm);//备注
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(13, i+1, f1.format(ac.get("createtime")));//发布时间
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String res="";
					if(ac.get("istimely").toString().equals("0")) {
						res=statn[Integer.valueOf(ac.get("reset").toString())];
					}
					labelC = new Label(14, i+1, res);//状态
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String po="翻译";
					if(ac.get("state").toString().equals("6")) {
						po="用户";
					}
					labelC = new Label(15, i+1, po);//取笑人
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					//取消时间
					if(ac.get("canceltime")!=null) {
						labelC = new Label(16, i+1, f1.format(ac.get("canceltime")));
					} else {
						labelC = new Label(16, i+1, "");
					}
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String opaytype="";
					if(ac.get("opaytype").toString().equals("0")) {
						opaytype="支付宝";
	            	} else if(ac.get("opaytype").toString().equals("1")) {
	            		opaytype="微信";
	            	} else if(ac.get("opaytype").toString().equals("2")) {
	            		opaytype="余额";
	            	}
					labelC = new Label(17, i+1, opaytype);//支付方式
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					labelC = new Label(18, i+1, ac.get("odealorderid").toString());//支付订单号
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
					
					String istime="普通订单";
					if(ac.get("istimely").toString().equals("1")) {
						istime="即时订单";
					}
					labelC = new Label(19, i+1, istime);//订单类型
					labelC.setCellFormat(cellFormatn);
					ws.addCell(labelC);
				}
			}
			
			// 合并单元格
			//ws.mergeCells(3, 0, 4, 0);//竖、横、竖、横
			wwb.write();
			wwb.close();

		} catch (Exception e) {
			throw e;
		}
	}
}
