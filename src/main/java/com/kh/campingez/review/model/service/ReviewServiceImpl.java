package com.kh.campingez.review.model.service;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.kh.campingez.review.model.dao.ReviewDao;
import com.kh.campingez.review.model.dto.Review;
import com.kh.campingez.review.model.dto.ReviewEntity;
import com.kh.campingez.review.model.dto.ReviewPhoto;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor = Exception.class)
@Slf4j
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
	
	@Override
	public int insertReview(Review review) {
		// insert board
		int result = reviewDao.insertBoard(review);
		log.debug("board#no = {}", review.getRevId());
		
		// insert attachment * n
		List<ReviewPhoto> attachments = review.getReviewPhotos();
		if(!attachments.isEmpty()) {
			for(ReviewPhoto attach : attachments) {
				attach.setRevId(review.getRevId());
				result = insertReviewPhoto(attach);
			}
		}
		return result;
	}

	@Override
	public int insertReviewPhoto(ReviewPhoto attach) {
		return reviewDao.insertReviewPhoto(attach);
	}
	
	@Override
	public List<ReviewEntity> selectReview(String resNo) {
		return reviewDao.selectReview(resNo);
	}
	@Override
	public List<ReviewPhoto> selectReviewPhoto(int revId) {
		return reviewDao.selectReviewPhoto(revId);
	}

}
