package com.kh.campingez.alarm.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.campingez.admin.model.dao.AdminDao;
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
@Transactional(rollbackFor = Exception.class)
public class AlarmServiceImpl implements AlarmService {
	
	@Autowired
	AlarmDao alarmDao;
	
	@Autowired
	InquireDao inquireDao;
	
	@Autowired
	AdminDao adminDao;
	
	@Autowired
	SimpMessagingTemplate simpMessagingTemplate;
	
	@Override
	public int inquireAnswerAlarm(Map<String, Object> param) {
		Answer answer = (Answer)param.get("answer");
		Inquire inq = inquireDao.selectInquire(answer.getInqNo());
		String msg = "[문의답변] '" + inq.getInqTitle() + "'에 대한 답변이 등록되었습니다."; 
		
		AlarmEntity alarm = (AlarmEntity)Alarm.builder()
						.targetUserId(inq.getInqWriter())
						.alrContentId(answer.getInqNo())
						.alrType(AlarmType.INQUIRE)
						.alrMessage(msg)
						.alrUrl((String)param.get("location")).build();
		int result = alarmDao.inquireAnswerAlarm(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		int notReadCount = alarmDao.getNotReadCount(inq.getInqWriter());
		
		Map<String, Object> map = new HashMap<>();
		map.put("alarm", alarm);
		map.put("notReadCount", notReadCount);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + alarm.getTargetUserId(), map);
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
	
	@Override
	public int warningToUserAlarm(Map<String, Object> param) {
		String targetUserId = (String)param.get("userId");
		int yellowcard = adminDao.findUserByUserId(targetUserId).getYellowCard();
		
		String msg = null;
		
		if(yellowcard >= 3) {
			msg = "[블랙리스트 대상자 안내] '" + (String)param.get("reason") + "'(으)로 경고처리 되셨습니다.";
		} else {
			msg = "[" + yellowcard + "회 경고] '" + (String)param.get("reason") + "'(으)로 경고처리 되셨습니다.";
		}
		
		AlarmEntity alarm = (AlarmEntity)Alarm.builder()
					.targetUserId(targetUserId)
					.alrType(AlarmType.REPORT)
					.alrMessage(msg)
					.alrUrl((String)param.get("location")).build();
		int result = alarmDao.warnToUserAlarm(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		int notReadCount = alarmDao.getNotReadCount(targetUserId);
		log.debug("alarm = {}", alarm);
		Map<String, Object> map = new HashMap<>();
		map.put("alarm", alarm);
		map.put("notReadCount", notReadCount);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + targetUserId, map);
		
		return result;
	}
}
