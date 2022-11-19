package kr.co.khw.portfolio.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service("loginService")
public class LoginService implements UserDetailsService {

	@Autowired
	MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberVO vo = mapper.LoginInfo(username);
		if(vo == null) {
			return null;
		}else {
			return new UserDetailsImpl(vo);
		}
	}

}
