package com.kh.campingez.reservation.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.reservation.model.dao.ReservationDao;
import com.kh.campingez.reservation.model.dto.Reservation;

@Service
public class ReservationServiceImpl implements ReservationService {

	@Autowired
	private ReservationDao reservationDao;
	
	@Override
	public List<Camp> campList(Map<String, Object> param) {
		return reservationDao.campList(param);
	}
	
	@Override
	public CampZone campZoneInfo(String campId) {
		return reservationDao.campZoneInfo(campId);
	}
	
	@Override
	public int insertReservation(Reservation reservation) {
		return reservationDao.insertReservation(reservation);
	}
	
}
