package kr.co.khw.portfolio.reply;

import lombok.Data;

@Data
public class ReplyVO {

	private int no;
	private String title;
	private String content;
	private String regdate;
	private int viewcount;
	private String writer;
	private String filename_org;
	private String filename_real;
	private int delete_status;
	
	private int gno; //게시물 번호
	private int ono; //순서번호
	private int nested; //들여쓰기
	
	private int comment_count;
	
}
