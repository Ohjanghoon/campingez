package com.kh.campingez.common.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.user.controller.UserController;
import com.kh.campingez.user.model.dto.User;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

// 로그인 성공 시 거쳐감
@Slf4j
@Data
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	@Autowired
	private AdminService adminService;
	
	private RequestCache requestCache = new HttpSessionRequestCache();
	
	private String targetUrlParameter;
	
	private String defaultUrl;
	
	private boolean useReferer;
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	public CustomAuthenticationSuccessHandler() {
		defaultUrl = "/";
		useReferer = true;
	}
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String userId = ((User)authentication.getPrincipal()).getUserId();
		log.debug("userId@custom = {}", userId);
		
		clearAuthenticationAttributes(request);
		
		int intRedirectStrategy = decideRedirectStrategy(request, response);
		
		log.debug("intRedirectStrategy = {}", intRedirectStrategy);
		
		switch(intRedirectStrategy) {
		case 1:
			log.debug("1");
			useTargetUrl(request, response);
			break;
		case 2:
			log.debug("2");
			useSessionUrl(request, response);
			break;
		case 3:
			log.debug("3");
			useRefererUrl(request, response);
			break;
		default:
			log.debug("default");
			useDefaultUrl(request, response);
		}
		
		
		if(userId != null) {
			for(GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
				if("ROLE_ADMIN".equals(grantedAuthority.toString())) {
					return;
				} else {
					log.debug("어드민서비스로감");
					adminService.insertDailyVisit(userId);
				}
			}
		} else {
			return;
		}
	}
	
	private void useDefaultUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		redirectStrategy.sendRedirect(request, response, defaultUrl);
	}

	private void useRefererUrl(HttpServletRequest request, HttpServletResponse response)throws IOException {
		String targetUrl = request.getHeader("REFERER");
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useSessionUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String targetUrl = savedRequest.getRedirectUrl();
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private void useTargetUrl(HttpServletRequest request, HttpServletResponse response) throws IOException {
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if(savedRequest != null) {
			requestCache.removeRequest(request, response);
		}
		String targetUrl = request.getParameter(targetUrlParameter);
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}

	private int decideRedirectStrategy(HttpServletRequest request, HttpServletResponse response) {
		int result = 0;
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		
		if(!"".equals(targetUrlParameter)) {
			String targetUrl = request.getParameter(targetUrlParameter);
			if(StringUtils.hasText(targetUrl)) {
				log.debug("{}", 1);
				result = 1;
			}
			else {
				if(savedRequest != null) {
					log.debug("{}", 2);
					result = 2;
				}
				else {
					String refereUrl = request.getHeader("Referer");
					if(useReferer && StringUtils.hasText(refereUrl)) {
						log.debug("{}", 3);
						result = 3;
					}
					else {
						log.debug("{}", 0);
						log.debug("Referer = {}", request.getHeader("Referer"));
						result = 0;
					}
				}
			}
			return result;
		}
		if(savedRequest != null) {
			result = 2;
			return result;
		}
		
		String refereUrl = request.getHeader("REFERER");
		if(useReferer && StringUtils.hasText(refereUrl)) {
			result = 3;
		}
		else {
			result = 0;
		}
		
		return result;
	}

	private void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
}