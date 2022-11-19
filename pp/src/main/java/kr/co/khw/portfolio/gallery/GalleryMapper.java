package kr.co.khw.portfolio.gallery;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.co.khw.image.ImageVO;

@Mapper
public interface GalleryMapper {

	public int write(GalleryVO vo);
	public List<GalleryVO> list(GalleryVO vo);
	public int imginsert(ImageVO vo);
	public int delete(GalleryVO vo);
}
