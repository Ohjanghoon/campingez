package com.kh.campingez.review.model.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.kh.campingez.user.model.dto.User;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Review extends ReviewEntity {

	private int attachCount;
	private User user;
	private List<ReviewPhoto> attachments = new ArrayList<>();

	public Review(int revId, String resNo,String revContent, int revScore, LocalDateTime revEnrollDate) {
		super(revId, resNo, revContent,  revScore, revEnrollDate);
		this.attachCount = attachCount;
	}
	
	public void add(ReviewPhoto photo) {
		this.attachments.add(photo);
	}
	
}
