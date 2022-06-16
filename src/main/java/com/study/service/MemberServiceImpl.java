package com.study.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.mapper.MemberMapper;
import com.study.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberMapper memberMapper;
	
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
//		member.setMemberId("memberId");
//		member.setMemberPw("memberPw");
//		member.setMemberName("memberName");
//		member.setMemberAddr1("memberAddr1");
//		member.setMemberAddr2("memberAddr2");
//		member.setMemberAddr3("memberAddr3");
//		member.setMemberMail("memberMail");
		
		

		memberMapper.memberJoin(member);
		
	
	}

}
