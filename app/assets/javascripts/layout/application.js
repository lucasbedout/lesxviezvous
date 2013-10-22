var main = {
	user_condition : 1,
	user : function(){
		console.log(main.user_condition)
		if($("#user-widget").css("display") == "none")
		$("#user-widget").fadeIn(100);
		else
		$("#user-widget").fadeOut(100);
	}
};

var posts = {
	number : 1
};