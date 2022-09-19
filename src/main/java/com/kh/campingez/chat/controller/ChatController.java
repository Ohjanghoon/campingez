package com.kh.campingez.chat.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


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
	
	@GetMapping("/chat")
	public void chat(Authentication auth, Model model, Trade trade) {
		// 0. 중고거래 번호 확인
		
		
		// 1. 채팅방 유무 조회
		User user = (User) auth.getPrincipal();
		ChatUser chatUser = chatService.findChatUserByUserId(user.getUserId());
		ChatUser seller = chatService.findSellerByUserId(trade.getUserId());
		log.debug("chatUser = {}", chatUser);
		
		String chatroomId = null;
		if(chatUser == null && seller == null) {
			// 처음
			chatroomId = generateChatroomId();
			log.debug("chatroomId = {}", chatroomId);
			// chatuser insert 2행
			List<ChatUser> chatUserList = Arrays.asList(
					new ChatUser(chatroomId, user.getUserId(), trade.getTradeNo()),
					new ChatUser(chatroomId, "seller", trade.getTradeNo()));
			chatService.insertChatUsers(chatUserList);
		}
		else {
			// 재입장
			chatroomId = chatUser.getChatroomId();
		}
		
		model.addAttribute("chatroomId", chatroomId);
		
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

}
