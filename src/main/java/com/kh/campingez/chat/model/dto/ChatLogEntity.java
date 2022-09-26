package com.kh.campingez.chat.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatLogEntity {
		
	
		private long no;
		private String chatroomId;
		private String userId;
		private String chatMsg;
		private long chatTime;
		

}
