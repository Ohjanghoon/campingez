package com.kh.campingez.chat.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;
import com.kh.campingez.chat.model.service.ChatService;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	
	@GetMapping("/chat.do")
	public String chat(@RequestParam("chatTargetId") String chatTargetId, Authentication auth, Model model) {

		// 1. 채팅방 유무 조회
		User user = (User) auth.getPrincipal();
		String userId = user.getUserId();
		log.debug("userId = {}", userId);
		log.debug("chatTargetId = {}", chatTargetId);
		
		// null 이 나오는 상황!! dao 쿼리문제 같은데 조금 헷갈려요 ㅠㅠ
		ChatUser chatUser = chatService.findChatUserByUserId(userId, chatTargetId);
		log.debug("chatUser = {}", chatUser);
		
		
		String chatroomId = null;
		List<ChatLog> chatLogs = new ArrayList<>();
		
		if(chatUser == null) {
			// 처음
			chatroomId = generateChatroomId();
			log.debug("chatroomId = {}", chatroomId);
			// chatuser insert 2행
			List<ChatUser> chatUserList = Arrays.asList(
					new ChatUser(chatroomId, userId),
					new ChatUser(chatroomId, chatTargetId));
			chatService.insertChatUsers(chatUserList);
		}
		else {
			// 재입장
			chatroomId = chatUser.getChatroomId();
			chatLogs = chatService.findChatLogByChatroomId(chatroomId);
			log.debug("chatLogs = {}", chatLogs);
		}
		
		model.addAttribute("chatroomId", chatroomId);
		model.addAttribute("chatLogs", chatLogs);	//판매자ID
		
		return "redirect:/chat/myChatList.do";
	}

	private String generateChatroomId() {
		Random random = new Random();
		StringBuilder sb = new StringBuilder();
		final int len = 8;
		for(int i =0; i < len; i++) {
		if(random.nextBoolean()) {
			//영문
			if(random.nextBoolean()) {
				// 대문자
				sb.append((char) (random.nextInt(26) + 'A'));
			}
			else {
				// 소문자
				sb.append((char) (random.nextInt(26) + 'a'));
			}
		}
		else {
			
			sb.append(random.nextInt(10));
			}
		}
		return sb.toString();
	}

	@GetMapping("/myChatList.do")
	public void chatList(Authentication auth, Model model) {
		User user = (User) auth.getPrincipal();
		String userId = user.getUserId();
		
		List<ChatUser> chatUsers = chatService.findMyChat(userId);
		
		model.addAttribute("chatUsers", chatUsers);
		
	}
	
	@GetMapping("/enterChatroom.do")
	public ResponseEntity<?> enterChatroom (@RequestParam String chatroomId) {
		List<ChatLog> chatLogs = new ArrayList<>();
		log.debug("chatroomId = {}",chatroomId);
		chatLogs = chatService.findChatLogByChatroomId(chatroomId);
		log.debug("chatLogs = {}", chatLogs);
		
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(chatLogs);
	}
	
	@PostMapping("/chatroomDelete.do")
	public ResponseEntity<?> deleteChatroom(ChatUser chatUser){
		
		log.debug("chatUser = {}", chatUser);
		
		int result = chatService.deleteChatroom(chatUser);
		
		return ResponseEntity.ok(result);
	}
}
