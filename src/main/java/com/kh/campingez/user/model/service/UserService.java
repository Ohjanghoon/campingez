package com.kh.campingez.user.model.service;

import java.util.Map;

import com.kh.campingez.user.model.dto.User;

public interface UserService {

	int insertUser(User user);

	int insertAuthority(String userId);

	int checkId(String userId);

	User findUserId(String name, String phone);

	User findUserPassword(String userId, String phone, String email);

	int updatePassword(String encodedPassword, String userId);

	int userUseCoupon(Map<Object, Object> map);

	int userUsePoint(Map<Object, Object> map);

}
