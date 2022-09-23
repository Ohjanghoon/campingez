package com.kh.campingez.community.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommunityComment {
	
	private String commentNo;
	private String commentCommNo;
	@NonNull
	private String userId;
	@NonNull
	private String commentContent;
	private LocalDateTime commentDate;
	private int commentLevel;
	private String commentRef;

}
