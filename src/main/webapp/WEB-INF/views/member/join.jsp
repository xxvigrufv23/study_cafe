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
				</div>
				<span  class="id_input_re_1" style="display: none; margin: 14px 0px 0px -9px;">사용 가능한 아이디입니다.</span>
				<span  class="id_input_re_2" style="display: none; margin: 14px 0px 0px -9px;">해당 아이디가 이미 존재합니다.</span>
				<span class="final_id_ck">아이디를 입력해주세요.</span>
			</div>
			<div class="pw_wrap">
				<div class="pw_name">비밀번호</div>
				<div class="pw_input_box">
					<input class="pw_input" type="password"  name="memberPw">
				</div>
				<span class="final_pw_ck">비밀번호를 입력해주세요.</span>
			</div>
			<div class="pwck_wrap">
				<div class="pwck_name">비밀번호 확인</div>
				<div class="pwck_input_box">
					<input class="pwck_input" type="password">
				</div>
				<div id="alert-success">비밀번호가 일치합니다.</div>
				<div id="alert-danger">비밀번호가 일치하지 않습니다.</div>
				<span class="final_pwck_ck">비밀번호 확인을 입력해주세요.</span>
			</div>
			<div class="user_wrap">
				<div class="user_name">이름</div>
				<div class="user_input_box">
					<input class="user_input" name="memberName">
				</div>
				<span class="final_name_ck">이름을 입력해주세요.</span>
			</div>
			<div class="mail_wrap">
				<div class="mail_name">이메일</div> 
				<div class="mail_input_box">
					<input class="mail_input" name="memberMail">
				</div>
				<span class="final_mail_ck">이메일을 입력해주세요.</span>
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
						<input class="address_input_1" name="memberAddr1" readonly>
					</div>
					<button class="address_button" onclick="execution_daum_address()">
						<span>주소 찾기</span> 
					</button>
					<div class="clearfix"></div>
				</div>
				<div class ="address_input_2_wrap">
					<div class="address_input_2_box">
						<input class="address_input_2" name="memberAddr2" readonly>
					</div>
				</div>
				<div class ="address_input_3_wrap">
					<div class="address_input_3_box">
						<input class="address_input_3" name="memberAddr3" readonly>
					</div>
				</div>
				<span class="final_addr_ck">주소를 입력해주세요.</span>
			</div>
			<div class="join_button_wrap">
				<input type="button" class="join_button" value="가입하기">
			</div>
		</div>
	</form>
</div>

</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var code = ""; //e-mail 인증번호 저장을 위한 코드 변수 선언.

/* 유효성 검사 통과유무 변수 */
var idCheck = false;              // 아이디
var idckCheck = false;            // 아이디 중복 검사
var pwCheck = false;              // 비번
var pwckCheck = false;            // 비번 확인
var pwckcorCheck = false;         // 비번 확인 일치 확인
var nameCheck = false;            // 이름
var mailCheck = false;            // 이메일
var mailnumCheck = false;         // 이메일 인증번호 확인
var addressCheck = false;         // 주소

/*회원 가입 버튼(회원가입 제출)*/
$(document).ready(function(){
	$(".join_button").click(function() {
		
		/* 입력값 변수 */
        var id = $('.id_input').val();                // id 입력란
        var pw = $('.pw_input').val();                // 비밀번호 입력란
        var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
        var name = $('.user_input').val();            // 이름 입력란
        var mail = $('.mail_input').val();            // 이메일 입력란
        var addr = $('.address_input_3').val();       // 주소 입력란
		
        
        /* 아이디 유효성 검사 */
        if(id == '') {
        	$('.final_id_ck').css('display', 'block');
        	idCheck = false;
        } else {
        	$('.final_id_ck').css('display', 'none');
        	idCheck = true;
        };
        
        /* 비밀번호 유효성 검사 */
        if(pw == ""){
            $('.final_pw_ck').css('display','block');
            pwCheck = false;
        }else{
            $('.final_pw_ck').css('display', 'none');
            pwCheck = true;
        }
        
        /* 비밀번호 확인 유효성 검사 */
        if(pwck == ""){
            $('.final_pwck_ck').css('display','block');
            pwckCheck = false;
        }else{
            $('.final_pwck_ck').css('display', 'none');
            pwckCheck = true;
        }
        
        /* 이름 유효성 검사 */
        if(name == ""){
            $('.final_name_ck').css('display','block');
            nameCheck = false;
        }else{
            $('.final_name_ck').css('display', 'none');
            nameCheck = true;
        }
        

        /* 이메일 유효성 검사 */
        if(mail == ""){
            $('.final_mail_ck').css('display','block');
            mailCheck = false;
        }else{
            $('.final_mail_ck').css('display', 'none');
            mailCheck = true;
        }
        
        /* 주소 유효성 검사 */
        if(addr == ""){
            $('.final_addr_ck').css('display','block');
            addressCheck = false;
        }else{
            $('.final_addr_ck').css('display', 'none');
            addressCheck = true;
        }
        
        /* 최종 유효성 검사 */
        if(idCheck&&idckCheck&&pwCheck&&pwckCheck&&pwckcorCheck&&nameCheck&&mailCheck&&mailnumCheck&&addressCheck){
        	$("#join_form").attr("action", "/member/join");
    		$("#join_form").submit();
        }    
		
        return false;
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
				idckCheck = true;
			} else {
				$('.id_input_re_2').css("display","inline-block");
				$('.id_input_re_1').css("display", "none");
				idckCheck = false;
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
        mailnumCheck = true;
	} else {                                           
        checkResult.html("인증번호를 다시 확인해주세요.");
        checkResult.attr("class", "incorrect");
        mailnumCheck = false;
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


/* Daum 주소 검색 Api */
function execution_daum_address() {
	console.log("1");
	
    //주소를 검색하는 팝업창을 띄우는 코드 부분 
	new daum.Postcode({
	    oncomplete: function(data) {
	        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	        
	    	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수
            
            console.log("2");

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
                console.log("3");
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
                console.log("4");
                console.log("4" + addr);
                
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                    console.log("5");
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    console.log("6");
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                    console.log("7");
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                addr += extraAddr;
            
            } else {
            	addr += '';
            }
            console.log("1"  + addr);

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            $(".address_input_1").val(data.zonecode);
            $(".address_input_2").val(addr);
            // 커서를 상세주소 필드로 이동한다.
            $(".address_input_3").attr("readonly",false);
            $(".address_input_3").focus();
	    }
	}).open();
}

</script>

</html>