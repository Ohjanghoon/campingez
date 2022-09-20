package com.kh.campingez.assignment.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.reservation.model.dto.Reservation;

@Mapper
public interface AssignmentDao {

	List<Assignment> selectAssignmentList(@Param("start") int start, @Param("end") int end);

	@Select("select count(*) from assignment join reservation r using(res_no, user_id) where res_checkin - 1 > current_date")
	int getTotalContent();
	
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
			+ " #{assignTitle}, #{assignContent}, #{assignPrice}, default, default, default, #{assignTransfer})")
	int insertAssignment(AssignmentEntity assignment);

	Assignment assignmentDetail(String assignNo);

	int insertAssignmentApply(Reservation reservation);
	
	@Select("select assign_state from assignment where assign_no = #{assignNo}")
	String selectAssignState(String assignNo);

	@Update("update assignment set assign_state = '양도중', assign_transfer = #{assignTransfer} where assign_no = #{assignNo}")
	int updateAssignStateAndTransfer(@Param("assignNo") String assignNo, @Param("assignTransfer") String assignTransfer);

	List<Assignment> selectAssignmentList();

	
	
	


	
}
