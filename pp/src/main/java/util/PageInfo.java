package util;

import lombok.Data;

@Data
public class PageInfo {
	private int totalCount;
	private int pageNum;
	private int pageRow;
	
	private String stype;
	private String sword;
	
	private int totalPage;
	private int startIdx;
	private int endPage;
	private int startPage;
	private boolean prev;
	private boolean next;
	
	
	public PageInfo() {
		this.pageNum = 1;
		this.pageRow = 10;
	}
	
	public PageInfo(int pagenum) {
		
		this.pageNum = pagenum;
		this.pageRow =10;
	}
	
	public PageInfo(int pageNum, int pageRow, int totalCount) {
		this.totalCount = totalCount; 
		this.pageNum = pageNum;
		this.totalPage = totalCount / pageRow;
		this.pageRow = pageRow;
		
		if (totalCount % pageRow > 0)
			this.totalPage++;
		
		this.startIdx = (pageNum - 1) * pageRow; // (현재 페이지 -1)*한 페이지당 행(게시물)의 개수

		// 페이징처리
		this.endPage = (int)(Math.ceil(pageNum / 10.0)*10);
		this.startPage = endPage - 9;

		if (this.endPage > this.totalPage)
			this.endPage = this.totalPage;

		this.prev = this.startPage > 1;
		this.next = this.endPage < this.totalPage;
		
	}
}
