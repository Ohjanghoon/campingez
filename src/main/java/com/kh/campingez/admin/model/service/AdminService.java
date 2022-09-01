package com.kh.campingez.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.user.model.dto.User;

public interface AdminService {

	List<User> findAllUserList(Map<String, Object> param);

	int getTotalContent();

	int updateWarningToUser(String userId);

	List<User> selectUserByKeyword(Map<String, Object> param);

	int getTotalContentByKeyword(Map<String, Object> param);

	User findUserByUserId(String userId);

	List<Inquire> findAllInquireList();

	int enrollAnswer(Answer answer);

	int deleteAnswer(Answer answer);

	int updateAnswer(Answer answer);

}
