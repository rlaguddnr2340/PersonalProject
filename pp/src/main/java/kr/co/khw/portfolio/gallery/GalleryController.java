package kr.co.khw.portfolio.gallery;

import java.io.File;
import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.khw.image.ImageVO;
import util.Filename;

@Controller
public class GalleryController {

	@Autowired
	GalleryService service;
	
	// 갤러리 메인페이지
	@GetMapping("portfolio/gallery/index.do")
	public String portfoliogallerymain(Model model, Principal pricipal) {
		GalleryVO vo = new GalleryVO();
		model.addAttribute("list", service.list(vo));
		model.addAttribute("logininfo",pricipal);
		return "/portfolio/gallery/index";
	}
	
	//갤러리 글작성 메인 페이지
	@GetMapping("portfolio/gallery/write.do")
	public String portfolionoticewrite() {
		return "/portfolio/gallery/write";
	}

	// 공지사항 글작성 처리 페이지
	@PostMapping("portfolio/gallery/writeproc.do")
	public String portfolionoticewriteproc(GalleryVO vo, @RequestParam List<MultipartFile> filename, HttpServletRequest req) {	
		System.out.println(filename);
		service.write(vo);
		System.out.println("============="+vo.getNo());
		//Image DB에 저장
		Filename filevo = new Filename();
		if(!filename.get(0).isEmpty()) {
			for (int i =0; i<filename.size();i++) {
				ImageVO imgvo = new ImageVO();
				Map map = filevo.filename(filename.get(i), req);
				imgvo.setBoardno(vo.getNo());
				imgvo.setOrder_num(i);
				imgvo.setType("gallery");
				imgvo.setFilename_org((String)map.get("filename_org"));
				imgvo.setFilename_real((String)map.get("filename_real"));
				service.imginsert(imgvo);
			}
		}
		
		return "redirect:/portfolio/gallery/index.do";
	}
	
	//갤러리 상세내용
	@PostMapping("portfolio/gallery/view.do")
	@ResponseBody
	public List view(GalleryVO vo) {
		List list = service.list(vo);
		return list;
	}
	
	//갤러리 삭제
	@PostMapping("portfolio/gallery/delete.do")
	@ResponseBody
	public int delete(GalleryVO vo) {
		return service.delete(vo);
	}
	
	//갤러리 수정 폼
	@GetMapping("portfolio/gallery/edit.do")
	public String edit(GalleryVO vo, Model model) {
		model.addAttribute("data", service.list(vo));
		return "/portfolio/gallery/edit";
	}
	
	//갤러리 수정 처리
		@PostMapping("portfolio/gallery/editproc.do")
		public String editproc(GalleryVO vo, Model model) {
			model.addAttribute("data", service.list(vo));
			return "/portfolio/gallery/index";
		}

}
