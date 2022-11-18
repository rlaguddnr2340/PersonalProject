package kr.co.khw.portfolio.member;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberMapper {

	public MemberVO LoginInfo(String username);
	public int Join(MemberVO vo);
}
