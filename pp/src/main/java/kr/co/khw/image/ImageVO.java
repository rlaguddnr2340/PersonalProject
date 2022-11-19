package kr.co.khw.image;

import lombok.Data;

@Data
public class ImageVO {

	private int img_no;
	private int boardno;
	private String filename_org;
	private String filename_real;
	private int order_num;
	private String type;
	private int delete_status;
}
