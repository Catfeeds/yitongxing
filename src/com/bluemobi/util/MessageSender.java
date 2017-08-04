package com.bluemobi.util;

import java.util.ArrayList;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.esms.MessageData;
import com.esms.PostMsg;
import com.esms.common.entity.Account;
import com.esms.common.entity.GsmsResponse;
import com.esms.common.entity.MTPack;

/**
 * 信息处理类
 * 
 * @author heweiwen 2015-7-10 下午3:26:32
 */
public class MessageSender {
    /** 日志生成器 */
    private static final Logger LOGGER = LoggerFactory
            .getLogger(MessageSender.class);

    private MessageSender() {
    }

    /** 短信发送失败标识 */
    private static final String MSG_SEND_RESULT_NG = "001";
    /** 短信发送成功标识 */
    private static final String MSG_SEND_RESULT_OK = "002";

    /**
     * 
     * @author HeWeiwen 2015-7-10
     * @param messageContent
     *            信息内容
     * @param mobileNumber
     *            发送对象手机号码
     * @param userSn
     *            短信服务商账号
     * @param userPwd
     *            短信服务商密码
     * @param sendGatewayIP
     *            设置发送网关的IP
     * @param sendGatewayPort
     *            设置发送网关端口的Port
     * @param getGatewayIP
     *            设置接受网关的IP
     * @param getGatewayPort
     *            设置接受网关的Port
     * @return
     */
    public static String sendShortMessage(String messageContent,
            String mobileNumber, String userSn, String userPwd,
            String sendGatewayIP, int sendGatewayPort, String getGatewayIP,
            int getGatewayPort) {
        // 短信发送成功标识
        String sendFlg = MSG_SEND_RESULT_OK;
        // 平台返回发送结果
        int resultCode = 0;
        // 非空参数判断
        if (messageContent == null || mobileNumber == null || userSn == null
                || userPwd == null || sendGatewayIP == null
                || getGatewayIP == null) {
            return MSG_SEND_RESULT_NG;
        }
        if (sendGatewayPort == 0 || getGatewayPort == 0
                || mobileNumber.trim().length() == 0
                || messageContent.trim().length() == 0
                || userSn.trim().length() == 0) {
            return MSG_SEND_RESULT_NG;
        }
        if (userPwd.trim().length() == 0 || sendGatewayIP.trim().length() == 0
                || getGatewayIP.trim().length() == 0) {
            return MSG_SEND_RESULT_NG;
        }
        // 消息发送处理
        try {
            Account ac = new Account(userSn, userPwd);// 用户名,密码
            PostMsg pm = new PostMsg();
            pm.getCmHost().setHost(sendGatewayIP, sendGatewayPort);// 设置网关的IP和port，用于发送信息
            pm.getWsHost().setHost(getGatewayIP, getGatewayPort);// 设置网关的IP和port，用于接收信息
            UUID batchId = UUID.randomUUID();
            MTPack pack = new MTPack();
            pack.setBatchID(batchId);
            pack.setBatchName(batchId.toString());
            pack.setMsgType(MTPack.MsgType.SMS);
            pack.setBizType(0);
            pack.setDistinctFlag(false);
            ArrayList<MessageData> msgs = new ArrayList<MessageData>();
            pack.setSendType(MTPack.SendType.MASS);
            msgs.add(new MessageData(mobileNumber, messageContent));
            pack.setMsgs(msgs);
            GsmsResponse resp = pm.post(ac, pack);
            // 取得平台返回结果
            resultCode = resp.getResult();
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append(batchId);
            stringBuilder.append(":");
            stringBuilder.append(mobileNumber);
            stringBuilder.append(":");
            stringBuilder.append(messageContent);
            stringBuilder.append(":");
            stringBuilder.append(resp);

            // 判断返回参数
            if (resultCode < 0) {
                sendFlg = MSG_SEND_RESULT_NG;
            }
            LOGGER.info("返回参数:stringBuilder:", stringBuilder);
        } catch (Exception e) {
            LOGGER.error("Exception:【{}】", e);
            sendFlg = MSG_SEND_RESULT_NG;
            LOGGER.error(e.getLocalizedMessage());
        }
        // 返回短信发送成功标识
        return sendFlg;
    }

    public static String sendAuthCode(String messageContent, String mobileNumber) {
        // 短信发送成功标识
        String sendFlg = MSG_SEND_RESULT_OK;
        if (messageContent == null || mobileNumber == null
                || mobileNumber.trim().length() == 0
                || messageContent.trim().length() == 0) {
            return MSG_SEND_RESULT_OK;
        }
        try {
            String sn = "DXX-WSS-10H-06054";// 第二种用名：(010@bjlj)
            String pwd = "014454";// 第二种密码：(Smartor6636389!)
            String serviceURL = "http://sdk2.entinfo.cn:8061/webservice.asmx";
            MessageSendClient messageSendClient = new MessageSendClient(sn,
                    pwd, serviceURL);
            String sign = "【淘美人】";
            // 短信发送
            String resultMdsmssend = messageSendClient.mdsmssend(mobileNumber,
                    messageContent + sign, "", "", "", "");
            LOGGER.info(resultMdsmssend);
        } catch (Exception e) {
            LOGGER.error("Exception:【{}】", e);
            sendFlg = MSG_SEND_RESULT_NG;
            LOGGER.error(e.getLocalizedMessage());
        }
        // 返回短信发送成功标识
        return sendFlg;
    }
}
