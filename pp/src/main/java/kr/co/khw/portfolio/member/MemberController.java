package kr.co.khw.portfolio.member;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import util.PageInfo;

@Controller
public class MemberController {

	@Autowired
	MemberMapper mapper;

	@Autowired
	BCryptPasswordEncoder encoder;
	
	//회원가입 폼
	@GetMapping("portfolio/member/join.do")
	public String join() {
		return "/portfolio/member/join";
	}

	//회원가입 처리
	@PostMapping("portfolio/member/joinproc.do")
	public String joinproc(MemberVO vo,Model model) {
		vo.setPassword(encoder.encode(vo.getPassword()));
		if(mapper.Join(vo)==1) {
			model.addAttribute("msg","회원가입이 완료되었습니다.");
			model.addAttribute("url","/pp/index.do");
		}else {
			model.addAttribute("msg","회원가입이 실패했습니다.");
		}
		return "/common/alert";
	}
	
	//ID중복체크
	@GetMapping("portfoil/member/idcheck.do")
	@ResponseBody
	public int idcheck(MemberVO vo) {
		return mapper.idcheck(vo.getId());
	}
	
	//로그아웃폼
	@GetMapping("portfolio/member/logout.do")
	public String logout() {
		return "/pp/index";
	}

	@GetMapping("portfolio/member/sessiondel.do")
	@ResponseBody
	public void sessiondel(HttpSession session) {
		System.out.println("=============="+session.getAttribute("LoginFailMessage"));
		session.invalidate();
	}
	
	//로그인페이지
	@GetMapping("portfolio/member/login.do")
	public String login(HttpServletRequest request,Model model) {
		String refer = request.getHeader("Referer");
		
		model.addAttribute("refer",refer);
		System.out.println("================="+refer);
		return "/portfolio/member/login";
		
	}
	
	//에러페이지 처리
	@GetMapping("portfolio/member/error.do")
	public String errorpage(HttpServletRequest request,Model model) {
		String refer = request.getHeader("Referer");
		model.addAttribute("refer",refer);
		System.out.println("================="+refer);
		return "/portfolio/member/errorpage";
	}
	
	//회원관리
	@GetMapping("portfolio/member/index.do")
	public String memberlist(PageInfo pageinfo, Model model, MemberVO vo) {
		
		int totalcount = mapper.totalcount(pageinfo);
		PageInfo newpageinfo = new PageInfo(pageinfo.getPageNum(), pageinfo.getPageRow(), totalcount);
		
		newpageinfo.setStype(pageinfo.getStype());
		newpageinfo.setSword(pageinfo.getSword());
		
		model.addAttribute("list", mapper.list(newpageinfo));
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("data",newpageinfo);
		return "/portfolio/member/index";
	}
	
	
}
