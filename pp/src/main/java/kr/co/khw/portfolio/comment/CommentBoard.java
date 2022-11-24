package kr.co.khw.portfolio.comment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.ColumnDefault;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Entity//jpa 사용한다는 선언
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "comment_board")
public class CommentBoard {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int boardno;
	private String title;
	private String content;
	private String regdate;
	private String writer;

	@Transient
	private int commentcount;
	
	@ColumnDefault("0")
	private int viewcount;

	@OneToMany
	@JoinColumn(name = "boardno" ,updatable = false) 
	private List<Image> image;

	@OneToMany
	@JoinColumn(name = "boardno" ,updatable = false) 
	private List<CommentVO> commentVO ;
	
	@PrePersist
	public void regdate() {
		this.regdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}

}
