package com.kh.campingez.inquire.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.inquire.model.dao.InquireDao;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.inquire.model.dto.InquireEntity;

@Service
@Transactional
public class InquireServiceImpl implements InquireService {

	@Autowired
	InquireDao inquireDao;
	
	@Override
	public List<Inquire> selectInquireList(Map<String, Integer> param) {
		int limit = param.get("limit");
        int offset = (param.get("cPage")- 1) * limit;
        RowBounds rowBounds = new RowBounds(offset, limit);
		
		return inquireDao.selectInquireList(rowBounds);
	}
	
	@Override
	public int getTotalContent() {
		return inquireDao.getTotalContent();
	}
	
	@Override
	public Inquire selectInquire(String inqNo) {
		return inquireDao.selectInquire(inqNo);
	}
	
	@Override
	public int insertInquire(InquireEntity inquire) {
		return inquireDao.insertInquire(inquire);
	}
	
	@Override
	public int updateInquire(Inquire inquire) {
		int result = inquireDao.updateInquire(inquire);
		
		String inqNo = inquire.getInqNo();
		
		return inquireDao.deleteAnswer(inqNo);
	}
	
	@Override
	public int deleteInquire(String inqNo) {
		return inquireDao.deleteInquire(inqNo);
	}
}
