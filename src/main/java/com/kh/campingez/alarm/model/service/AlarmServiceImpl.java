package com.kh.campingez.alarm.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.kh.campingez.alarm.model.dao.AlarmDao;
import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.alarm.model.dto.AlarmEntity;
import com.kh.campingez.alarm.model.dto.AlarmType;
import com.kh.campingez.inquire.model.dao.InquireDao;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	AlarmDao alarmDao;
	
	@Autowired
	InquireDao inquireDao;
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	@Override
	public int inquireAnswerAlarm(Map<String, Object> param) {
		Answer answer = (Answer)param.get("answer");
		Inquire inq = inquireDao.selectInquire(answer.getInqNo());
		String msg = "[문의답변] '" + inq.getInqTitle() + "'에 대한 답변이 등록되었습니다."; 
		
		AlarmEntity alarm = AlarmEntity.builder()
						.targetUserId(inq.getInqWriter())
						.alrContentId(answer.getInqNo())
						.alrType(AlarmType.INQUIRE)
						.alrMessage(msg)
						.alrUrl((String)param.get("location")).build();
		int result = alarmDao.inquireAnswerAlarm(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + alarm.getTargetUserId(), alarm);
		return result;
	}
	
	@Override
	public List<Alarm> getAlarmListByUser(String userId) {
		return alarmDao.getAlarmListByUser(userId);
	}
	
	@Override
	public int updateAlarm(int alrId) {
		return alarmDao.updateAlarm(alrId);
	}
	
	@Override
	public int getNotReadCount(String userId) {
		return alarmDao.getNotReadCount(userId);
	}
}
