package com.kh.campingez.chat.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.chat.model.dao.ChatDao;
import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;

import lombok.NonNull;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Autowired
	ChatDao chatDao;

	@Override
	public ChatUser findChatUserByUserId(String userId) {
		return chatDao.findChatUserByUserId(userId);
	}

	@Override
	public void insertChatUsers(List<ChatUser> chatUserList) {
		for(ChatUser chatUser : chatUserList) {
			int result = chatDao.insertChatUser(chatUser);
		}
		
	}

	@Override
	public int insertChatLog(ChatLog chatLog) {
		return chatDao.insertChatLog(chatLog);
	}

	@Override
	public ChatUser findSellerByUserId(String userId) {
		return chatDao.findSellerByUserId(userId);
	}
	
	
}
