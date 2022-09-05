package com.kh.campingez.campzone.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CampZoneEntity {
	private String zoneCode;
	private String zoneName;
	private String[] zoneInfo;
	private int zoneMaximum;
	private int zonePrice;
}
