package com.kh.campingez.user.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.TradeEntity;
import com.kh.campingez.user.model.dao.UserInfoDao;
import com.kh.campingez.user.model.dto.MyPage;
import com.kh.campingez.user.model.dto.User;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	private UserInfoDao userInfoDao;
	
	
	@Override
	public int profileUpdate(User user) {
		return userInfoDao.profileUpdate(user);
	}
	@Override
	public int profileDelete(User user) {
		return userInfoDao.profileDelete(user);
	}
	@Override
	public List<Inquire> selectInquireList(User user) {
		return userInfoDao.selectInquireList(user);
	}
	@Override
	public List<Reservation> selectReservationList(User user) {
		return userInfoDao.selectReservationList(user);
	}
	@Override
	public List<MyPage> selectInquireCnt(User user) {
		return userInfoDao.selectInquireCnt(user);
	}
	@Override
	public List<Reservation> selectReservation(User user) {
		return userInfoDao.selectReservation(user);
	}
	@Override
	public List<Coupon> selectCoupon(User user) {
		return userInfoDao.selectCoupon(user);
	}
	@Override
	public List<AssignmentEntity> selectAssignList(User user) {
		return userInfoDao.selectAssignList(user);
	}
	@Override
	public List<MyPage> selectTradeCnt(User user) {
		return userInfoDao.selectTradeCnt(user);
	}
	@Override
	public List<TradeEntity> selectTradeList(User user) {
		return userInfoDao.selectTradeList(user);
	}
}
