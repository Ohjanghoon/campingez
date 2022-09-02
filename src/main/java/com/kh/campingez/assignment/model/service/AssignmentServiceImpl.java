package com.kh.campingez.assignment.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.assignment.model.dao.AssignmentDao;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.reservation.model.dto.Reservation;

@Service
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
}
