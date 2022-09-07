package com.kh.campingez.common.security.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import com.kh.campingez.admin.model.service.AdminService;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

// 로그인 성공 시 거쳐감
@Slf4j
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	private AdminService adminService;
	
	public CustomAuthenticationSuccessHandler(AdminService adminService) {
		super();
		this.adminService = adminService;
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String userId = ((User)authentication.getPrincipal()).getUserId();
		
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
