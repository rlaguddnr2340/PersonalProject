package kr.co.khw.portfolio.reply;

import java.util.List;

import kr.co.khw.image.ImageVO;
import util.PageInfo;

public interface ReplyService {

	public List<ReplyVO> list(PageInfo vo);
	public int totalcount(PageInfo vo);
	public int write(ReplyVO vo);
	public int insertgno(ReplyVO vo);
	public int imginsert(ImageVO vo);
	public ReplyVO view(ReplyVO vo);
	List<ReplyVO> selectimage(ReplyVO vo);
	public int updateviewcount(ReplyVO vo);
	public int edit(ReplyVO vo);
	
	public int delete(ReplyVO vo);
	public int deleteimage(ReplyVO vo);
	
	
	
	//답변처리
	public int updategno(ReplyVO vo);
	public int updateono(ReplyVO vo);
	public int reviesono(ReplyVO vo);
	public int updatenested(ReplyVO vo);
	
}
