package com.kh.campingez.reservation.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.campzone.model.dto.Camp;
import com.kh.campingez.campzone.model.dto.CampZone;
import com.kh.campingez.reservation.model.dto.Reservation;

public interface ReservationService {

	List<Camp> campList(Map<String, Object> param);

	CampZone campZoneInfo(String campId);

	Reservation insertReservation(Reservation reservation);

	List<Reservation> findReservationByName(Map<Object, String> param);

}
