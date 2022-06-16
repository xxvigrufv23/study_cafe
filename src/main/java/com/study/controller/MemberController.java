package com.study.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	
	
	//회원가입 페이지 이동
	@RequestMapping(value = "join", method = RequestMethod.GET)
	public void loginGET() {
		
	  logger.info("로그인 페이지 진입");
	  
	}
	
	@RequestMapping(value="/join", method = RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception {
		
		logger.info("[API CALLED === /member/join]");
		
		memberService.memberJoin(member);
		
		logger.info("member = " + member);
		logger.info("회원가입 로직 success");
		
		return "redirect:/main";
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void joinGET() {
		
	  logger.info("회원가입 페이지 진입");
	
	}
	

}
