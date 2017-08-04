package com.bluemobi.controller.backstage;

import java.net.URLDecoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.controller.backstage.utils.Pagination;
import com.bluemobi.dao.RefundHandleDao;
import com.bluemobi.po.RefundHandle;
import com.bluemobi.service.RefundApplyService;
import com.bluemobi.to.ResponseBean;


/**
 * @author   xiaojin_wu
 * @datetime 2017年7月28日
 * @description
 * 			 后台退款申请
 */
@Controller
@RequestMapping("/backstage/refund")
public class RefundApplyController extends AbstractWebController{

	/**
	 * 退款申请服务
	 */
	@Autowired
	private RefundApplyService refundApplyService;
	
	/**
	 * 退款申请受理服务
	 */
	@Autowired
	private RefundHandleDao refundHandleDao;
	
	/**
	 * 后台查看退款申请列表
	 */
	@RequestMapping(value = "/refundApplyList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台退款申请查看列表");
		String offset = request.getParameter("offset"); 
		String row = request.getParameter("row");
		Map<String, Object> map = new HashMap<>();
		LOGGER.info("订单页码---------"+offset+","+row);
		//默认首页
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(offset)){
			offset = "0";
		}
		//默认首页15条数据
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(row)){
			row = "15";
		}
		map.put("offset", Integer.valueOf(offset));
		map.put("rows", Integer.valueOf(row));
		List<Map<String, Object>> list = refundApplyService.getRefundApplyList(map);
		int count = refundApplyService.getRefundApplyListCount();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/refund/refundApplyList", offset, row, count+""));
		return "/refund/refundApplyList";
	}
	
	/**
	 * 手动处理退款申请
	 */
	@RequestMapping(value = "/handle")
	@ResponseBody
	public ResponseBean handle(HttpServletRequest request) {
		ResponseBean responseBean = null;
		String applyid = request.getParameter("applyid");//退款申请id
		String refundmoney = request.getParameter("refundmoney");
		String state = request.getParameter("state");//'0、拒绝退款申请 1、通过申请',
		String handleby = request.getParameter("handleby");
		String backup = request.getParameter("backup");
		
		try {
			handleby = URLDecoder.decode(handleby,"utf-8");
			backup = URLDecoder.decode(backup,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(StringUtils.isNotEmpty(applyid)){
			//新增退款处理记录
			RefundHandle refundHandle = new RefundHandle();
			refundHandle.setApplyid(Integer.valueOf(applyid));
			refundHandle.setMoney(Double.valueOf(refundmoney));
			refundHandle.setHandleby(handleby);
			refundHandle.setState(Integer.valueOf(state));
			refundHandle.setHandletime(new Date());
			refundHandle.setBackup(backup);
			refundHandleDao.insertRefundHandle(refundHandle);
			//修改退款申请状态，由未受理改为已受理
			Map<String,Object> map = new HashMap<>();
			map.put("state", 1);
			map.put("applyid", applyid);
			refundApplyService.updateState(map);
			responseBean = new ResponseBean(ResponseBean.SUCCESS,"退款申请处理成功");
		}else{
			responseBean = new ResponseBean(ResponseBean.FAIL,"退款申请处理失败，参数不全");
		}
		return responseBean;
	}
	
}
