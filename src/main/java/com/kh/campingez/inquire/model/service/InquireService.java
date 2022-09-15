package com.kh.campingez.inquire.model.service;

import java.util.List;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

public interface InquireService {

	List<Inquire> selectInquireList();

	Inquire selectInquire(String inqNo);

	int insertInquire(InquireEntity inquire);

	int updateInquire(Inquire inquire);

	int deleteInquire(String inqNo);

	int getTotalContent();

}
