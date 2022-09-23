package com.kh.campingez.ws.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.user.model.dto.User;

public class WebSocketHandShakeInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {
		// TODO Auto-generated method stub
		SecurityContext securityContext = SecurityContextHolder.getContext();
 		Authentication authentication = securityContext.getAuthentication();
 		Object principal = authentication.getPrincipal();
 		User user = (User) principal;
 		String userId = user.getUserId();
 		
 		
		/*
		 * Trade trade = new Trade(); trade.getUserId().equals(userId); // seller 이렇게
		 * 간단하면 좋겠당..
		 */				
		if(request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletServerRequest = (ServletServerHttpRequest) request;
			HttpServletRequest servletRequest = servletServerRequest.getServletRequest();
			
			attributes.put("LoginId", userId); // 로그인한 아이디.
		}
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}

	@Override
	public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		// TODO Auto-generated method stub
		super.afterHandshake(request, response, wsHandler, ex);
	}
	
}
