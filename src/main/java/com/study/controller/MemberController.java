package com.study.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.model.MemberVO;
import com.study.service.MemberService;

import lombok.Setter;

/*
 * jaeyoun.choi
 * 2022-06-12
 * 회원과 관련된 요청
*/
@Controller
@RequestMapping(value = "/member") 
public class MemberController {
	
	
	//로그 추출 변수 선언
	private static final Logger logger = LoggerFactory.getLogger(BookController.class);
	
	@Setter(onMethod_=@Autowired)
	public MemberService memberService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	
	/* 회원가입 페이지 이동 */
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void loginGET() {
		
	  logger.info("로그인 페이지 진입");
	  
	}
	
	/* 회원가입 POST */
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {
		
		logger.info("[API CALLED === /member/join]");
		logger.info("[Content Log === Membership registration is successful.]");
		
		memberService.memberJoin(member);
		
		System.out.print("member = " + member);
		
		return "redirect:/main";
	}
	
	/* 로그인 페이지 이동 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void joinGET() {
		
	  logger.info("회원가입 페이지 진입");
	
	}
	
	/* 아이디 중복검사 */
	@RequestMapping(value = "memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception {
		
		//logger.info("[API CALLED : /member/memberIdChk ]" );
		int result = memberService.idCheck(memberId);

		if (result != 0) {
			return "fail";
		} else {
			return "success";
		}
	}

	/* 이메일 인증 */
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        logger.info("이메일 데이터 전송 확인");
        logger.info("인증번호 : " + email);
                
        Random randomVerificationNumber = new Random();
        int checkNum = randomVerificationNumber.nextInt(888888) + 111111;
        
        logger.info("인증번호 : " + checkNum);
        
        /* 이메일 보내기 */
        String setFrom = "cjy_calipso@naver.com"; //발신자
        String toMail = email;                    //수신자
        String title = "회원가입 인증 이메일 입니다.";    //제목
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + checkNum + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
 
        //숫자를 문자형으로 변환하는 방법 Integer.toString(숫자A);
        String num = Integer.toString(checkNum); 
        
        return num;
    }
   
}
