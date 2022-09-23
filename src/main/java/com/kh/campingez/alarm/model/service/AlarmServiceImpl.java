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
import com.kh.campingez.assignment.model.dao.AssignmentDao;
import com.kh.campingez.assignment.model.dto.Assignment;
import com.kh.campingez.community.model.dao.CommunityDao;
import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.inquire.model.dao.InquireDao;
import com.kh.campingez.inquire.model.dto.Answer;
import com.kh.campingez.inquire.model.dto.Inquire;
import com.kh.campingez.trade.model.dao.TradeDao;
import com.kh.campingez.trade.model.dto.Trade;

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
	
	@Autowired
	AssignmentDao assignmentDao;
	
	@Autowired
	CommunityDao communityDao;
	
	@Autowired
	TradeDao tradeDao;
	
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
		int result = alarmDao.insertAlarmWithContentId(alarm);
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
		int result = alarmDao.insertAlarmWithoutContentId(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		int notReadCount = alarmDao.getNotReadCount(targetUserId);
		log.debug("alarm = {}", alarm);
		Map<String, Object> map = new HashMap<>();
		map.put("alarm", alarm);
		map.put("notReadCount", notReadCount);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + targetUserId, map);
		
		return result;
	}
	
	@Override
	public int cancelWarningToUserAlarm(String userId, boolean isBlack) {
		String msg = null;
		if(isBlack) {
			msg = "[블랙리스트 해지] 문의 주신 내용 반영하여 블랙리스트 해지처리 하였습니다.🙂";
		} else {
			msg = "[경고취소] 문의 주신 내용 반영하여 경고 취소처리 되셨습니다.🙂";			
		}
		
		AlarmEntity alarm = (AlarmEntity)Alarm.builder()
						.targetUserId(userId)
						.alrType(AlarmType.REPORT)
						.alrMessage(msg).build();
		int result = alarmDao.insertAlarmWithoutContentIdAndUrl(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		int notReadCount = alarmDao.getNotReadCount(userId);
		
		Map<String, Object> map = new HashMap<>();
		map.put("alarm", alarm);
		map.put("notReadCount", notReadCount);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + userId, map);
		
		return result;
	}
	
	@Override
	public int commReportAlarm(Map<String, Object> param) {
		String type = (String)param.get("type");
		String commNo = (String)param.get("commNo");
		
		Trade trade = null;
		Community community = null;
		String title = null;
		String commWriter = null;
		// 중고거래인 경우
		if(String.valueOf('T').equals(type)) {
			trade = tradeDao.selectTradeByNo(commNo);
			title = trade.getTradeTitle();
			commWriter = trade.getUserId();
		}
		// 커뮤니티인 경우
		else {
			community = communityDao.selectCommByNo(commNo);
			title = community.getCommTitle();
			commWriter = community.getUserId();
		}
		
		// 게시글 작성자 알림
		String writerMsg = "[신고] '" + title + "' 게시글이 3회 이상 신고되어 삭제처리 되었습니다.";
		// 신고자 알림
		String reportUserMsg = "[신고조치] 신고해주신 '" + title + "' 게시글에 대한 조치를 취했습니다.🙂";
		
		// 신고자 리스트 조회
		List<String> reportUserList = adminDao.findReportUserListByCommNo(commNo);
		
		// 알림 테이블 추가
		// 게시글 작성자 알림
		AlarmEntity commWriterAlarm = (AlarmEntity)Alarm.builder()
							.targetUserId(commWriter)
							.alrContentId(commNo)
							.alrType(AlarmType.REPORT)
							.alrMessage(writerMsg).build();
		int result = alarmDao.insertAlarmWithoutContentIdAndUrl(commWriterAlarm);
		commWriterAlarm = alarmDao.selectAlarmByAlrId(commWriterAlarm.getAlrId());
		int commWriternotReadCount = alarmDao.getNotReadCount(commWriter);
		Map<String, Object> writerMap = new HashMap<>();
		writerMap.put("alarm", commWriterAlarm);
		writerMap.put("notReadCount", commWriternotReadCount);
		simpMessagingTemplate.convertAndSend("/app/notice/" + commWriter, writerMap);
		
		// 신고자 알림
		for(String user : reportUserList) {
			AlarmEntity reportUserAlarm = (AlarmEntity)Alarm.builder()
									.targetUserId(user)
									.alrType(AlarmType.REPORT)
									.alrMessage(reportUserMsg).build();
			result = alarmDao.insertAlarmWithoutContentIdAndUrl(reportUserAlarm);
			reportUserAlarm = alarmDao.selectAlarmByAlrId(reportUserAlarm.getAlrId());
			int reportUserNotReadCount = alarmDao.getNotReadCount(user);
			Map<String, Object> reportUserMap = new HashMap<>();
			reportUserMap.put("alarm", reportUserAlarm);
			reportUserMap.put("notReadCount", reportUserNotReadCount);
			simpMessagingTemplate.convertAndSend("/app/notice/" + user, reportUserMap);
		}
		return result;
	}
	
	@Override
	public void assignSuccessAlarm(String assignNo) {
		Assignment assignment = assignmentDao.selectOneAssignment(assignNo);
		
		String msg = "[양도완료] '" + assignment.getAssignTitle() + "' 게시글에 대한 양도가 완료되었습니다.";
		String location = "/assignment/assignmentDetail.do?assignNo=" + assignNo;
		
		AlarmEntity alarm = (AlarmEntity)Alarm.builder()
				.targetUserId(assignment.getUserId())
				.alrContentId(assignment.getAssignNo())
				.alrType(AlarmType.INQUIRE)
				.alrMessage(msg)
				.alrUrl(location).build();
		
		int result = alarmDao.insertAlarmWithContentId(alarm);
		alarm = alarmDao.selectAlarmByAlrId(alarm.getAlrId());
		int notReadCount = alarmDao.getNotReadCount(assignment.getUserId());
		
		Map<String, Object> map = new HashMap<>();
		map.put("alarm", alarm);
		map.put("notReadCount", notReadCount);
		
		simpMessagingTemplate.convertAndSend("/app/notice/" + alarm.getTargetUserId(), map);
	}
}
