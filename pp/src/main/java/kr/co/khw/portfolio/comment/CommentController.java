package kr.co.khw.portfolio.comment;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import util.Filename;

@Data
@Controller
public class CommentController {

	@Autowired
	CommentBoardRepository boardrep;

	@Autowired
	ImageRepository imagerep;
	
	@Autowired
	CommentRepository commentrep;

	//페이징 
	@GetMapping("portfolio/comment/index.do")
	@Transactional
	public String index(Model model, 
			@RequestParam(value = "pagenum", required = false, defaultValue = "1") int pagenum,
			@RequestParam(value = "stype", required = false, defaultValue = "all") String stype,
			@RequestParam(value = "sword", required = false, defaultValue = "") String sword) {
		Pageable pageable = PageRequest.of(pagenum-1,10,Sort.Direction.DESC, "boardno");
		if(stype.equals("all")) {
			Page<CommentBoard> list = boardrep.findAllByTitleContainsOrContentContains(sword, sword, pageable);
			for(int i=0;i<list.getTotalElements();i++) {
				List<CommentVO> comentlist= commentrep.findAllByBoardnoAndTabletype(list.getContent().get(i).getBoardno(), "commentboard");
				list.getContent().get(i).setCommentcount(comentlist.size());
			}
			model.addAttribute("pageinfo",list );
		}
		else if(stype.equals("title")){
			Page<CommentBoard> list = boardrep.findAllByTitleContainsOrContentContains(sword, sword, pageable);
			for(int i=0;i<list.getTotalElements();i++) {
				List<CommentVO> comentlist= commentrep.findAllByBoardnoAndTabletype(list.getContent().get(i).getBoardno(), "commentboard");
				list.getContent().get(i).setCommentcount(comentlist.size());
			}
			model.addAttribute("pageinfo", boardrep.findAllByTitleContains(sword, pageable));
		}
		else {
			Page<CommentBoard> list = boardrep.findAllByTitleContainsOrContentContains(sword, sword, pageable);
			for(int i=0;i<list.getTotalElements();i++) {
				List<CommentVO> comentlist= commentrep.findAllByBoardnoAndTabletype(list.getContent().get(i).getBoardno(), "commentboard");
				list.getContent().get(i).setCommentcount(comentlist.size());
			}
			model.addAttribute("pageinfo", boardrep.findAllByContentContains(sword,pageable));
		}
		/*
		 * System.out.println("getTotalPages"+boardrep.findAll(pageable).getTotalPages()
		 * ); System.out.println("hasNext"+boardrep.findAll(pageable).hasNext());
		 * System.out.println("getSize"+boardrep.findAll(pageable));
		 * System.out.println("getTotalElements"+boardrep.findAll(pageable).
		 * getTotalElements());
		 * System.out.println("getTotalElements"+boardrep.findAll(pageable).
		 * getTotalElements());
		 * System.out.println("content"+boardrep.findAll(pageable).getContent().get(0).
		 * getTitle());
		 */
		
		return "portfolio/comment_board/index";
	}

	// 댓글 게시판 상세보기
	@GetMapping("portfolio/comment/view.do")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public String view(CommentBoard vo, Model model) {
		System.out.println("vo.getBoardno============="+vo.getBoardno());
		vo = boardrep.findByBoardno(vo.getBoardno());
		vo.setViewcount(vo.getViewcount()+1);
		boardrep.save(vo);
		CommentBoard cv = boardrep.findByBoardno(vo.getBoardno());
		List<Image> ivo = imagerep.findByBoardnoAndType(vo.getBoardno(), "comment");
		//System.out.println("cv.getList().size():"+cv.getImage().size());
		//System.out.println(list);
		cv.setImage(ivo);
		model.addAttribute("data",cv);
		
		return "portfolio/comment_board/view";
	}
	
	//수정 페이지
	@GetMapping("portfolio/comment/edit.do")
	public String edit(CommentBoard vo, Model model) {
		vo = boardrep.findByBoardno(vo.getBoardno());
		CommentBoard cv = boardrep.findByBoardno(vo.getBoardno());
		List<Image> ivo = imagerep.findByBoardnoAndType(vo.getBoardno(), "comment");
		cv.setImage(ivo);
		model.addAttribute("data",cv);
		return "portfolio/comment_board/edit";
	}
	
	//수정 처리
	@PostMapping("portfolio/comment/editproc.do")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	public String editepro(@RequestParam List<MultipartFile> filename, HttpServletRequest req, CommentBoard vo,
			Model model, @RequestParam(value = "filename_chk", required = false, defaultValue = "0") int filename_chk) {

		List<Image> list = new ArrayList<Image>();
			
		if(filename_chk ==1) {
			imagerep.deleteByBoardnoAndType(vo.getBoardno(),"comment");
		}

		// filename을 real,org로 생성및 저장
		if(!filename.get(0).isEmpty()) {
			imagerep.deleteByBoardnoAndType(vo.getBoardno(),"comment");
			List<Image> imagelist = new ArrayList<Image>();
			for(int i =0; i<filename.size(); i++) {
				Filename filerename = new Filename();
				Image imagevo = new Image(); 
				Map map = filerename.filename(filename.get(i), req);
				imagevo.setBoardno(vo.getBoardno());
				imagevo.setFilename_real((String) map.get("filename_real"));
				imagevo.setFilename_org((String) map.get("filename_org"));
				imagevo.setOrder_num(i);
				imagevo.setType("comment");
				imagelist.add(imagevo);
			}
			System.out.println("list.size()"+imagelist.size());
			imagerep.saveAll(imagelist);
		}
		CommentBoard newvo = boardrep.findByBoardno(vo.getBoardno());
		System.out.println("============="+vo.getBoardno());
		newvo.setContent(vo.getContent());
		newvo.setTitle(vo.getTitle());
		newvo.regdate();
		
		
		if(boardrep.save(newvo).getBoardno()>0) {
			model.addAttribute("msg","수정이 완료되었습니다.");
			model.addAttribute("url","/pp/portfolio/comment/index.do");
		}else {
			model.addAttribute("msg","수정의 실패했습니다.");
		}
		return "/common/alert";
	}
	

	// 댓글게시판 글쓰기 페이지
	@GetMapping("portfolio/comment/write.do")
	public String write(Model model) {
		return "portfolio/comment_board/write";
	}

	// 댓글게시판 글쓰기(이미지 저장 완료)
	@PostMapping("portfolio/comment/writeproc.do")
	public String writepro(@RequestParam List<MultipartFile> filename, HttpServletRequest req, CommentBoard vo,
			Model model) {

		List<Image> list = new ArrayList<Image>();
		Image imagevo = new Image();

		vo.setContent(vo.getContent());
		vo.setTitle(vo.getTitle());
		vo.setViewcount(vo.getViewcount());
		vo.setRegdate(vo.getRegdate());
		System.out.println("regdate:"+vo.getRegdate());
		boardrep.save(vo);

		// filename을 real,org로 생성및 저장
		if(!filename.get(0).isEmpty()) {
			for(int i =0; i<filename.size(); i++) {
				Filename filerename = new Filename();
				Map map = filerename.filename(filename.get(i), req);
				imagevo.setBoardno(vo.getBoardno());
				imagevo.setFilename_real((String) map.get("filename_real"));
				imagevo.setFilename_org((String) map.get("filename_org"));
				imagevo.setOrder_num(i);
				imagevo.setType("comment");
				imagerep.save(imagevo);
			}
		}
		return "portfolio/comment_board/index";
	}
	
	//댓글 작성
	@PostMapping("portfolio/comment/replywrite")
	@ResponseBody
	public CommentVO replywrite(CommentVO vo) {
		vo.setTabletype("commentboard");
		return commentrep.save(vo);
	}
	
	//댓글 작성
	@PostMapping("portfolio/comment/replyedit")
	@ResponseBody
	public CommentVO replyedit(CommentVO vo) {
		String newcontent=vo.getContent();
		vo = commentrep.findByNo(vo.getNo());
		vo.setContent(newcontent);
		return commentrep.save(vo);
	}
	
	//댓글 삭제
	@PostMapping("portfolio/comment/replydelete")
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = {Exception.class})
	@ResponseBody
	public int replydelete(CommentVO vo) {
		return commentrep.deleteByNo(vo.getNo());
	}

	
	//댓글 리스트
	@GetMapping("portfolio/comment/commentlist")
	@ResponseBody
	public Page<CommentVO> commentlist(Model model,CommentVO vo,@RequestParam(value = "pagenum", required = false, defaultValue = "1") int pagenum){
		Pageable pageable = PageRequest.of(pagenum-1,5,Sort.Direction.DESC, "regdate");
		Page<CommentVO> newpaging = commentrep.findAllByBoardnoAndTabletype(vo.getBoardno(),"commentboard",pageable);
		System.out.println("TotalPages"+newpaging.getTotalPages());
		return newpaging;
		
		
	}
}
