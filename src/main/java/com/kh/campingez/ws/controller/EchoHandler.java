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

@Component
@Slf4j
public class EchoHandler extends TextWebSocketHandler {

	
	List<WebSocketSession> sessionList = new CopyOnWriteArrayList<>(); // 멀티쓰레딩환경에서 사용하는 리스트
	PayLoad payload = new PayLoad();
	/**
	 * @OnOpen
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		log.debug("[add 현재 세션수 {}] {}", sessionList.size(), session.getId());
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
		
		  Map<String,Object> map = session.getAttributes();
		  String userId = (String)map.get("userId");
		  System.out.println("로그인 한 아이디 : " + userId);
		 
		
		for(WebSocketSession sess : sessionList) {

			sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
		}
		

		
	}
}


