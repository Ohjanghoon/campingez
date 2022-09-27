package com.kh.campingez.ws.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;

import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.service.ChatService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class StompController {

	
	@Autowired
	ChatService chatService;
	
	/**
	 * @MessageMapping 작성시 주의사항
	 *  - url은 prefix를 제외하고 작성해야 한다. ex) /app/a => /a
	 * 
	 * @SendTo
	 *  - prefix부터 모두 작성
	 *  - simpleBroker에게 전달
	 */
	@MessageMapping("/a")
	@SendTo("/app/a")
	public String simpleMessage(String message) {
		log.debug("message = {}", message);
		return message;
	}
	
	@MessageMapping("/chat/{chatroomId}")
	@SendTo({"/app/chat/{chatroomId}", "/app/{userId}/myChatList"})
	public ChatLog chatlog(@RequestBody ChatLog chatLog) {
		log.debug("chatLog = {}", chatLog);
		
		int result = chatService.insertChatLog(chatLog);
		return chatLog;
	}
	
}
