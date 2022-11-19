package kr.co.khw.portfolio.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class CustomAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	UserDetailsService userDetail;
	
	@Autowired
	BCryptPasswordEncoder encoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		UsernamePasswordAuthenticationToken token = (UsernamePasswordAuthenticationToken) authentication;
		
		String username = token.getName();
        String password = (String)token.getCredentials();
        UserDetailsImpl user = (UserDetailsImpl) userDetail.loadUserByUsername(username);
        
        if(!encoder.matches(password, user.getPassword())) {
            throw new BadCredentialsException(username);
        }
 
        if(!user.isEnabled()) {
            throw new BadCredentialsException(username);
        }
        
        return new UsernamePasswordAuthenticationToken(user, password, user.getAuthorities());
        
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
