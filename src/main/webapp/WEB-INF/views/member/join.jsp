<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="/resources/css/member/join.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>

<div class="wrapper">
	<form id="join_form" method="post">
	<div class="wrap">
			<div class="subjecet">
				<span>회원가입</span>
			</div>
			<div class="id_wrap">
				<div class="id_name">아이디</div>
				<div class="id_input_box">
					<input class="id_input" name="memberId">
					<span  class="id_input_re_1" style="display: none; margin: 14px 0px 0px -9px;">사용 가능한 아이디입니다.</span>
					<span  class="id_input_re_2" style="display: none; margin: 14px 0px 0px -9px;">해당 아이디가 이미 존재합니다.</span>
				</div>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" type="password"  name="memberPw">
				</div>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" type="password">
				</div>
				<div id="alert-success">비밀번호가 일치합니다.</div>
				<div id="alert-danger">비밀번호가 일치하지 않습니다.</div>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" name="memberName">
				</div>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" name="memberMail">
				</div>
				<div class="mail_check_wrap">
					<div class="mail_check_input_box" id="mail_check_input_box_false">
						<input class="mail_check_input" disabled="disabled">
					</div>
					<div class="mail_check_button">
						<span>인증번호 전송</span>
					</div>
					<div class="clearfix"></div>
					<span id="mail_check_input_box_warn"></span>
				</div>
			</div>
			<div class="address_wrap">
				<div class="address_name">주소</div>
				<div class="address_input_1_wrap">
					<div class="address_input_1_box">
						<input class="address_input_1" name="memberAddr1">
					</div>
					<div class="address_button">
						<span>주소 찾기</span>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class ="address_input_2_wrap">
					<div class="address_input_2_box">
						<input class="address_input_2" name="memberAddr2">
					</div>
				</div>
				<div class ="address_input_3_wrap">
					<div class="address_input_3_box">
						<input class="address_input_3" name="memberAddr3">
					</div>
				</div>
			</div>
			<div class="join_button_wrap">
				<input type="button" class="join_button" value="가입하기">
			</div>
		</div>
	</form>
</div>

</body>
<script>
var code = ""; //e-mail 인증번호 저장을 위한 코드 변수 선언.

$(document).ready(function(){
	$(".join_button").click(function() {
		$("#join_form").attr("action", "/member/join");
		$("#join_form").submit();
	})
})

//아이디 중복 검사 
$('.id_input').on("propertychange change keyup paste input", function() {
//	console.log("::::keyup 테스트"); 
	var memberId = $('.id_input').val();
	var data = {memberId : memberId}
	
	$.ajax({
		type : "post",
		url : "/member/memberIdChk",
		data : data,
		success : function(result) {
			console.log("성공 여부" + result);
			if(result != 'fail'){
				$('.id_input_re_1').css("display","inline-block");
				$('.id_input_re_2').css("display", "none");				
			} else {
				$('.id_input_re_2').css("display","inline-block");
				$('.id_input_re_1').css("display", "none");				
			}
		} //Success 함수 
	}) //ajax 종료 
}); //함수 종료 .//


/* 인증번호 이메일 전송 */
$(".mail_check_button").click(function(){
    
	var email = $(".mail_input").val(); //입력한 이메일 
	var checkBox = $(".mail_check_input"); //인증번호 입력란
	var boxWrap = $("mail_check_input_box"); //인증번호 입력란 박스 
	
	$.ajax({
		type : "GET",
		url : "/member/mailCheck?email=" + email,
		
		success:function(data){
            
            console.log("data : " + data);
            checkBox.attr("disabled", false);
            boxWrap.attr("id", "mail_check_input_box_true");
            
            code = data;
        }
	})
	
});

/* 인증번호 비교 */
$(".mail_check_input").blur(function(){
	var inputCode = $(".mail_check_input").val(); //입력된 코드 
	var checkResult = $("#mail_check_input_box_warn"); // 비교 결과
    
	if(code == inputCode){
		checkResult.html("인증번호가 일치합니다.");
        checkResult.attr("class", "correct"); 
	} else {                                           
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
    }    
});

/* 비밀번호 재확인 비교  */
$(function(){
	$("#alert-success").hide();
	$("#alert-danger").hide();
	
	$("input").keyup(function(){
		var password = $(".pw_input").val(); //비밀번호
		var passwordChk = $(".pwck_input").val(); //비밀번호 확인
	    
		if (password != "" || passwordChk != "") {
			if (password == passwordChk) {
				$("#alert-success").show();
				$("#alert-danger").hide();
			} else {                                           
				$("#alert-success").hide();
				$("#alert-danger").show();
		    }    
		}	
	});
});

</script>

</html>