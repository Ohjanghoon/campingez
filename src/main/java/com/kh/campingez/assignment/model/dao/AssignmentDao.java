package com.kh.campingez.assignment.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dto.Reservation;

@Mapper
public interface AssignmentDao {

	List<Assignment> selectAssignmentList();

	@Select("select * \r\n"
			+ "from( \r\n"
			+ "    select * from reservation where user_id = #{userId}\r\n"
			+ "    minus\r\n"
			+ "    select r.* from reservation r join assignment a on r.res_no = a.res_no)\r\n"
			+ "where\r\n"
			+ "	   res_checkin > current_date - 1\r\n"
			+ "	   and\r\n"
			+ "    res_state = '예약완료'\r\n"
			+ "order by\r\n"
			+ "    res_checkin")
	List<Reservation> selectReservationList(String userId);

	@Select("select * from reservation where res_no = #{resNo}")
	Reservation selectResInfo(String resNo);

	@Insert("insert into assignment values('AS' || seq_assign_no.nextval, #{userId}, #{resNo},"
			+ " #{assignTitle}, #{assignContent}, #{assignPrice}, default, default, default)")
	int insertAssignment(AssignmentEntity assignment);

	Assignment assignmentDetail(String assignNo);

	
}
