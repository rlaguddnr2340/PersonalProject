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

@Controller
public class MemberController {

	@Autowired
	MemberMapper mapper;

	@Autowired
	BCryptPasswordEncoder encoder;

	@GetMapping("portfolio/member/join.do")
	public String join() {
		return "/portfolio/member/join";
	}

	@PostMapping("portfolio/member/joinproc.do")
	public void joinproc(MemberVO vo) {
		vo.setPassword(encoder.encode(vo.getPassword()));
		mapper.Join(vo);
	}
	
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
	@GetMapping("portfolio/member/memberlist.do")
	public String memberlist() {
		return "/portfolio/member/memberlist";
	}
	
}
