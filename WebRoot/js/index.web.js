// 图片左右滚动
function DY_scroll(wraper, prev, next, img, speed, or) {
    var wraper = $(wraper);
    var prev = $(prev);
    var next = $(next);
    var img = $(img).find('ul');
    var w = img.find('li').outerWidth(true);
    var s = speed;
    next.click(function() {
        img.animate({
            'margin-left': -w
        },
        function() {
            img.find('li').eq(0).appendTo(img);
            img.css({
                'margin-left': 0
            });
        });
    });
    prev.click(function() {
        img.find('li:last').prependTo(img);
        img.css({
            'margin-left': -w
        });
        img.animate({
            'margin-left': 0
        });
    });
    if (or == true) {
        ad = setInterval(function() {
            next.click();
        },
        s * 1000);
        wraper.hover(function() {
            clearInterval(ad);
        },
        function() {
            ad = setInterval(function() {
                next.click();
            },
            s * 1000);
        });

    }
}

$(document).ready(function() {
   //
   $('.flexslider').flexslider({
		directionNav: true,
		pauseOnAction: false
	});
	//
	DY_scroll('.img_scroll_a', '.prev_a', '.next_a', '.img_list_a', 3, true);  
	var minheight = parseInt($(window.parent).height());
	var main = $(window.parent.document).find(".flexslider");
	var main2 = $(window.parent.document).find(".flexslider .slides li");
	main.css("height",minheight);
	main2.css("height",minheight);
    //产品内页选项卡
    var $tags = $('.tab_tags a');
    $tags.click(function() {
        $(this).addClass('cur').siblings().removeClass('cur');
        var index = $tags.index(this);
		$('.tab_cont > ul').eq(index).show().siblings().hide();
		$('.tab_text > p').eq(index).show().siblings().hide();
    });
	
})

