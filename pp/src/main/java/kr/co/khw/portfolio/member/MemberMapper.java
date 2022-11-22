package kr.co.khw.portfolio.member;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import util.PageInfo;

@Mapper
public interface MemberMapper {

	public MemberVO LoginInfo(String username);
	public int Join(MemberVO vo);
	
	//메인페이지 회원리스트
	public List<MemberVO> memberlist();
	
	//ID 중복체크
	public int idcheck(String id);
	
	//목로가져오기(페이징)
	public List<MemberVO> list(PageInfo pageinfo);
	
	//아이디 목록
	public int totalcount(PageInfo pageinfo);
}
