package kr.co.khw.portfolio.comment;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ImageRepository extends JpaRepository<Image, Integer> {

	List<Image> findByBoardnoAndType(int boardno,String type);

	void deleteByBoardnoAndType(int boardno, String string);


	



}
