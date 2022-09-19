package com.kh.campingez.community.model.dto;

import com.kh.campingez.trade.model.dto.TradeLike;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommunityLike {
	
	private String likeCommNo;
	private String likeUserId;
	private int likeCheck;
}
