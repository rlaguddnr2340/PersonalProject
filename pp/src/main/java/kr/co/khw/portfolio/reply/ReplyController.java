package kr.co.khw.portfolio.reply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.khw.image.ImageVO;
import lombok.Data;
import util.Filename;
import util.PageInfo;

@Data
@Controller
public class ReplyController {

	@Autowired
	ReplyService service;

	// 글목록
	@GetMapping("portfolio/reply/index.do")
	public String index(Model model, PageInfo pageinfo) {

		int totalcount = service.totalcount(pageinfo);
		PageInfo newpageinfo = new PageInfo(pageinfo.getPageNum(), pageinfo.getPageRow(), totalcount);

		model.addAttribute("list", service.list(newpageinfo));
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("data",newpageinfo);
		return "/portfolio/reply/index";
	}

	//글작성 폼
	@GetMapping("portfolio/reply/write.do")
	public String write() {
		return "/portfolio/reply/write";
	}

	//글작성 처리
	@PostMapping("portfolio/reply/writeproc.do")
	public String writeproc(Model model,@RequestParam List<MultipartFile> filename, ReplyVO vo, HttpServletRequest req) {
		
		// Image DB에 저장
		Filename filevo = new Filename();
		if (!filename.get(0).isEmpty()) {
			for (int i = 0; i < filename.size(); i++) {
				ImageVO imgvo = new ImageVO();
				Map map = filevo.filename(filename.get(i), req);
				imgvo.setBoardno(vo.getNo());
				imgvo.setOrder_num(i);
				imgvo.setType("reply");
				imgvo.setFilename_org((String) map.get("filename_org"));
				imgvo.setFilename_real((String) map.get("filename_real"));
				service.imginsert(imgvo);
			}
		}
		int result =service.write(vo);
		service.insertgno(vo);
		if(result==1) {
			model.addAttribute("msg","글작성이 완료되었습니다.");
			model.addAttribute("url","/pp/portfolio/reply/index.do");
		}else {
			model.addAttribute("msg","글작성이 실패했습니다.");
		}
		return "/common/alert";
	}

	//글 상세보기
	@GetMapping("portfolio/reply/view.do")
	public String view(ReplyVO vo, Model model, PageInfo pageinfo) {
		vo= service.view(vo);
		service.updateviewcount(vo);
		model.addAttribute("data", service.view(vo));
		model.addAttribute("image",service.selectimage(vo));
		model.addAttribute("pageinfo", pageinfo);
		
		return "/portfolio/reply/view";
	}

	//답변 작성
	@GetMapping("portfolio/reply/replywrite.do")
	public String replywrite(ReplyVO no, Model model) {
		model.addAttribute("data",service.view(no));
		return "/portfolio/reply/replywrite";
	}

	//답변 작성 처리
	@PostMapping("portfolio/reply/replywriteproc.do")
	public String replywriteproc(@RequestParam List<MultipartFile> filename, ReplyVO vo, HttpServletRequest req, Model model) {
		int pregno = vo.getGno();//이전의글번호라고 생각하면된다
		int result=service.write(vo);
		vo.setGno(pregno);
		
		service.updategno(vo);
		service.reviesono(vo);
		service.updateono(vo);
		service.updatenested(vo);
		
		// Image DB에 저장
		Filename filevo = new Filename();
		if (!filename.get(0).isEmpty()) {
			for (int i = 0; i < filename.size(); i++) {
				ImageVO imgvo = new ImageVO();
				Map map = filevo.filename(filename.get(i), req);
				imgvo.setBoardno(vo.getNo());
				imgvo.setOrder_num(i);
				imgvo.setType("reply");
				imgvo.setFilename_org((String) map.get("filename_org"));
				imgvo.setFilename_real((String) map.get("filename_real"));
				service.imginsert(imgvo);
			}
		}
		
		if(result==1) {
			model.addAttribute("msg","글작성이 완료되었습니다.");
			model.addAttribute("url","/pp/portfolio/reply/index.do");
		}else {
			model.addAttribute("msg","글작성이 실패했습니다.");
		}
		return "/common/alert";
	}
	
	//글 수정폼
	@GetMapping("portfolio/reply/edit.do")
	public String edit(ReplyVO vo, Model model, PageInfo pageinfo) {
		model.addAttribute("data", service.view(vo));
		model.addAttribute("image",service.selectimage(vo));
		model.addAttribute("pageinfo", pageinfo);
		return "/portfolio/reply/edit";
	}
	
	//글 수정처리
	@PostMapping("portfolio/reply/editproc.do")
	public String editproc(@RequestParam List<MultipartFile> filename, ReplyVO vo, HttpServletRequest req, 
			Model model, @RequestParam(value = "filename_chk", required = false, defaultValue = "0") int filename_chk) {
		
		if(filename_chk ==1) {
			service.deleteimage(vo);
		}
		
		Filename filevo = new Filename();
		if (!filename.get(0).isEmpty()) {
			service.deleteimage(vo);
			for (int i = 0; i < filename.size(); i++) {
				ImageVO imgvo = new ImageVO();
				Map map = filevo.filename(filename.get(i), req);
				imgvo.setBoardno(vo.getNo());
				imgvo.setType("reply");
				imgvo.setOrder_num(i);
				imgvo.setFilename_org((String) map.get("filename_org"));
				imgvo.setFilename_real((String) map.get("filename_real"));
				service.imginsert(imgvo);
			}
		}
		if(service.edit(vo)==1) {
			model.addAttribute("msg","수정이 완료되었습니다.");
			model.addAttribute("url","/pp/portfolio/reply/index.do");
		}else {
			model.addAttribute("msg","수정의 실패했습니다.");
		}
		return "/common/alert";
	}
	//글삭제
	@GetMapping("portfolio/reply/delete.do")
	public String delete(ReplyVO vo, Model model) {
		service.deleteimage(vo);
		int result=service.delete(vo);
		if( result ==1 ) {
			model.addAttribute("msg","삭제가 완료되었습니다.");
			model.addAttribute("url","/pp/portfolio/reply/index.do");
		}else {
			model.addAttribute("msg","삭제 실패했습니다.");
		}
		return "/common/alert";
	}

}
