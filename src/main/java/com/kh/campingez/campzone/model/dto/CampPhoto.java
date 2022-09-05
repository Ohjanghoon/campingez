package com.kh.campingez.campzone.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CampPhoto {
	private int zonePhotoNo;
	private String zoneCode;
	private String originalFilename;
	private String renamedFilename;
	
	public CampPhoto(String originalFilename, String renamedFilename) {
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
	}
}
