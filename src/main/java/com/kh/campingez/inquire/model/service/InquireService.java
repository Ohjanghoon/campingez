package com.kh.campingez.inquire.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

public interface InquireService {

	List<Inquire> selectInquireList(Map<String, Integer> param);

	Inquire selectInquire(String inqNo);

	int insertInquire(InquireEntity inquire);

	int updateInquire(Inquire inquire);

	int deleteInquire(String inqNo);

	int getTotalContent();

}
