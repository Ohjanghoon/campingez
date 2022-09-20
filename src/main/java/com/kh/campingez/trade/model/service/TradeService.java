package com.kh.campingez.trade.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradeLike;
import com.kh.campingez.trade.model.dto.TradePhoto;

public interface TradeService {

	List<Trade> selectTradeList(Map<String, Integer> param);

	int getTotalContent();
	
	Trade selectTradeByNo(String no);

	int insertTrade(Trade trade);

	int insertPhoto(TradePhoto photo);

	TradePhoto selectOnePhoto(int photoNo);

	int deletePhoto(int photoNo);

	int updateTrade(Trade trade);

	int deleteTrade(String no);

	int updateReadCount(String no);

	int getTradeLike(TradeLike tl);

	void deleteTradeLike(TradeLike tl);

	void insertTradeLike(TradeLike tl);

	List<Trade> selectTradeListKind(Map<String, Integer> param, String categoryId);

	int getTotalContentKind(String categoryId);

	int updateSuccess(String no);

	List<Category> getReportCategory();

	String getUserReportTrade(Map<String, Object> param);

}
