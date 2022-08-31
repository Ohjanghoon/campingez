package com.kh.campingez.user.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.user.model.dao.UserDao;
import com.kh.campingez.user.model.dto.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public int insertUser(User user) {
		return userDao.insertUser(user);
	}
	
	@Override
	public int insertAuthority(String userId) {
		return userDao.insertAuthority(userId);
	}
}
