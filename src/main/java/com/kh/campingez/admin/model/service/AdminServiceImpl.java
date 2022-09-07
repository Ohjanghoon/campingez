package com.kh.campingez.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.admin.model.dao.AdminDao;
import com.kh.campingez.admin.model.dto.StatsVisited;
import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.common.category.mode.dto.Category;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao adminDao;
	
	@Override
	public List<User> findAllUserList(Map<String, Object> param) {
		return adminDao.findAllUserList(getRowBounds(param));
	}
	
	@Override
	public int getTotalContent() {
		return adminDao.getTotalContent();
	}
	
	@Override
	public int updateWarningToUser(String userId) {
		log.debug("userId@service = {}", userId);
		return adminDao.updateWarningToUser(userId);
	}
	
	@Override
	public List<User> selectUserByKeyword(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);
		
		return adminDao.selectUserByKeyword(rowBounds, param);
	}

	@Override
	public int getTotalContentByKeyword(Map<String, Object> param) {
		return adminDao.getTotalContentByKeyword(param);
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
	public List<Camp> findAllCampList() {
		return adminDao.findAllCampList();
	}
	
	@Override
	public int insertDailyVisit(String userId) {
		return adminDao.insertDailyVisit(userId);
	}
	
	@Override
	public List<StatsVisited> findStatsVisited() {
		return adminDao.findStatsVisited();
	}

	private RowBounds getRowBounds(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		
		return new RowBounds(offset, limit);
	}
}
