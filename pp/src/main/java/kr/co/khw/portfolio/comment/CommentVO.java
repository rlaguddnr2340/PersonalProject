package kr.co.khw.portfolio.comment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.springframework.stereotype.Controller;

import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Controller
@Data
@NoArgsConstructor
@Table(name = "comment")
public class CommentVO {

	@Id
	private int no;
	private String content;
	private String writer;
	private int boardno;
	private String regdate;
	private String tabletype;
	
	@PrePersist
	public void regdate() {
		this.regdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}
	
	
}
