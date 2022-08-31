package com.kh.campingez.trade.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.trade.model.dto.Trade;

public interface TradeService {

	List<Trade> selectTradeList(Map<String, Integer> param);

	int getTotalContent();
	
	Trade selectTradeByNo(int no);

	int insertTrade(Trade trade);


}
