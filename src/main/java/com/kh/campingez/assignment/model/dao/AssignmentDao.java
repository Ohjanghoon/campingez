package com.kh.campingez.assignment.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.reservation.model.dto.Reservation;

@Mapper
public interface AssignmentDao {

	List<Assignment> selectAssignmentList();

	@Select("select * from reservation where user_id = #{userId}")
	List<Reservation> selectReservationList(String userId);

	
}
