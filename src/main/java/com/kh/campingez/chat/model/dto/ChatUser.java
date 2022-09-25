package com.kh.campingez.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class ChatUser extends ChatUserEntity{
	
	private ChatLog chatLog;

	
	public ChatUser(@NonNull String chatroomId, @NonNull String userId, long lastCheck, LocalDateTime createdAt,
			LocalDateTime deletedAt) {
		super(chatroomId, userId, lastCheck, createdAt, deletedAt);
		// TODO Auto-generated constructor stub
	}


	public ChatUser(@NonNull String chatroomId, @NonNull String userId) {
		super(chatroomId, userId);
		// TODO Auto-generated constructor stub
	}

	
}
