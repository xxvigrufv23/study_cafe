package com.study.service;

import com.study.model.MemberVO;

public interface MemberService {

	//회원가입 
	public void memberJoin(MemberVO member) throws Exception;
	
}
