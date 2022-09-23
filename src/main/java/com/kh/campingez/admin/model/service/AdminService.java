package com.kh.campingez.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.admin.model.dto.Stats;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.report.dto.Report;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.user.model.dto.User;

public interface AdminService {

	List<User> findAllUserList(Map<String, Object> param);

	int getTotalContent();

	int updateWarningToUser(Map<String, Object> param);

	List<User> selectUserByKeyword(Map<String, Object> param);

	int getTotalContentByKeyword(Map<String, Object> param);

	User findUserByUserId(String userId);

	List<Inquire> findAllInquireList(Map<String, Object> param);

	int enrollAnswer(Answer answer);

	int deleteAnswer(Answer answer);

	int updateAnswer(Answer answer);

	int getInquireListTotalContent();

	List<Inquire> findInquireListByCategoryId(Map<String, Object> param);

	int getInquireListTotalContentByCategoryId(String categoryId);

	List<Category> getCategoryList();

	List<Reservation> findReservationList(Map<String, Object> param);

	int getReservationListTotalContent(Map<String, Object> param);

	List<CampZone> findAllCampZoneList();

	CampZone findCampZoneByZoneCode(String zoneCode);

	int updateCampZone(CampZone campZone);

	int insertCampZone(CampZone campZone);

	int deleteCampZone(String zoneCode);

	List<CampPhoto> selectCampPhotoByZoneCode(CampZone campZone);

	CampPhoto findCampPhotoByPhotoNo(int photoNo);

	int deleteCampPhotoByPhotoNo(int photoNo);

	List<CampZone> findAllCampList();

	int insertDailyVisit(String userId);

	List<Stats> statsVisitedChartByDate(Map<String, Object> param);

	int statsVisitedTotalCountByDate(Map<String, Object> param);

	int statsVisitedTotalCount();

	List<Stats> getLoginMemberListByDate(String searchDate);

	List<Stats> getMonthlySalesListByYear(int year);

	List<Stats> getSaleListByMonth(Map<String, Object> param);

	int getTotalSalesPrice();

	int getYearTotalSalesPrice(Map<String, Object> param);

	List<User> findAllBlackList(Map<String, Object> param);

	int getBlackListTotalContent();

	List<User> findAllNotBlackList(Map<String, Object> param);

	int getNotBlackListTotalContent();

	List<User> selectNotBlackListByKeyword(Map<String, Object> param);

	int getTotalContentNotBlackListByKeyword(Map<String, Object> param);

	Camp selectCampByCampId(String campId);

	int insertCamp(Map<String, Object> param);

	int deleteCampByCampId(String campId);

	List<CampZone> findCampByZoneCode(String zoneCode);

	List<Assignment> findAllAssignmentList(Map<String, Object> param);

	int getAssignmentTotalContent();

	List<Assignment> findAssignmentListBySelectType(Map<String, Object> param);

	int getAssignmentBySelectTypeTotalContent(Map<String, Object> param);

	List<Assignment> findAllExpireAssignmentList(Map<String, Object> param);

	int getExpireAssignmentTotalContent();

	List<Trade> findAllTradeReportList(Map<String, Object> param);

	int getTradeReportTotalContent();

	int updateReportAction(String commNo);

	int updateReportActionAndIsDelete(Map<String, Object> param);

	List<Report> findAllUserReportTotal(Map<String, Object> param);

	int getUserReportTotalContent();

	int updateCancelWarningToUser(String userId);

	List<Coupon> findAllIngCouponList(Map<String, Object> param);

	List<Coupon> findAllExpireCouponList(Map<String, Object> param);

	int getIngCouponTotalContent();

	int getExpireCouponTotalContent();

}
