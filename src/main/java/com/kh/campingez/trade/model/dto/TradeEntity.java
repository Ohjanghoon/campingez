package com.kh.campingez.trade.model.dto;

import java.time.LocalDate;
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
public class TradeEntity {
	
	@NonNull
	private String tradeNo;
	@NonNull
	private String userId;
	@NonNull
	private String categoryId;
	private String tradeTitle;
	private String tradeContent;
	private LocalDateTime tradeDate;
	private int readCount;
	private int price;
	private String tradeSuccess;
	private TradeQuality tradeQuality;
	private int likeCount;
}
