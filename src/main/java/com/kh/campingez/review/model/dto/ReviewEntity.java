package com.kh.campingez.review.model.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewEntity {
	private int revId;
	private String resNo;
	private String revContent;
	private int revScore;
	private LocalDateTime revEnrollDate;
}
