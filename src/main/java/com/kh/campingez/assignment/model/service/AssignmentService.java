package com.kh.campingez.assignment.model.service;

import java.util.List;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dto.Reservation;

public interface AssignmentService {

	List<Assignment> selectAssignmentList();

	List<Reservation> selectReservationList(String userId);

	Reservation selectResInfo(String resNo);

	int insertAssignment(AssignmentEntity assignment);

	Assignment assignmentDetail(String assignNo);

	Reservation insertAssignmentApply(Reservation reservation);

	String selectAssignState(String assignNo);

	int updateAssignStateAndTransfer(String assignNo, String assignTransfer);

}
