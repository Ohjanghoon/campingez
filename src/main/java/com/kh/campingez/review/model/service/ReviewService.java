package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.review.model.dto.Review;

public interface ReviewService {

	List<Review> findAllReviewList(Map<String, Object> param);

	int getTotalContentByAllReviewList(Map<String, Object> param);

	List<Review> findReviewListBySearchType(Map<String, Object> param);

	List<Review> findReviewListContainsPhoto(Map<String, Object> param);

	int getTotalContentAllReviewListContainsPhoto(Map<String, Object> param);

	Review findOneReviewById(int revId);

}
