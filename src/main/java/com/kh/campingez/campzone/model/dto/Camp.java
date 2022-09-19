package com.kh.campingez.campzone.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@ToString(callSuper = true)
public class Camp extends CampEntity {
	private String zoneName;

	public Camp(String campId, String zoneCode, String zoneName) {
		super(campId, zoneCode);
		this.zoneName = zoneName;
	}
}
