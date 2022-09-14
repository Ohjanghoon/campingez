package com.kh.campingez.campzone.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.kh.campingez.campzone.model.dto.CampZone;

@Mapper
public interface CampZoneDao {

	@Select("select * from camp_zone where zone_code = #{zoneCode}")
	CampZone selectCampZone(String zoneCode);

}
