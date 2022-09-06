package com.kh.campingez.trade.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TradeLike {
	
	private String likeTradeNo;
	private String likeUserId;
	private int likeCheck;
	
}
