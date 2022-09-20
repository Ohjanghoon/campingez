package com.kh.campingez.payment.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.payment.model.dao.PaymentDao;

@Service
@Transactional
public class PaymentServiceImpl implements PaymentService {

	@Autowired
	PaymentDao paymentDao;
	
	@Override
	public int updateReservation(String resNo) {
		//결제대기 → 예약완료
		return paymentDao.updateReservation(resNo);
	}
	
	@Override
	public int updateAssignReservation(String resNo, String assignNo) {
		//1. 해당 예약상태 변결 : 양도결제대기 → 양도예약완료
		int result = paymentDao.updateAssignReservation(resNo);
		
		//2. 해당 양도상태 변결 : 양도결제대기 → 양도예약완료 
		result = paymentDao.updateAssign(assignNo);
		
		return result; 
	}
}
