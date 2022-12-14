package com.kh.campingez.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLog extends ChatLogEntity {
	
	private String chatTradeNo;

	public ChatLog(long no, String chatroomId, String userId, String chatMsg, long chatTime) {
		super(no, chatroomId, userId, chatMsg, chatTime);
		// TODO Auto-generated constructor stub
	}
	
}
