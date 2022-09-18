package com.kh.campingez.assignment.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campingez.campzone.model.dto.CampPhoto;
import com.kh.campingez.reservation.model.dto.Reservation;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Assignment extends AssignmentEntity {

	private List<CampPhoto> campPhotos = new ArrayList<>();
	private Reservation reservation;
	
	public Assignment(String assignNo, String userId, String resNo, String assignTitle, String assignContent,
			int assignPrice, LocalDateTime assignDate, int assignLikeCount, AssignState assignState, String assignTransfer) {
		super(assignNo, userId, resNo, assignTitle, assignContent, assignPrice, assignDate, assignLikeCount, assignState, assignTransfer);
	}
	
	public void add(CampPhoto campPhoto) {
		this.campPhotos.add(campPhoto);
	}

}
