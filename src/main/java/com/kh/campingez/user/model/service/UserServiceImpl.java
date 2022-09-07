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
	
	@Override
	public int checkId(String userId) {
		return userDao.checkId(userId);
	}
	
	@Override
	public User findUserId(String name, String phone) {
		return userDao.findUserId(name, phone);
	}
	
	@Override
	public User findUserPassword(String userId, String phone, String email) {
		return userDao.findUserPassword(userId, phone, email);
	}
	
	@Override
	public int updatePassword(String encodedPassword, String userId) {
		return userDao.updatePassword(encodedPassword, userId);
	}
}
