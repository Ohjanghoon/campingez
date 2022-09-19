package com.kh.campingez.assignment.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dto.Reservation;

public interface AssignmentService {

	List<Assignment> selectAssignmentList(Map<String, Integer> param);

	List<Reservation> selectReservationList(String userId);

	Reservation selectResInfo(String resNo);

	int insertAssignment(AssignmentEntity assignment);

	Assignment assignmentDetail(String assignNo);

	Reservation insertAssignmentApply(Reservation reservation);

	String selectAssignState(String assignNo);

	int updateAssignStateAndTransfer(String assignNo, String assignTransfer);

	int getTotalContent();

}
