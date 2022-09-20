package com.kh.campingez.common.security.handler;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.user.model.dto.User;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

// 로그인 성공 시 거쳐감
@Slf4j
@Data
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private AdminService adminService;
	
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	 
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String userId = ((User)authentication.getPrincipal()).getUserId();
		log.debug("userId@custom = {}", userId);
		
		/**
         * (우선순위3) 인덱스페이지 
         */
		String targetUrl = "/";

    	HttpSession session = request.getSession();
        Enumeration<?> names = session.getAttributeNames();
        while(names.hasMoreElements()) {
        	String name = (String) names.nextElement();
        	log.debug("{} = {}", name, session.getAttribute(name));
        	if(name.contains("loginRedirect")) {
        		targetUrl = (String)session.getAttribute(name);
        	}
        }
        
        /**
         * (우선순위2) 로그인폼페이지 요청전 페이지 
         */
        String next = (String) session.getAttribute("next");
        if(next != null && !next.isEmpty()) {
        	targetUrl = next;
        	session.removeAttribute("next");
        }

        /**
         * (우선순위1) 인증하지않고 접근하려던 페이지 
         */
        SavedRequest savedRequest = (SavedRequest) session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
        log.debug("savedRequest = {}", savedRequest);
        if(savedRequest != null) {
        	targetUrl = savedRequest.getRedirectUrl();
        }
        
        log.debug("targetUrl = {}", targetUrl);
        
        redirectStrategy.sendRedirect(request, response, targetUrl);
    
    
		
		if(userId != null) {
			for(GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
				if("ROLE_ADMIN".equals(grantedAuthority.toString())) {
					return;
				} else {
					adminService.insertDailyVisit(userId);
				}
			}
		} else {
			return;
		}
	}

}