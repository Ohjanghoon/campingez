package com.kh.campingez.user.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.assignment.model.dto.AssignmentEntity;
import com.kh.campingez.coupon.model.dto.Coupon;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.reservation.model.dto.Reservation;
import com.kh.campingez.user.model.dto.MyPage;
import com.kh.campingez.user.model.dto.User;

@Mapper
public interface UserInfoDao {

	@Update(" update ez_user "
			  + " set user_name = #{userName}, password = #{password}, email = #{email}, phone = #{phone}, gender = #{gender} "
			  + " where user_id = #{userId}")
	int profileUpdate(User user);
	
	
	@Delete("Delete from ez_user where user_id = #{userId}")
	int profileDelete(User user);
	
	
	List<Inquire> selectInquireList(User user);

	
	List<Reservation> selectReservationList(User user);

	
	List<MyPage> selectInquireCnt(User user);


	List<Reservation> selectReservation(User user);

	
	List<Coupon> selectCoupon(User user);

	@Select("select * from assignment where user_id = #{userId}")
	List<AssignmentEntity> selectAssignList(User user);

}
