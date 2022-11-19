package kr.co.khw.portfolio.member;

import lombok.Data;

@Data
public class MemberVO {

	private int memberno;
	private String id;
	private String name;
	private String password;
	private String hp;
	private String birthday;
	private String regdate;
	private String authority;
}
