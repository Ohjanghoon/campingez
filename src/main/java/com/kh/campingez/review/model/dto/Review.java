package com.kh.campingez.review.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Review extends ReviewEntity {
	private Reservation reservation;
	private List<ReviewPhoto> reviewPhotos = new ArrayList<>();
	private String zoneCode;
	
	public Review(int revId, String resNo, String revContent, int revScore, LocalDateTime revEnrollDate, Reservation reservation, List<ReviewPhoto> reviewPhotos, String zoneCode) {
		super(revId, resNo, revContent, revScore, revEnrollDate);
		this.reservation = reservation;
		this.reviewPhotos = reviewPhotos;
		this.zoneCode = zoneCode;
	}
	
	public void addReviewPhoto(ReviewPhoto reviewPhoto) {
		this.reviewPhotos.add(reviewPhoto);
	}
}
