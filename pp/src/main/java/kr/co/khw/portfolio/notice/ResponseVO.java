package kr.co.khw.portfolio.notice;

import java.util.List;

import lombok.Data;

@Data
public class ResponseVO {

	private List<NoticeVO> list;
	private int totalCount;
	private int totalPage;
	private int pageNum;
	private int pageRow;
	private int startPage;
	private int endPage;
	private String stype;
	private String sword;
	private Boolean prev;
	private Boolean next;
	
	
	public ResponseVO() {
		this.pageNum =1;
	}
}
