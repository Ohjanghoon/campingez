package com.kh.campingez.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.admin.model.dto.Stats;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.user.model.dto.User;

public interface AdminService {

	List<User> findAllUserList(Map<String, Object> param);

	int getTotalContent();

	int updateWarningToUser(String userId);

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

	List<Camp> findAllCampList();

	int insertDailyVisit(String userId);

	List<Stats> statsVisitedChartByDate(Map<String, Object> param);

	int statsVisitedTotalCountByDate(Map<String, Object> param);

	int statsVisitedTotalCount();

	List<Stats> getLoginMemberListByDate(String searchDate);

	List<Stats> getMonthlySalesListByYear(int year);

	List<Stats> getSaleListByMonth(Map<String, Object> param);

	int getTotalSalesPrice();

	int getYearTotalSalesPrice(Map<String, Object> param);

}
