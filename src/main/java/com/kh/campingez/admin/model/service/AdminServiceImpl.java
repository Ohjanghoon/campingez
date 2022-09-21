package com.kh.campingez.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.admin.model.dao.AdminDao;
import com.kh.campingez.admin.model.dto.Stats;
import com.kh.campingez.alarm.model.dao.AlarmDao;
import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.alarm.model.dto.AlarmType;
import com.kh.campingez.alarm.model.service.AlarmService;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.report.dto.Report;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.trade.model.dto.Trade;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	AlarmDao alarmDao;
	
	@Override
	public List<User> findAllUserList(Map<String, Object> param) {
		return adminDao.findAllUserList(getRowBounds(param));
	}
	
	@Override
	public List<User> findAllBlackList(Map<String, Object> param) {
		return adminDao.findAllBlackList(getRowBounds(param));
	}
	
	@Override
	public List<User> findAllNotBlackList(Map<String, Object> param) {
		return adminDao.findAllNotBlackList(getRowBounds(param));
	}
	
	@Override
	public int getBlackListTotalContent() {
		return adminDao.getBlackListTotalContent();
	}
	
	@Override
	public int getNotBlackListTotalContent() {
		return adminDao.getNotBlackListTotalContent();
	}
	
	@Override
	public int getTotalContent() {
		return adminDao.getTotalContent();
	}
	
	@Override
	public int updateWarningToUser(Map<String, Object> param) {
		String userId = (String)param.get("userId");		
		return adminDao.updateWarningToUser(userId);
	}
	
	@Override
	public List<User> selectUserByKeyword(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);
		
		return adminDao.selectUserByKeyword(rowBounds, param);
	}
	
	@Override
	public List<User> selectNotBlackListByKeyword(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);
		return adminDao.selectNotBlackListByKeyworkd(rowBounds, param);
	}
	
	@Override
	public int getTotalContentByKeyword(Map<String, Object> param) {
		return adminDao.getTotalContentByKeyword(param);
	}
	
	@Override
	public int getTotalContentNotBlackListByKeyword(Map<String, Object> param) {
		return adminDao.getTotalContentNotBlackListByKeyword(param);
	}
	
	@Override
	public User findUserByUserId(String userId) {
		return adminDao.findUserByUserId(userId);
	}
	
	@Override
	public List<Inquire> findAllInquireList(Map<String, Object> param) {
		return adminDao.findAllInquireList(getRowBounds(param));
	}
	
	@Override
	public int enrollAnswer(Answer answer) {
		return adminDao.enrollAnswer(answer);
	}
	
	@Override
	public int deleteAnswer(Answer answer) {
		return adminDao.deleteAnswer(answer);
	}
	
	@Override
	public int updateAnswer(Answer answer) {
		return adminDao.updateAnswer(answer);
	}
	
	@Override
	public int getInquireListTotalContent() {
		return adminDao.getInquireListTotalContent();
	}
	
	@Override
	public List<Inquire> findInquireListByCategoryId(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);

		return adminDao.findInquireListByCategoryId(rowBounds, param);
	}
	
	@Override
	public int getInquireListTotalContentByCategoryId(String categoryId) {
		return adminDao.getInquireListTotalContentByCategoryId(categoryId);
	}
	
	@Override
	public List<Category> getCategoryList() {
		return adminDao.getCategoryList();
	}
	
	@Override
	public List<Reservation> findReservationList(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);
		return adminDao.findReservationList(rowBounds, param);
	}
	
	@Override
	public int getReservationListTotalContent(Map<String, Object> param) {
		return adminDao.getReservationListTotalContent(param);
	}
	
	@Override
	public List<CampZone> findAllCampZoneList() {
		return adminDao.findAllCampZoneList();
	}
	
	@Override
	public CampZone findCampZoneByZoneCode(String zoneCode) {
		return adminDao.findCampZoneByZoneCode(zoneCode);
	}
	
	@Override
	public int updateCampZone(CampZone campZone) {
		int result = adminDao.updateCampZone(campZone);
		
		List<CampPhoto> campPhotos = campZone.getCampPhotos();
		if(!campPhotos.isEmpty()) {
			for(CampPhoto photo : campPhotos) {
				result = adminDao.insertCampPhoto(photo);
			}
		}
		
		return result;
	}
	
	@Override
	public int insertCampZone(CampZone campZone) {
		int result = adminDao.insertCampZone(campZone);
		
		List<CampPhoto> campPhotos = campZone.getCampPhotos();
		if(campPhotos != null && !campPhotos.isEmpty()) {
			for(CampPhoto photo : campPhotos) {
				photo.setZoneCode(campZone.getZoneCode());
				result = adminDao.insertCampPhoto(photo);
			}
		}
		return result;
	}
	
	@Override
	public int deleteCampZone(String zoneCode) {
		return adminDao.deleteCampZone(zoneCode);
	}
	
	@Override
	public List<CampPhoto> selectCampPhotoByZoneCode(CampZone campZone) {
		return adminDao.selectCampPhotoByZoneCode(campZone);
	}
	
	@Override
	public CampPhoto findCampPhotoByPhotoNo(int photoNo) {
		return adminDao.findCampPhotoByPhotoNo(photoNo);
	}
	
	@Override
	public int deleteCampPhotoByPhotoNo(int photoNo) {
		return adminDao.deleteCampPhotoByPhotoNo(photoNo);
	}
	
	@Override
	public List<CampZone> findAllCampList() {
		return adminDao.findAllCampList();
	}
	
	@Override
	public int insertDailyVisit(String userId) {
		return adminDao.insertDailyVisit(userId);
	}

	@Override
	public List<Stats> statsVisitedChartByDate(Map<String, Object> param) {
		return adminDao.statsVisitedChartByDate(param);
	}
	
	@Override
	public int statsVisitedTotalCountByDate(Map<String, Object> param) {
		return adminDao.statsVisitedTotalCountByDate(param);
	}
	
	@Override
	public int statsVisitedTotalCount() {
		return adminDao.statsVisitedTotalCount();
	}
	
	@Override
	public List<Stats> getLoginMemberListByDate(String searchDate) {
		return adminDao.getLoginMemberListByDate(searchDate);
	}
	
	@Override
	public List<Stats> getMonthlySalesListByYear(int year) {
		return adminDao.getMonthlySalesListByYear(year);
	}
	
	@Override
	public List<Stats> getSaleListByMonth(Map<String, Object> param) {
		return adminDao.getSaleListByMonth(param);
	}
	
	@Override
	public int getTotalSalesPrice() {
		return adminDao.getTotalSalesPrice();
	}
	
	@Override
	public int getYearTotalSalesPrice(Map<String, Object> param) {
		return adminDao.getYearTotalSalesPrice(param);
	}

	@Override
	public Camp selectCampByCampId(String campId) {
		return adminDao.selectCampByCampId(campId);
	}
	
	@Override
	public int insertCamp(Map<String, Object> param) {
		return adminDao.insertCamp(param);
	}
	
	@Override
	public int deleteCampByCampId(String campId) {
		return adminDao.deleteCampByCampId(campId);
	}
	
	@Override
	public List<CampZone> findCampByZoneCode(String zoneCode) {
		return adminDao.findCampByZoneCode(zoneCode);
	}
	
	@Override
	public List<Assignment> findAllAssignmentList(Map<String, Object> param) {
		return adminDao.findAllAssignmentList(getRowBounds(param));
	}
	
	@Override
	public int getAssignmentTotalContent() {
		return adminDao.getAssignmentTotalContent();
	}
	
	@Override
	public List<Assignment> findAssignmentListBySelectType(Map<String, Object> param) {
		RowBounds rowBound = getRowBounds(param);
		return adminDao.findAssignmentListBySelectType(param, rowBound);
	}
	
	@Override
	public int getAssignmentBySelectTypeTotalContent(Map<String, Object> param) {
		return adminDao.getAssignmentBySelectTypeTotalContent(param);
	}
	
	@Override
	public List<Assignment> findAllExpireAssignmentList(Map<String, Object> param) {
		return adminDao.findAllExpireAssignmentList(getRowBounds(param));
	}
	
	@Override
	public int getExpireAssignmentTotalContent() {
		return adminDao.getExpireAssignmentTotalContent();
	}
	
	@Override
	public List<Trade> findAllTradeReportList(Map<String, Object> param) {
		return adminDao.findAllTradeReportList(getRowBounds(param));
	}
	
	@Override
	public int getTradeReportTotalContent() {
		return adminDao.getTradeReportTotalContent();
	}
	
	@Override
	public int updateReportAction(String commNo) {
		return adminDao.updateReportAction(commNo);
	}
	
	private RowBounds getRowBounds(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		
		return new RowBounds(offset, limit);
	}
}
