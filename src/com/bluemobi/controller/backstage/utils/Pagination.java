package com.bluemobi.controller.backstage.utils;

/**
 * 分页对象
 * @author xiaojin_wu
 * @datetime 2017年7月25日15:18:17
 */
public class Pagination {
	
    private Pagination() { 
     
    }   
    private static volatile Pagination instance;  

    //定义一个共有的静态方法，返回该类型实例
    public static Pagination getIstance() { 
        if (instance == null) {
            synchronized (Pagination.class) {
                if (instance == null) {
                    instance = new Pagination();   
                }   
            }   
        }   
        return instance;   
    } 
	
	/**
	 * 
	 * @param url
	 * 			页面controller入口
	 * @param offset
	 * 			当前标号
	 * @param row
	 * 			每页展示条数
	 * @param all
	 * 			总条数
	 * @return
	 * 		前端分页html
	 */
	public String getPaginationHtml(String url,String offset,String row,String count){
		StringBuffer html = new StringBuffer();
		html.append("<ul class='pagination'><li>");
		int offset_ = Integer.valueOf(offset);
		int row_ = Integer.valueOf(row);
		int count_ = Integer.valueOf(count);
		int offset_first = 0;//首页标号
		int offset_pre = offset_ - row_;//前一页标号
		int offset_later = offset_ + row_;//下一页标号
		int offset_end = (count_/row_)*row_;//尾页标号
		int count_offset = count_/row_+1;//总页码
		int count_current = offset_/row_+1;//当前页码
		/**
		 * 显示页码，首页,上一页,当前页码/总页码,下一页,尾页
		 */
		
		html.append("<a href=").append(url).append("?offset=").append(offset_first).append("&row=")
			.append(row).append(">首页</a></li><li>");
		//如果没有前一页，不能点击
		if(offset_pre < 0){
			html.append("<a>前一页</a></li><li>");
		}else{
			html.append("<a href=").append(url).append("?offset=").append(offset_pre).append("&row=")
			.append(row).append(">前一页</a></li><li>");
		}
		
		//展示当前页码/总页码
		html.append("<a href='javascript:void();'>").append(count_current).append("/").append(count_offset).append("</a></li><li>");
		
		//如果没有下一页，不能点击
		if(offset_later>offset_end){
			html.append("<a>下一页</a></li><li>");
		}else{
			html.append("<a href=").append(url).append("?offset=").append(offset_later).append("&row=")
			.append(row).append(">下一页</a></li><li>");
		}
		
		html.append("<a href=").append(url).append("?offset=").append(offset_end).append("&row=")
		.append(row).append(">尾页</a></li></ul>");
		return html.toString();
	}
}

