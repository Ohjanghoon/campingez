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
	public ChatUser findChatUserByUserId(String userId, String chatTargetId, String chatTradeNo) {
		return chatDao.findChatUserByUserId(userId, chatTargetId, chatTradeNo);
	}

	@Override
	public void insertChatUsers(List<ChatUser> chatUserList) {
		for(ChatUser chatUser : chatUserList) {
			chatDao.insertChatUser(chatUser);
		}
	}

	@Override
	public int insertChatLog(ChatLog chatLog) {
		return chatDao.insertChatLog(chatLog);
	}

	@Override
	public List<ChatLog> findChatLogByChatroomId(String chatroomId) {
		return chatDao.findChatLogByChatroomId(chatroomId);
	}

	@Override
	public List<ChatUser> findMyChat(String userId) {
		return chatDao.findMyChat(userId);
	}
	
	@Override
	public int deleteChatroom(ChatUser chatUser) {
		return chatDao.deleteChatroom(chatUser);
	}
	
	@Override
	public String findChatTradeNo(String chatroomId) {
		return chatDao.findChatTradeNo(chatroomId);
	}
}
