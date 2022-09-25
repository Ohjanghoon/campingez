package com.kh.campingez.alarm.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.community.model.dto.CommunityComment;
import com.kh.campingez.inquire.model.dto.Answer;

public interface AlarmService {

	int inquireAnswerAlarm(Map<String, Object> param);

	List<Alarm> getAlarmListByUser(String userId);

	int updateAlarm(int alrId);

	int getNotReadCount(String userId);

	int warningToUserAlarm(Map<String, Object> param);

	int commReportAlarm(Map<String, Object> param);

	int cancelWarningToUserAlarm(String userId, boolean isBlack);

	void assignSuccessAlarm(String assignNo);

	void commEnrollAlarm(CommunityComment cc);

	int deleteAlarm(int alrId);

	int allReadAlarm(String userId);

	int allDeleteAlarm(String userId);

}
