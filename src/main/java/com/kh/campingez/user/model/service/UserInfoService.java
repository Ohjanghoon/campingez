package com.kh.campingez.user.model.service;

import java.util.List;

import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.user.model.dto.User;

public interface UserInfoService {

	int profileUpdate(User user);

	int profileDelete(User user);

	List<Inquire> selectInquireList(User user);
}
