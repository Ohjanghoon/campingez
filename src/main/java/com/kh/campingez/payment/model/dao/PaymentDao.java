package com.kh.campingez.payment.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PaymentDao {

	@Update("update reservation set res_state = '예약완료' where res_no = #{resNo}")
	int updateReservation(String resNo);

	@Update("update reservation set res_state = '양도예약완료' where res_no = #{resNo}")
	int updateAssignReservation(String resNo);

	@Update("update assignment set assign_state = '양도완료' where assign_no = #{assignNo} ")
	int updateAssign(String assignNo);

	
}
