package com.kh.campingez.campzone.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.campzone.model.dao.CampZoneDao;

@Service
public class CampZoneServiceImpl implements CampZoneService {

	@Autowired
	private CampZoneDao campDao;
	
	
}
