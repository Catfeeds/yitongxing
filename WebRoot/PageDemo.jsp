<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="blank" />
<meta name="format-detection" content="telephone=no" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的网站Demo</title>
<meta name="keywords" content="译同行-上海译同行网络科技有限公司" />
<meta name="description" content="“译同行”品牌，是由一批具有多年留学背景的海归人士、知名上市公司高管、20年以上金融行业管理经验的资深人士、中欧商学院校友团队成员等组建而成的团队，全力打造。每一位股东成员都具有独特的成长经历和相应的人格魅力及影响力，并在各自所属行业积累了丰富的管理经验，极具独到的发展眼光和真知灼见。" />   
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/slider.css" rel="stylesheet" type="text/css">
<script src="js/jquery.1.7.2.min.js" type="text/javascript"></script>
<script src="js/index.web.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.flexslider-min.js"></script>
<script type="text/javascript" src="js/jquery.scrollTo.js"></script>
<script type="text/javascript" src="js/jquery.nav.js"></script>
<script type="text/javascript" src="js/index.js"></script>
<link rel="icon" href="images/favicon.ico">
</head>

<body>
<div class="header nav">
<div class="wrap">
  <div class="header_r fr">
    <div class="menu" id="nav">
      <ul>
        <li class='current'><a href='#home' class="selected">首页</a></li>
        <li><a href='#service'>服务</a></li>
        <li><a href='#concept'>理念</a></li>
        <li><a href='#about'>我们</a></li>
        <li><a href='#contact'>联系</a></li>
      </ul>
      <div class="clear"></div>
    </div>
  </div>
  <div class="logo"><a href="index.htm"><img src="images/logo.png"></a></div>
  </div>
</div>
<a name="home" id="home"></a>
<div class="index_slider">
  <div class="flexslider">
    <ul class="slides">
	
	  <li style="background:url(images/fl03.jpg) 50% 0 no-repeat;background-size:cover;">
        <div class="text">
          <p><font size=7>Who?</font></p>
          <p class="font02">有了<span class="ee">译</span><span>同行</span>，出行更容易！</p>
        </div>
      </li>
    
      <li style="background:url(images/fl01.jpg) 50% 0 no-repeat;background-size:cover;">
        <div class="text">
          <p><font size=7>Why?</font></p>
          <p class="font02">出境语言不通，<span>出境交通不便，</span>出境地方不熟</p>
        </div>
      </li>
      
      
       <li style="background:url(images/fl02.jpg) 50% 0 no-repeat;background-size:cover;">
        <div class="text">
          <p><font size=7>What?</font></p>
          <p class="font02"><span>提供专业的翻译以及陪同，</span><br>为您的出行解决无后顾之忧</p>
        </div>
      </li>
      
      <li style="background:url(images/fl04.jpg) 50% 0 no-repeat;background-size:cover;">
        <div class="text">
          <p><font size=7>How?</font></p>
          <p class="font02">我们<span>倾尽全力</span>，提供全球海外译员</p>
        </div>
      </li>
      
    </ul>
  </div>
</div>
<a name="service" id="service"></a>
<div class="services index_mk">
  <div id='business' style='position:absolute;top:-180px;left:0px;'></div>
  <p class="font01" align="center"><span>OUR</span> SERVICE</p>
  <p class="font02" align="center">我们<span>能做什么</span></p>
<!--  <div class="tab"><a class="cur"></a><a></a></div>-->
  <div id="kinMaxShow" class="cont">
		<div style="background:#fff;">
        	<div class="da-slide">
  <div class="tab_text">
  </div> 
      <div class="list01 mk">
        <div class="imgico da-img"><img src="images/imgico01.png"></div>
        <p>提供跨境的翻译服务</p>
      </div>
      <div class="list02 mk">
        <div class="imgico da-img"><img src="images/imgico02.png"></div>
        <p>千余名目的地翻译人员可供您选择</p>
     </div>
      <div class="list03 mk">
        <div class="imgico da-img"><img src="images/imgico03.png"></div>
        <p>常见的口语、旅游、商务出行、代办签证</p>
      </div>
    </div>
        </div>
    	<div style="background:#fff;">
        	<div class="da-slide" style="margin:20px 33px 30px !important">
  <div class="tab_text">
  </div>
      <div class="list04 mk">
        <div class="imgico da-img"><img src="images/imgico04.png"></div>
        <p>提供精准的目的地附近查找翻译服务，避免语言沟通不便，省去传统翻译人员商务随行的巨额差旅、交通和住宿费用，让您出行费用更节省。</p>
      </div>
      <div class="list05 mk">
        <div class="imgico da-img"><img src="images/imgico05.png"></div>
        <p>完整的翻译人员个人简历，完善的服务评价体系，让您选择更适合的翻译服务人员，体验更专业、更贴心的随行翻译服务。</p>
      </div>
      <div class="list06 mk">
        <div class="imgico da-img"><img src="images/imgico06.png"></div>
        <p>安全的第三方支付平台，完成订单对翻译服务满意后确认支付，让您随时随地掌握主动。</p>
      </div>
    </div>
        </div>
 		
     </div>       
</div>
<div class="service_banner">
  <p align="center"><span class="red">互联网+ </span>语言翻译 <span class="red">&amp; </span>中文向导 <span class="red">&amp;</span>出境帮手   </p>
</div>
<a name="concept" id="concept"></a>
<div class="concept index_mk">
  <p class="font01" align="center"><span>OUR</span> CONCEPT</p>
  <p class="font02" align="center">我们<span>想做什么</span></p>
  <div class="wrap">
    <div class="img"><img src="images/phoneimg.png"></div>
    <div class="list">
      <ul>
        <li>
          <p class="tit">我们想成为您的耳舌：</p>
          <p class="txt">寸有所短，尺有所长，术业有专攻，让专业的人做专业的事。不要让语言成为<br>
            您沟通时的障碍，我们立志于成为您的耳舌，替您听取信息，为您表达言语，<br>
            让跨越国界的沟通变得更为便捷，让您拥有更多的时间，专于您的所长。</p>
        </li>
        <li>
          <p class="tit">我们想成为一座桥梁：</p>
          <p class="txt">语言是通往彼此心灵的桥梁，前南非总统纳尔逊·曼德拉曾经说过："If you talk to a man in a language he understands, that goes to his head. Ifyou talk to him in his own language, that goes to his heart." <span style="font-weight:bold;color:#3a3a3a;font-size:15px;">如果你用别人能理解的语言与对方谈话，那么谈话会进入对方的大脑。如果你用对方的语言与之谈话，那么谈话会进入对方的心里。</span>而我们将致力于为您搭建这条通往对方心灵的桥梁。</p>
        </li>
      </ul>
    </div>
    <div class="clear"></div>
  </div>
</div>
<div class="concept_banner">
  <div class="wrap inner">
      <div class="row text-center services-3">
        <div class="col-sm-3">
          <div class="col-wrapper">
            <div class="icon-border icon1"></div>
            <h4>发现</h4>
          </div>
        </div>
        <div class="col-sm-3">
          <div class="col-wrapper">
            <div class="icon-border icon2"></div>
            <h4>创新</h4>
          </div>
        </div>
        <div class="col-sm-3">
          <div class="col-wrapper">
            <div class="icon-border icon3"></div>
            <h4>态度</h4>
          </div>
        </div>
        <div class="col-sm-3">
          <div class="col-wrapper">
            <div class="icon-border icon4"> </div>
            <h4>客户向导</h4>
          </div>
        </div>
        <div class="clear"></div>
      </div>
    </div>
</div>
<a name="about" id="about"></a>
<div class="about index_mk">
  <p class="font01" align="center"><span>ABOUT</span> US</p>
  <p class="font02" align="center">我们<span>擅长做什么</span></p>
    <div class="about_list">
    	<ul>
        	<li class="list1">
            	<p class="tit">发现</p>
                <p>善于发现的眼光，发现不满，发现用户，发现需求，发现痛点，发现应对，发现机会。</p>
            </li>
            <li class="list2">
            	<p class="tit">创新</p>
                <p>勇于创新的思维，设定方向，探索未知，小步快跑，迅速试错，及时转变，不断迭代。</p>
            </li>
            <li class="list3">
            	<p class="tit">态度</p>
                <p>一往无前的态度，敢于变革，积极尝试，直面挑战，坚定不移，打破过去，拥抱未来。<br><br></p>
            </li>
            <li class="list4">
            	<p class="tit">客户导向</p>
                <p>以客户需求为出发点，避免本位主义，不妄加猜测，克制自我膨胀。不断的探索，不断的验证，在往复中完成积累，最终为客户创造价值。</p>
            </li>
        </ul>
  </div>
</div>
<a name="contact" id="contact"></a>
<div class="contact index_mk">
  <p class="font01" align="center"><span>CONTACT</span> US</p>
  <p class="font02" align="center">联系<span>我们</span></p>
  <div class="wrap">
  <div style="width:80%;margin:0 auto 30px;text-align:left;">
  <p style="text-indent:2em;">"译同行"品牌，是由一批具有多年留学背景的海归人士、知名上市公司高管、20年以上金融行业管理经验的资深人士、中欧商学院校友团队成员等组建而成的团队，全力打造。每一位股东成员都具有独特的成长经历和相应的人格魅力及影响力，并在各自所属行业积累了丰富的管理经验，极具独到的发展眼光和真知灼见。</p>
<p style="text-indent:2em;">尤其难能可贵的是——已经位于各自行业及事业巅峰的他们，仍然满怀一颗充满激情的年轻的心，在"互联网+"所催生的经济社会发展新形态下，敢于探索、善于发现、勇于创新、忠于梦想，致力于搭建一个全新的互联网服务平台，主推并运营"译同行"手机App软件。将企业愿景定位于："打造一个跨国界、全球化，服务大众的异地翻译服务预约平台！"在满足用户需求的同时，创造一种全新的消费模式，打破信息孤岛、沟通壁垒和地缘结构，颠覆以往传统的跨境出行模式，让出境游不再受限于跟团，让自由行不再属于年轻人，让语言不再成为沟通的障碍，让说走就走的旅行不再犹豫。</p>
<p style="text-indent:2em;">公司目前正值用人之际，广招有识之士加盟团队，共同追求梦想，创造未来，用智慧与激情将不可能变为可能，在工作中塑造更好的自己，用自己的双手打造更为灿烂的明天。梦想属于我们，未来属于互联网。</p></div>
    <div>
      <ul>
        <li class="list01">
          <div class="bg">
            <p>公司地址：<br>上海市长宁区金钟路658弄东华大学<br>国家科技园1号楼B座5楼</p>
          </div>
        </li>
        <li class="list02">
          <div class="bg">
            <p>联系邮箱：<br><a href="mailto:yitongxing@5Aabc.com">yitongxing@5Aabc.com</a>,<br><a href="mailto:help@5Abc.com">help@5Abc.com</a></p>
          </div>
        </li>
        <li class="list03">
          <div class="bg">
            <p>联系电话：<br>
              <a href="tel:(86-21)62331071">(86-21)62331071</a>,<br><a href="tel:(86-21)62331072-307">(86-21)62331072-307</a> 张小姐</p>
          </div>
        </li><br><br>
        <li class="list04">
          <div class="bg">
            <p>关注微信二维码</p>
            <p><img src="images/weixin.jpg" width="150"></p>
          </div>
        </li>
        <li class="list04">
          <div class="bg">
            <p>下载翻译员端APP</p>
            <p><img src="images/huiyuan.png" width="150"></p>
          </div>
        </li>
		<li class="list04">
          <div class="bg">
            <p>下载用户端APP</p>
            <p><img src="images/yonghu.png" width="150"></p>
          </div>
        </li>
      </ul>
      <div class="clear"></div>
    </div>
  </div>
</div>
<div class="footer">
  <p>Copyright @ 译同行&nbsp;&nbsp;上海译同行网络科技有限公司&nbsp;&nbsp;&nbsp;&nbsp;沪ICP备15052926号</p>
</div>
</body>
</html>
