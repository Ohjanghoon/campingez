package com.kh.campingez.user.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.campingez.user.model.dto.User;

@Mapper
public interface UserDao {

	int insertUser(User user);

	int insertAuthority(String userId);

}
