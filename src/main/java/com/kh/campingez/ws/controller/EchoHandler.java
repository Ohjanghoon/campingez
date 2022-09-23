package com.kh.campingez.ws.controller;

import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.kh.campingez.ws.payload.PayLoad;

import lombok.extern.slf4j.Slf4j;
import org.json.*;

@Component
@Slf4j
public class EchoHandler extends TextWebSocketHandler {

	PayLoad payload = new PayLoad();
	List<WebSocketSession> sessionList = new CopyOnWriteArrayList<>(); // 멀티쓰레딩환경에서 사용하는 리스트
	/**
	 * @OnOpen
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		Map<String,Object> map = session.getAttributes();
		String userId = (String)map.get("LoginId");
		
		sessionList.add(session);
		log.debug("[add 현재 세션수 {}] {}", sessionList.size(), session.getId() + " : " + userId);
	}
	
	/**
	 * @OnClose
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		log.debug("[remove 현재 세션수 {}] {}", sessionList.size(), session.getId());
	}
	
	/**
	 * @OnMessage
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		log.debug("[message] {} : {}", session.getId(), message.getPayload());
		
//		SecurityContext securityContext = SecurityContextHolder.getContext();
// 		Authentication authentication = securityContext.getAuthentication();
// 		Object principal = authentication.getPrincipal();
// 		User user = (User) principal;
// 		String userId = user.getUserId();
 		System.out.println("!!!!!!!!!!!!!!!!!param : " + message.getPayload());
		

 		String msg = message.getPayload();
 		if(msg != null) {
 			String[] strs = msg.split(":",2);
 			for(String str : strs) {
 				System.out.println("str===="+str);
 			}
 		
		
			JSONObject object = new JSONObject(strs[1]); 
			String tradeId = object.getString("tradeId");
			System.out.println("판매자 아이디 : " + tradeId);
			
 		}
 		
		Map<String,Object> map = session.getAttributes();
 		String userId = (String)map.get("LoginId");
 		System.out.println("로그인 한 아이디 : " + userId);
 		
 		
		
		
		for(WebSocketSession sess : sessionList) {

			sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
		}
		

		
	}
	
	
}


