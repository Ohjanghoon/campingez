package com.kh.campingez.trade.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradeLike;
import com.kh.campingez.trade.model.dto.TradePhoto;

@Mapper
public interface TradeDao {
	
	@Select("select * from trade order by trade_no desc")
	List<Trade> selectTradeList(RowBounds rowBounds);
	
	@Select("select count(*) from trade")
	int getTotalContent();
	
	@Select("select * from trade where trade_no = #{tradeNo}")
	Trade selectTradeByNo(String TradeNo);
	
	@Select("select * from trade_photo where trade_no = #{tdNo}")
	List<TradePhoto> selectPhotoListBytradeNo(String no);
	
	@Insert("insert into trade values('T' || seq_trade_trade_no.nextval, #{userId}, #{categoryId}, #{tradeTitle}, " 
			+ "#{tradeContent}, default, default, #{tradePrice}, default, #{tradeQuality}, default)")
	@SelectKey(statement = "select 'T' || seq_trade_trade_no.currval from dual" , before = false, keyProperty = "tradeNo", resultType = String.class)
	int insertTrade(Trade trade);
	
	@Insert("insert into trade_photo values(seq_trade_photo_no.nextval, #{tdNo}, #{originalFilename}, #{renamedFilename})")
	int insertPhoto(TradePhoto photo);
	
	@Select("select * from trade_photo where trade_photo_no = #{tradePhotoNo}")
	TradePhoto selectOnePhoto(int photoNo);

	@Delete("delete from trade_photo where trade_photo_no = #{tradePhotoNo}")
	int deletePhoto(int photoNo);
	
	@Update("update trade set category_id = #{categoryId}, trade_title = #{tradeTitle}, trade_content = #{tradeContent}, trade_price = #{tradePrice}, trade_quality = #{tradeQuality} where trade_no = #{tradeNo}")
	int updateTrade(Trade trade);
	
	@Delete("delete from trade where trade_no = #{trade_no}")
	int deleteTrade(String no);

	
}
