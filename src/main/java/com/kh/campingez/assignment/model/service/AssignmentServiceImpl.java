package com.kh.campingez.assignment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.assignment.model.dao.AssignmentDao;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dao.ReservationDao;
import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class AssignmentServiceImpl implements AssignmentService {

	@Autowired
	AssignmentDao assignmentDao;
	
	@Autowired
	ReservationDao reservationDao;
	
	@Override
	public List<Assignment> selectAssignmentList() {
		return assignmentDao.selectAssignmentList();
	}
	
	@Override
	public List<Reservation> selectReservationList(String userId) {
		return assignmentDao.selectReservationList(userId);
	}
	
	@Override
	public Reservation selectResInfo(String resNo) {
		return assignmentDao.selectResInfo(resNo);
	}
	
	@Override
	public int insertAssignment(AssignmentEntity assignment) {
		return assignmentDao.insertAssignment(assignment);
	}
	
	@Override
	public Assignment assignmentDetail(String assignNo) {
		return assignmentDao.assignmentDetail(assignNo);
	}
	
	@Override
	public String selectAssignState(String assignNo) {
		log.debug("assignNo = {}", assignNo);
		String assignState = assignmentDao.selectAssignState(assignNo);
		
		return assignState;
	}
	
	@Override
	public int updateAssignStateAndTransfer(String assignNo, String assignTransfer) {
		return assignmentDao.updateAssignStateAndTransfer(assignNo, assignTransfer);
	}
	
	@Override
	public Reservation insertAssignmentApply(Reservation reservation) {
		//1. 양도 희망자 예약 테이블에 insert
		int result = assignmentDao.insertAssignmentApply(reservation);
		
		//2. 양도 희망자 결제를 위한 해당 예약 리턴
		String resNo = reservation.getResNo();
		log.debug("resNo = {}", reservation.getResNo());
		
		return reservationDao.selectCurrReservation(resNo);
	}
}
