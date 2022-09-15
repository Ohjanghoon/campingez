package com.kh.campingez.user.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.TradeEntity;
import com.kh.campingez.user.model.dto.MyPage;
import com.kh.campingez.user.model.dto.User;

public interface UserInfoService {

	int profileUpdate(User user);

	int profileDelete(User user);

	List<Inquire> selectInquireList(User user);

	List<Reservation> selectReservationList(User user);

	List<MyPage> selectInquireCnt(User user);

	List<Reservation> selectReservation(User user);

	List<Coupon> selectCoupon(User user);

	List<AssignmentEntity> selectAssignList(Map<String, Object> param, User user);

	List<MyPage> selectTradeCnt(User user);

	List<TradeEntity> selectTradeList(User user);

	int getTotalAssignment(User user);

}
