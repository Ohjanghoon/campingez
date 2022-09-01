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
	private String campPhotoNo;
	private String zoneCode;
	private String originaFileName;
	private String renamedFileName;
}
