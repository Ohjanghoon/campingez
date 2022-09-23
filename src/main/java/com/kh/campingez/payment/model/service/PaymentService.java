package com.kh.campingez.payment.model.service;

public interface PaymentService {

	int updateReservation(String resNo);

	int updateAssignReservation(String resNo, String assignNo);

}
