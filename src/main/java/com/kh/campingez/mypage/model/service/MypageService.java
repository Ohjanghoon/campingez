package com.kh.campingez.mypage.model.service;

import com.kh.campingez.user.model.dto.User;

public interface MypageService {

	User selectUserInfo(String userId);

	int profileUpdate(User user);



}
