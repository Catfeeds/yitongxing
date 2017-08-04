package com.bluemobi.controller.app;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.RefundApply;
import com.bluemobi.po.RefundHandle;
import com.bluemobi.po.WithdrawCashApply;
import com.bluemobi.po.WithdrawCashHandle;
import com.bluemobi.service.RefundApplyService;
import com.bluemobi.service.RefundHandleService;
import com.bluemobi.service.WithDrawCashApplyService;
import com.bluemobi.service.WithDrawCashHandleService;
import com.bluemobi.to.ResponseBean;

/**
 * app退款申请接口
 */
@Controller
@RequestMapping("app/refund")
public class AppRefundApplyController extends AbstractWebController {

	@Autowired
	private RefundApplyService refundApplyService;
	
	@Autowired
	private RefundHandleService refundHandleService;
	
	@Autowired
	private WithDrawCashApplyService withDrawCashApplyService;
	
	@Autowired
	private WithDrawCashHandleService withDrawCashHandleService;
	
	
	@RequestMapping(value = "refundApply", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean refundApply(HttpServletRequest request,
			HttpServletResponse response) {
//		RefundApply refundApply = new RefundApply();
//		refundApply.setAccount("12345678");
//		refundApply.setApplytime(new Date());
//		refundApply.setBackup("备注");
//		refundApply.setMoney(1.00);
//		refundApply.setOrderid("D16062414069315672");
//		refundApply.setPlatform(0);
//		refundApply.setReason("退款原因");
//		refundApply.setState(0);
//		refundApplyService.insertRefundApply(refundApply);
		
		RefundHandle refundHandle = new RefundHandle();
		refundHandle.setApplyid(1);
		refundHandle.setBackup("退款处理备注");
		refundHandle.setHandleby("Teemo");
		refundHandle.setHandletime(new Date());
		refundHandle.setMoney(6.66);
		refundHandle.setState(1);
		refundHandleService.insertRefundHandle(refundHandle);
		
		WithdrawCashApply withdrawCashApply = new WithdrawCashApply();
		withdrawCashApply.setAccount("13554118952");
		withdrawCashApply.setApplytime(new Date());
		withdrawCashApply.setBackup("提现备注备注");
		withdrawCashApply.setMoney(8.88);
		withdrawCashApply.setPlatform(0);
		withdrawCashApply.setState(0);
		withdrawCashApply.setUserid(3085);
		withDrawCashApplyService.insertWithdrawCashApply(withdrawCashApply);
		
		WithdrawCashHandle withdrawCashHandle = new WithdrawCashHandle();
		withdrawCashHandle.setApplyid(1);
		withdrawCashHandle.setBackup("提现受理备注");
		withdrawCashHandle.setHandleby("Teemo");
		withdrawCashHandle.setHandletime(new Date());
		withdrawCashHandle.setMoney(10.01);
		withdrawCashHandle.setState(1);
		withDrawCashHandleService.insertWithdrawCashHandle(withdrawCashHandle);
		return new ResponseBean(ResponseBean.SUCCESS, "退款申请成功");
	}

}