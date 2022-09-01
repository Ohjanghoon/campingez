package com.kh.campingez.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.mypage.model.dao.MypageDao;
import com.kh.campingez.user.model.dao.UserInfoDao;
import com.kh.campingez.user.model.dto.User;

@Service
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	private UserInfoDao userInfoDao;
	
	
	@Override
	public int profileUpdate(User user) {
		return userInfoDao.profileUpdate(user);
	}
}
