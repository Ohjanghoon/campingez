package com.kh.campingez.payment.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface PaymentDao {

	@Update("update reservation set res_state = '예약완료' where res_no = #{resNo}")
	int updateReservation(String resNo);

	
}
