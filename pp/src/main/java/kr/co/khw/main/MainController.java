package kr.co.khw.main;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.khw.portfolio.comment.CommentBoardRepository;
import kr.co.khw.portfolio.gallery.GalleryMapper;
import kr.co.khw.portfolio.member.MemberMapper;
import kr.co.khw.portfolio.member.MemberVO;
import kr.co.khw.portfolio.reply.ReplyMapper;

@Controller
public class MainController {
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	ReplyMapper replymapper;
	
	@Autowired
	GalleryMapper gallerymapper;
	
	@Autowired
	CommentBoardRepository commentrep;
	
	@RequestMapping("/index.do")
	public String index(Principal pricipal, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(pricipal ==null) {
			session.setAttribute("loginInfo",pricipal);			
		}else {
			session.setAttribute("loginInfo",mapper.LoginInfo(pricipal.getName()));
		}
		return "index";
	}
	
	@RequestMapping("/main/index.do")
	public String mainIndex(Model model) {
		
		Pageable pageable = PageRequest.of(0,5,Sort.Direction.DESC, "regdate");
		model.addAttribute("qnalist", replymapper.qnalist());
		model.addAttribute("booklist",gallerymapper.gallerylist() );
		model.addAttribute("freelist", commentrep.findAll(pageable));
		model.addAttribute("memberlist", mapper.memberlist());
		
		
		
		return "main/index";
	}
	
	@RequestMapping("/myinfo/index.do")
	public String myinfoIndex() {
		return "myinfo/index";
	}
	@RequestMapping("/myinfo/myinfo.do")
	public String myinfo() {
		return "myinfo/myinfo";
	}
}

