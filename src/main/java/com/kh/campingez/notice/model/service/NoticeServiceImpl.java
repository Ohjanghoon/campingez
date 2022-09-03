package com.kh.campingez.notice.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.notice.model.dao.NoticeDao;
import com.kh.campingez.notice.model.dto.Notice;
import com.kh.campingez.notice.model.dto.NoticePhoto;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Override
	public List<Notice> noticeList(Map<String, Integer> param) {
		int limit = param.get("limit");
		int offset = (param.get("cPage") - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return noticeDao.noticeList(rowBounds);
	}
	
	@Override
	public int getTotalContent() {
		return noticeDao.getTotalContent();
	}
	
	@Override
	public Notice selectByNoticeNo(String noticeNo) {
		return noticeDao.selectByNoticeNo(noticeNo);
	}
	
	@Override
	public int deleteNotice(String noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}
	
	@Override
	public NoticePhoto selectByPhotoNo(int noticePhotoNo) {
		return noticeDao.selectByPhotoNo(noticePhotoNo);
	}
	
	@Override
	public int deletePhoto(int noticePhotoNo) {
		return noticeDao.deletePhoto(noticePhotoNo);
	}
	
	@Override
	public int updateNotice(Notice notice) {
		// update
		int result = noticeDao.updateNotice(notice);
		
		// insert
		List<NoticePhoto> photos = notice.getPhotos();
		if (photos != null && !photos.isEmpty()) {
			for (NoticePhoto photo : photos) {
				result = noticeDao.insertPhoto(photo);
			}
		}

		return result;
	}
}
