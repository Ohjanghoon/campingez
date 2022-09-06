package com.kh.campingez.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.review.model.dto.Review;

@Mapper
public interface ReviewDao {

	List<Review> findAllReviewList(RowBounds rowBounds);
	
	int getTotalContentByAllReviewList(Map<String, Object> param);
	
	List<Review> findReviewListBySearchType(Map<String, Object> param, RowBounds rowBounds);
	
	List<Review> findReviewListContainsPhoto(Map<String, Object> param, RowBounds rowBounds);
	
	int getTotalContentAllReviewListContainsPhoto(Map<String, Object> param);

	Review findOneReviewById(int revId);

}
