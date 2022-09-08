package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.dto.ReviewEntity;
import com.kh.campingez.review.model.dto.ReviewPhoto;

public interface ReviewService {

	List<Review> findAllReviewList(Map<String, Object> param);

	int getTotalContentByAllReviewList(Map<String, Object> param);

	List<Review> findReviewListBySearchType(Map<String, Object> param);

	List<Review> findReviewListContainsPhoto(Map<String, Object> param);

	int getTotalContentAllReviewListContainsPhoto(Map<String, Object> param);

	Review findOneReviewById(int revId);

	int insertReview(Review review);

	int insertReviewPhoto(ReviewPhoto attach);

	ReviewEntity selectReview(String resNo);

	ReviewPhoto selectReviewPhoto(int revId);

	int deleteAttachment(ReviewPhoto reviewPhoto);

	int updateReview(Review review);

	Review bestReviewByCampzone(String campZone);

	int deleteReview(String resNo);

	

	
}
