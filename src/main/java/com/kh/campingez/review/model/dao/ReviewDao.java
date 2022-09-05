package com.kh.campingez.review.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.review.model.dto.Review;

@Mapper
public interface ReviewDao {

	@Select("select * from review order by rev_enroll_date desc")
	List<Review> findAllReviewList(RowBounds rowBounds);
	
	@Select("select count(*) from review")
	int getTotalContentByAllReviewList();

}
