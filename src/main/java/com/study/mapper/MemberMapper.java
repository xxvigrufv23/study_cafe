package com.study.mapper;

import com.study.model.MemberVO;

public interface MemberMapper {

	/* 회원가입 */
	public void memberJoin(MemberVO member);

	/* 회원가입 시 이메일 중독 여부 확인 */
	public int idCheck(String memberId);
	
}
