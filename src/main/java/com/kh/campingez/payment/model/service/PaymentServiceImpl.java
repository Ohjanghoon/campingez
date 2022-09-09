package com.kh.campingez.payment.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.payment.model.dao.PaymentDao;

@Service
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	PaymentDao paymentDao;
	
	@Override
	public int updateReservation(String resNo) {
		return paymentDao.updateReservation(resNo);
	}
}
