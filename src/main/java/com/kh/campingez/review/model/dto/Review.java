package com.kh.campingez.review.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import com.kh.campingez.user.model.dto.User;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import com.kh.campingez.reservation.model.dto.Reservation;
import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Review extends ReviewEntity {
	private Reservation reservation;
	private List<ReviewPhoto> reviewPhotos = new ArrayList<>();
	private String zoneCode;
	private String userName;
	
	public Review(int revId, String resNo, String revContent, int revScore, LocalDateTime revEnrollDate, Reservation reservation, List<ReviewPhoto> reviewPhotos, String zoneCode, String userName) {
		super(revId, resNo, revContent, revScore, revEnrollDate);
		this.reservation = reservation;
		this.reviewPhotos = reviewPhotos;
		this.zoneCode = zoneCode;
		this.userName = userName;
	}
	
	public void addReviewPhoto(ReviewPhoto reviewPhoto) {
		this.reviewPhotos.add(reviewPhoto);
	}

}
