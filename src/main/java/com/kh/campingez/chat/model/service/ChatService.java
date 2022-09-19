package com.kh.campingez.chat.model.service;

import java.util.List;

import com.kh.campingez.chat.model.dto.ChatLog;
import com.kh.campingez.chat.model.dto.ChatUser;

import lombok.NonNull;

public interface ChatService {

	ChatUser findChatUserByUserId(String userId);

	void insertChatUsers(List<ChatUser> chatUserList);

	int insertChatLog(ChatLog chatLog);

	ChatUser findSellerByUserId(String userId);

}
