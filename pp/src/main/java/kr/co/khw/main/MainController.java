package kr.co.khw.main;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.khw.portfolio.member.MemberMapper;
import kr.co.khw.portfolio.member.MemberVO;

@Controller
public class MainController {
	
	@Autowired
	MemberMapper mapper;
	
	@RequestMapping("/index.do")
	public String index(Principal pricipal, Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		System.out.println("============="+pricipal);
		if(pricipal ==null) {
			session.setAttribute("loginInfo",pricipal);			
		}else {
			session.setAttribute("loginInfo",mapper.LoginInfo(pricipal.getName()));
		}
		return "index";
	}
	
	@RequestMapping("/main/index.do")
	public String mainIndex() {
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

