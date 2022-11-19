package kr.co.khw.portfolio.gallery;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.khw.image.ImageVO;

@Service
public class GalleryServiceImpl implements GalleryService {

	@Autowired
	GalleryMapper mapper;
	
	@Override
	public int write(GalleryVO vo) {
		return mapper.write(vo);
	}

	@Override
	public List<GalleryVO> list(GalleryVO vo) {
		return mapper.list(vo);
	}

	@Override
	public int imginsert(ImageVO vo) {
		return mapper.imginsert(vo);
	}

	@Override
	public int delete(GalleryVO vo) {
		return mapper.delete(vo);
	}
	
	
}
