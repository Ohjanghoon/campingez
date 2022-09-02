package com.kh.campingez.trade.model.dto;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Trade extends TradeEntity {
	private int photoCount;
	private List<TradePhoto> photos = new ArrayList<>();
	
	public Trade(String tradeNo, String userId, String categoryId, String trade_title,
			String trade_content, LocalDateTime trade_date, int readCount, int price, String trade_success,
			TradeQuality tradeQuality, int like_count, int photoCount) {
		super(tradeNo, userId, categoryId, trade_title, trade_content, trade_date, readCount, price, trade_success,
				tradeQuality, like_count);
		this.photoCount = photoCount;
	}
	
	public void add(TradePhoto attach) {
		this.photos.add(attach);
	}
	
}
