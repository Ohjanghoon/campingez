package com.kh.campingez.trade.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
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
	Trade selectTradeByNo(String no);
	
	@Select("select * from trade_photo where trade_no = #{tdNo}")
	List<TradePhoto> selectPhotoListBytradeNo(String no);
	
	@Insert("insert into trade values('T' || seq_trade_trade_no.nextval, #{userId}, #{categoryId}, #{tradeTitle}, " 
			+ "#{tradeContent}, default, default, ${tradeSuccess}, '대기', default)")
	@SelectKey(statement = "select seq_trade_trade_no.currval from dual",before = false, resultType = String.class, keyProperty = "tradeNo")
	int insertTrade(Trade trade);
	
	@Insert("insert into tradePhoto vlaues(seq_trade_photo_n o.nextval, #{tdNo}, #{originalFilename}, #{renamedFilename})")
	int insertPhoto(TradePhoto photo);
	
	



	

}
