package com.kh.campingez.review.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
public class ReviewPhoto {
	private int revPhotoNo;
	private int revId;
	@NonNull
	private String revOriginalFilename;
	@NonNull
	private String revRenamedFilename;
}
