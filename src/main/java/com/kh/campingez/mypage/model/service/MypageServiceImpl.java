package com.kh.campingez.mypage.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.mypage.model.dao.MypageDao;
import com.kh.campingez.user.model.dto.User;

@Service
public class MypageServiceImpl implements MypageService{

	@Autowired
	private MypageDao mypageDao;
	
	@Override
	public User selectUserInfo(String userId) {
		return mypageDao.selectUserInfo(userId);
	}
	@Override
	public int profileUpdate(User user) {
		return mypageDao.profileUpdate(user);
	}
}
