function checkBrowser(){
 var browser={
  versions:function(){
   var u = navigator.userAgent, app = navigator.appVersion;
   return {
    //移动终端浏览器版本信息
    trident: u.indexOf('Trident') > -1, //IE内核
    presto: u.indexOf('Presto') > -1, //opera内核
    webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
    gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
    mobile: !!u.match(/AppleWebKit.*Mobile.*/)||!!u.match(/AppleWebKit/), //是否为移动终端
    ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
    android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
    iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
    iPad: u.indexOf('iPad') > -1, //是否iPad
    webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
    };
   }(),
    language:(navigator.browserLanguage || navigator.language).toLowerCase()
   }
 if( browser.versions.android || browser.versions.iPhone || browser.versions.iPad){
 // window.location.href="http://www.cddfcb.com"

 }
}

 var system ={win:false,mac:false,xll:false};
 //检测平台
 var p = navigator.platform;
 system.win = p.indexOf("Win") == 0;
 system.mac = p.indexOf("Mac") == 0;
 system.x11= (p=="X11")||(p.indexOf("Linux")==0);
 //跳转语句，如果是手机访问就自动跳转到wap.seostudying.com页面
if(system.win||system.mac||system.xll){
   // window.location.href="http://www.cddfcb.com/";/*如果是电脑访问就跳转到这个网址*/
   }
 else{
   //window.location.href="http://www.cddfcb.com/app";/*如果是手机访问就跳转到这个网址*/
   }
 
 
 $(function(){
			$(window).scroll(function(){
				if($(window).scrollTop()>610){
					$('.nav').addClass('selected');
				}else{
					$('.nav').removeClass('selected');
				};
			});
			$('#nav').onePageNav({
		        filter: ':not(.external)',
		        scrollThreshold: 0.25,
		        scrollOffset: 0,
		        end:function(){
		        	var $left = $('.current').position().left;
	        		$('#nav .back').stop().animate({'left':$left},"fast");
		        },
		        scrollChange: function(){
		        	var $left = $('.current').position().left;
	        		$('#nav .back').stop().animate({'left':$left},"fast");
		        }
	    	});
			//
			
		});
		
	//首页	
