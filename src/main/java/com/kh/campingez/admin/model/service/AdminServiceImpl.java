package com.kh.campingez.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.admin.model.dao.AdminDao;
import com.kh.campingez.user.model.dto.User;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDao adminDao;
	
	@Override
	public List<User> findAllUserList(Map<String, Object> param) {
		return adminDao.findAllUserList(getRowBounds(param));
	}
	
	@Override
	public int getTotalContent() {
		return adminDao.getTotalContent();
	}
	
	@Override
	public int updateWarningToUser(String userId) {
		log.debug("userId@service = {}", userId);
		return adminDao.updateWarningToUser(userId);
	}
	
	@Override
	public List<User> selectUserByKeyword(Map<String, Object> param) {
		RowBounds rowBounds = getRowBounds(param);
		
		return adminDao.selectUserByKeyword(rowBounds, param);
	}

	private RowBounds getRowBounds(Map<String, Object> param) {
		int limit = (int)param.get("limit");
		int offset = ((int)param.get("cPage") - 1) * limit;
		
		return new RowBounds(offset, limit);
	}
	
	
}
