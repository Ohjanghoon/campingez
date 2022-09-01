package com.kh.campingez.reservation.model.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Reservation {
	private String resNo; // 예약번호
	private String campId; // 자리아이디
	private String userId; // 회원아이디
	private String resUsername; // 예약자이름
	private String resPhone; // 예약자 전화번호
	private int person; // 예약인원
	private int price; // 예약 금액
	private LocalDate resCesDate; // 예약일자
	private LocalDate resCheckin; // 입실일자
	private LocalDate resCheckout; // 퇴실일자
	private String resCarNo; // 차량번호
	private String resRequest; // 예약요청사항
	private String resState; // 예약상태
	private String resPayment; // 결제 수단
}
