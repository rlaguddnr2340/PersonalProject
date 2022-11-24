package kr.co.khw.portfolio.comment;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CommentRepository extends JpaRepository<CommentVO, Integer> {

	Page<CommentVO> findAllByBoardnoAndTabletype(int boardno,String tabletype,Pageable pageable);

	List<CommentVO> findAllByBoardnoAndTabletype(int boardno, String string);

	CommentVO findByNo(int no);

	int deleteByNo(int no);

	
}
