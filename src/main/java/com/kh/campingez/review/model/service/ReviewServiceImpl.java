package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.review.model.dao.ReviewDao;
import com.kh.campingez.review.model.dto.Review;

@Service
@Transactional(rollbackFor = Exception.class)
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public List<Review> findAllReviewList(Map<String, Object> param) {
		return reviewDao.findAllReviewList(getRowBounds(param));
	}
	
	@Override
	public int getTotalContentByAllReviewList() {
		return reviewDao.getTotalContentByAllReviewList();
	}

	private RowBounds getRowBounds(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		return new RowBounds(offset, limit);
	}
	
	
}
