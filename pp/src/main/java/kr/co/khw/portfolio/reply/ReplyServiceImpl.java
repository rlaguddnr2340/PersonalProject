package kr.co.khw.portfolio.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.khw.image.ImageVO;
import util.PageInfo;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyMapper mapper;
	
	@Override
	public List<ReplyVO> list(PageInfo vo) {
		return mapper.list(vo);
	}

	@Override
	public int write(ReplyVO vo) {
		return mapper.write(vo);
	}

	@Override
	public int imginsert(ImageVO vo) {
		return mapper.imginsert(vo);
	}

	@Override
	public int totalcount(PageInfo vo) {
		return mapper.totalcount(vo);
	}

	@Override
	public ReplyVO view(ReplyVO vo) {
		return mapper.view(vo);
	}

	@Override
	public int insertgno(ReplyVO vo) {
		return mapper.insertgno(vo);
	}
	
	@Override
	public int updategno(ReplyVO vo) {
		return mapper.updategno(vo);
	}

	@Override
	public int updateono(ReplyVO vo) {
		return mapper.updateono(vo);
	}

	@Override
	public int updatenested(ReplyVO vo) {
		return mapper.updatenested(vo);
	}

	@Override
	public int reviesono(ReplyVO vo) {
		return mapper.reviesono(vo);
	}

	@Override
	public int updateviewcount(ReplyVO vo) {
		return mapper.updateviewcount(vo);
	}

	@Override
	public List<ReplyVO> selectimage(ReplyVO vo) {
		return mapper.selectimage(vo);
	}

	@Override
	public int edit(ReplyVO vo) {
		return mapper.edit(vo);
	}

	@Override
	public int delete(ReplyVO vo) {
		return mapper.delete(vo);
	}

	@Override
	public int deleteimage(ReplyVO vo) {
		return mapper.deleteimage(vo);
	}


}
