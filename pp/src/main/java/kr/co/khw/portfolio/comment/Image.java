package kr.co.khw.portfolio.comment;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name="image")
@NoArgsConstructor
public class Image {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int img_no;
	private int boardno;
	private String filename_org;
	private String filename_real;
	private int order_num;
	private String type;
	
	@ColumnDefault("0")
	private int delete_status;
	

}
