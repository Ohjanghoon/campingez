package com.kh.campingez.campzone.model.dto;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class CampZone extends CampZoneEntity {

	private List<CampPhoto> campPhotos = new ArrayList<>();
	
	public CampZone(String zoneCode, String zoneName, String[] zoneInfo, int zoneMaximum, int zonePrice, List<CampPhoto> campPhotos) {
		super(zoneCode, zoneName, zoneInfo, zoneMaximum, zonePrice);
		this.campPhotos = campPhotos;
	}
	
	public void campPhotoAdd(CampPhoto photo) {
		this.campPhotos.add(photo);
	}
}
