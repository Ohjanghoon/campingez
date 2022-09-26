package com.kh.campingez.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

import com.kh.campingez.alarm.model.service.AlarmService;
import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;
import com.kh.campingez.chat.model.service.ChatService;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.service.TradeService;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController {
	
	@Autowired
	ChatService chatService;
	
	@Autowired
	TradeService tradeService;
	
	@Autowired
	AlarmService alarmService;
	
	@PostMapping("/chat.do")
	public ResponseEntity<?> chat(
			@RequestParam("chatTargetId") String chatTargetId, 
			@RequestParam(name = "chatTradeNo", required = false) String chatTradeNo,
			Authentication auth, Model model) {
		
		log.debug("chatTargetId = {}, chatTradeNo = {}", chatTargetId, chatTradeNo);
		// 1. 채팅방 유무 조회
		User user = (User) auth.getPrincipal();
		String userId = user.getUserId();
		log.debug("userId = {}", userId);
		log.debug("chatTargetId = {}", chatTargetId);
		
		ChatUser chatUser = chatService.findChatUserByUserId(userId, chatTargetId, chatTradeNo);
		log.debug("chatUser = {}", chatUser);
		
		String chatroomId = null;
//		List<ChatLog> chatLogs = new ArrayList<>();
		
		if(chatUser == null) {
			// 처음
			chatroomId = generateChatroomId();
			log.debug("chatroomId = {}", chatroomId);
			// chatuser insert 2행
			List<ChatUser> chatUserList = new ArrayList<>();
			chatUser = new ChatUser(chatroomId, userId);
			chatUser.setChatTradeNo(chatTradeNo);
			
			ChatUser chatTargetUser = new ChatUser(chatroomId, chatTargetId);
			chatTargetUser.setChatTradeNo(chatTradeNo);

			chatUserList.add(chatUser);
			chatUserList.add(chatTargetUser);
			//채팅방 생성
			chatService.insertChatUsers(chatUserList);
			//채팅방 생성 완료 시 알림
			alarmService.insertChatroomAlarm(userId, chatTargetId);
		}
		else {
			// 재입장
			chatroomId = chatUser.getChatroomId();
//			chatLogs = chatService.findChatLogByChatroomId(chatroomId);
//			log.debug("chatLogs = {}", chatLogs);
			
		}
		
//		model.addAttribute("chatroomId", chatroomId);
//		model.addAttribute("chatLogs", chatLogs);	//판매자ID
		
//		return null;
		Map<String, Object> map = new HashMap<>();
		map.put("chatroomId", chatroomId);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE).body(map);
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
		
		String chatTradeNo = chatService.findChatTradeNo(chatroomId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("chatLogs", chatLogs);
		map.put("chatTradeNo", chatTradeNo);
		
		return ResponseEntity.status(HttpStatus.OK)
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(map);
	}
	
	@PostMapping("/chatroomDelete.do")
	public ResponseEntity<?> deleteChatroom(ChatUser chatUser){
		
		log.debug("chatUser = {}", chatUser);
		
		int result = chatService.deleteChatroom(chatUser);
		
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/goTrade.do")
	public ResponseEntity<?> selectTradeByNo(@RequestParam String tradeNo){
		
		Trade trade = tradeService.selectTradeByNo(tradeNo);
		
		return ResponseEntity.status(HttpStatus.OK)
					.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
				.body(trade);
	}
}
