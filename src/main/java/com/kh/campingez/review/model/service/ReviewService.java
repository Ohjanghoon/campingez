package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.dto.ReviewPhoto;

public interface ReviewService {

	List<Review> findAllReviewList(Map<String, Object> param);

	int getTotalContentByAllReviewList();

	int insertReview(Review review);

	int insertReviewPhoto(ReviewPhoto attach);
}
