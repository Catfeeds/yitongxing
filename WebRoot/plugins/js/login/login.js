function login(){
	alert(111);
	var url = $("#form").attr('action');
	var username = $("#username").val();
	var password = $("#password").val();
	$.ajax({   
	    url:url,   
	    type:'post',   
	    data:{"username":username,"password":password},   
	    error:function(){   
	       alert('网络异常');   
	    },   
	    success:function(data){   
	       alert(data.state);
	    }
	});
}