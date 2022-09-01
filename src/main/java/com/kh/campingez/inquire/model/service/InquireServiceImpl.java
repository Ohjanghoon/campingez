package com.kh.campingez.inquire.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.inquire.model.dao.InquireDao;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

@Service
public class InquireServiceImpl implements InquireService {

	@Autowired
	InquireDao inquireDao;
	
	@Override
	public List<Inquire> selectInquireList() {
		return inquireDao.selectInquireList();
	}
	
	@Override
	public Inquire selectInquire(String no) {
		return inquireDao.selectInquire(no);
	}
	
	@Override
	public int insertInquire(InquireEntity inquire) {
		return inquireDao.insertInquire(inquire);
	}
}
