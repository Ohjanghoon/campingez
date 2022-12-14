package com.kh.campingez.reservation.model.dto;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

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
	private int resPerson; // 예약인원
	private int resPrice; // 예약 금액
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private LocalDate resDate; // 예약일자
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private LocalDate resCheckin; // 입실일자
    @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private LocalDate resCheckout; // 퇴실일자
	private String resCarNo; // 차량번호
	private String resRequest; // 예약요청사항
	private String resState; // 예약상태
	private String resPayment; // 결제 수단
	private String review; // 김승환 예약테이블 리뷰작성용 컬럼
}
