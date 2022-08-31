package com.kh.campingez.inquire.model.service;

import java.util.List;

import com.kh.campingez.inquire.model.dto.Inquire;

public interface InquireService {

	List<Inquire> selectInquireList();

	Inquire selectInquire(String no);

}
