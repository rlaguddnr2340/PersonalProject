package kr.co.khw.portfolio.comment;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentBoardRepository extends JpaRepository<CommentBoard, Integer> {

	
	CommentBoard findByTitle(String title);
	CommentBoard findByBoardno(int no);
	Page<CommentBoard> findAllByTitleContainsOrContentContains(String title,String content,Pageable pageable);
	Page<CommentBoard> findAllByTitleContains(String title,Pageable pageable);
	Page<CommentBoard> findAllByContentContains(String content,Pageable pageable);

	
}
