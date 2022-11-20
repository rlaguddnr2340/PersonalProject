package kr.co.khw.portfolio.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	public MemberVO LoginInfo(String username);
	public int Join(MemberVO vo);
	
	//메인페이지 회원리스트
	public List<MemberVO> memberlist();
}
