package com.kh.campingez.trade.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradePhoto;

@Mapper
public interface TradeDao {
	
	@Select("select * from trade")
	List<Trade> selectTradeList(RowBounds rowBounds);
	
	@Select("select count(*) from trade")
	int getTotalContent();
	
	@Select("select * from trade where trade_no = #{tradeNo}")
	Trade selectTradeByNo(int no);
	
	@Insert("insert into trade values(seq_trade_trade_no.nextval, #{userId}, #{categoryId}, #{tradeTitle}, "
			+ "#{tradeContent}, default, default, ${tradeSuccess}, #{tradeQuality}, default)")
	int insertTrade(Trade trade);
	
	@Insert("insert into tradePhoto vlaues()")
	int insertPhoto(TradePhoto photo);
	



	

}
