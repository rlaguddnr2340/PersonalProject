package kr.co.khw.portfolio.gallery;

import lombok.Data;

@Data
public class GalleryVO {

	private int no;
	private String title;
	private String content;
	private String regdate;
	private String filename_org;
	private String filename_real;
	private int delete_status;
	private int order_num;
	private String type;
	private int memberno;
}
