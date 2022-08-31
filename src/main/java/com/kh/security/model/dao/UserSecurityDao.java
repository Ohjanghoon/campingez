package com.kh.security.model.dao;

import com.kh.campingez.user.model.dto.User;

public interface UserSecurityDao {

	User loadUserByUsername(String username);

}
