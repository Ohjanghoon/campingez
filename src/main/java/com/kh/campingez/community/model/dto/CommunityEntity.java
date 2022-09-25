package com.kh.campingez.community.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommunityEntity {
		
		private String commNo;
		private String userId;
		private String categoryId;
		private String commTitle;
		private String commContent;
		private LocalDateTime commDate;
		private int readCount;
		private int reportCount;
		private isDelete isDelete;
		private int likeCount;
}