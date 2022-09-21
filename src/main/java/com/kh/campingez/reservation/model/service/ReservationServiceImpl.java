package com.kh.campingez.reservation.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.reservation.model.dao.ReservationDao;
import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
	public Reservation insertReservation(Reservation reservation) {
		int result = reservationDao.insertReservation(reservation);
		String resNo = reservation.getResNo();
		log.debug("resNo = {}", reservation.getResNo());
		
		return reservationDao.selectCurrReservation(resNo);
	}
	
	@Override
	public List<Reservation> findReservationByName(Map<Object, String> param) {
		return reservationDao.findReservationByName(param);
	}
	
}
