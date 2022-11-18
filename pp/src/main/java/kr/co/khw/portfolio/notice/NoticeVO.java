package kr.co.khw.portfolio.notice;

import lombok.Data;

@Data
public class NoticeVO {

	private int no;
	private String title;
	private String content;
	private String regdate;
	private int viewcount;
	private int memberno;
	private String filename_org;
	private String filename_real;
}
