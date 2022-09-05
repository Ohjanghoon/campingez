package com.kh.campingez.review.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewPhoto {
	private int revPhotoNo;
	private int revId;
	private String revOriginalFilename;
	private String revRenamedFilename;
}
