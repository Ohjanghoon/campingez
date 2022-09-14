package com.kh.campingez.campzone.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.campzone.model.dao.CampZoneDao;
import com.kh.campingez.campzone.model.dto.CampZone;

@Service
public class CampZoneServiceImpl implements CampZoneService {

	@Autowired
	private CampZoneDao campDao;
	
	@Override
	public CampZone selectCampZone(String zoneCode) {
		return campDao.selectCampZone(zoneCode);
	}
}
