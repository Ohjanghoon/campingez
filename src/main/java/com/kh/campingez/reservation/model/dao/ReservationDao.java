package com.kh.campingez.reservation.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.reservation.model.dto.Reservation;

@Mapper
public interface ReservationDao {

	@Select("select * from camp where camp_id not in (select camp_id from reservation where res_checkin between #{checkin} and #{checkout} or res_checkout between #{checkin} and #{checkout})")
	List<Camp> campList(Map<String, Object> param);

	@Select("select * from camp_zone join (select * from camp where camp_id = #{campId}) camp on camp_zone.zone_code = camp.zone_code")
	CampZone campZoneInfo(String campId);

	@Insert("insert into reservation values (#{campId}||seq_reservation_res_no.nextval, #{campId}, #{userId}, #{resUsername}, #{resPhone}, #{resPerson}, #{resPrice}, default, #{resCheckin}, #{resCheckout}, #{resCarNo}, #{resRequest}, '결제대기', #{resPayment})")
	int insertReservation(Reservation reservation);

}