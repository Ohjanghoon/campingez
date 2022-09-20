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

import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.trade.model.dto.TradeLike;
import com.kh.campingez.trade.model.dto.TradePhoto;

@Mapper
public interface TradeDao {
	
//	@Select("select * from trade order by trade_no desc")
	List<Trade> selectTradeList(RowBounds rowBounds);
	
	@Select("select count(*) from trade")
	int getTotalContent();
	
//	@Select("select * from trade where trade_no = #{tradeNo}")
	Trade selectTradeByNo(String tradeNo);
	
//	@Select("select * from trade_photo where trade_no = #{tdNo}")
	List<TradePhoto> selectPhotoListByTradeNo(String no);
	
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
	
	@Delete("delete from trade where trade_no = #{tradeNo}")
	int deleteTrade(String no);
	
	@Update("update trade set trade_read_count = ${readCount} + 1 where trade_no = #{tradeNo}")
	int updateReadCount(Trade trade);

	@Select("select count(like_check) from trade_like where trade_no = #{likeTradeNo} and user_id = #{likeUserId}")
	int getTradeLike(TradeLike tl);
	
	@Delete("delete from trade_like where trade_no = #{likeTradeNo} and user_id = #{likeUserId}")
	void deleteTradeLike(TradeLike tl);
	
	@Update("update trade set trade_like_count = (select count(*) from trade_like where trade_no = #{likeTradeNo}) where trade_no = #{tradeNo} ")
	void updateTradeLike(String likeTradeNo);
	
	@Insert("insert into trade_like (trade_no, user_id) values (#{likeTradeNo}, #{likeUserId})")
	void insertTradeLike(TradeLike tl);
	
	@Select("select * from trade_photo where trade_no = #{tdNo}")
	List<TradePhoto> selectPhotoList(String no);
	
//	@Select("select * from trade where category_id = #{categoryId}")
	List<Trade> selectTradeListKind(RowBounds rowBounds, String categoryId);
	
	@Select("select count(*) from trade where category_id = #{categoryId}")
	int getTotalContentKind();
	
	@Update("update trade set trade_success = '거래 완료' where trade_no = #{tradeNo}")
	int updateSuccess(String no);
	
	@Select("select * from category_list where category_id like '%' || 'rep' || '%'")
	List<Category> getReportCategory();

	@Select("select (select user_id from report where comm_no = t.trade_no and user_id = #{userId}) report_user_id from trade t where trade_no = #{no}")
	String getUserReportTrade(Map<String, Object> param);
	
	
	
	
}
