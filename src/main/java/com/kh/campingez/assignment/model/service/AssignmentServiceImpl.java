package com.kh.campingez.assignment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.assignment.model.dao.AssignmentDao;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dto.Reservation;

@Service
@Transactional
public class AssignmentServiceImpl implements AssignmentService {

	@Autowired
	AssignmentDao assignmentDao;
	
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
}
