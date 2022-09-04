package com.kh.campingez.notice.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.notice.model.dto.Coupon;
import com.kh.campingez.notice.model.dto.Notice;
import com.kh.campingez.notice.model.dto.NoticePhoto;

public interface NoticeService {

	List<Notice> noticeList(Map<String, Integer> param);

	int getTotalContent();

	Notice selectByNoticeNo(String noticeNo);

	int deleteNotice(String noticeNo);

	NoticePhoto selectByPhotoNo(int noticePhotoNo);

	int deletePhoto(int noticePhotoNo);

	int updateNotice(Notice notice);

	int insertNotice(Notice notice);

	boolean findByCoupon(String couponCode);

	int insertCoupon(Coupon coupon);

}
