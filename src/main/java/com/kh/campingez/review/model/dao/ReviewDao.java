package com.kh.campingez.review.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.session.RowBounds;

import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.dto.ReviewPhoto;

@Mapper
public interface ReviewDao {

	@Select("select * from review order by rev_enroll_date desc")
	List<Review> findAllReviewList(RowBounds rowBounds);
	
	@Select("select count(*) from review")
	int getTotalContentByAllReviewList();

	@Insert("insert into review values(seq_review_rev_id.nextval, #{resNo}, #{revContet}, #{revScore}, sysdate)")
	@SelectKey(statement = "select seq_review_rev_id.currval from dual", before = false, keyProperty = "revId", resultType = int.class)
	int insertBoard(Review review);

	@Insert("insert into review_photo values(seq_review_photo_no.nextval, #{revId}, #{revOriginalFilename}, #{revRenamedFilename})")
	int insertReviewPhoto(ReviewPhoto attach);

}
