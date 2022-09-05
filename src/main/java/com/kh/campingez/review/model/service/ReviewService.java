package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.review.model.dto.Review;

public interface ReviewService {

	List<Review> findAllReviewList(Map<String, Object> param);

	int getTotalContentByAllReviewList();

}
