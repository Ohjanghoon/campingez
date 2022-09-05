package com.kh.campingez.user.model.service;

import com.kh.campingez.user.model.dto.User;

public interface UserService {

	int insertUser(User user);

	int insertAuthority(String userId);

	int checkId(String userId);


}
