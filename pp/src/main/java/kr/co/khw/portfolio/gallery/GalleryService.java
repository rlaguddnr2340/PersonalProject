package kr.co.khw.portfolio.gallery;

import java.util.List;

import kr.co.khw.image.ImageVO;

public interface GalleryService {
	//글작성 
	public int write(GalleryVO vo);
	
	//목록가져오기
	public List<GalleryVO> list(GalleryVO vo);
	
	//이미지 저장
	public int imginsert(ImageVO vo);
	
	//갤러리 삭제
	public int delete(GalleryVO vo);
}
