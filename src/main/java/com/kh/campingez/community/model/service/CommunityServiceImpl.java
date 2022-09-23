package com.kh.campingez.community.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.campingez.community.model.dao.CommunityDao;
import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.community.model.dto.CommunityComment;
import com.kh.campingez.community.model.dto.CommunityLike;
import com.kh.campingez.community.model.dto.CommunityPhoto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommunityServiceImpl implements CommunityService {
   
   @Autowired
   CommunityDao communityDao;

   @Override
   public List<Community> selectCommList(Map<String, Integer> param) {
      int limit = param.get("limit");
      int offset = (param.get("cPage") - 1) * limit;
      RowBounds rowBounds = new RowBounds(offset, limit);
      return communityDao.selectCommList(rowBounds);
      
   }

   @Override
   public int getTotalContent() {
      return communityDao.getTotalContext();
   }

   @Override
   public Community selectCommByNo(String no) {

      Community community = communityDao.selectCommByNo(no);
      // List<CommunityPhoto> 조회
      
      List<CommunityPhoto> photos = communityDao.selectPhotoListByCommNo(no);
      community.setPhotos(photos);
      
      return community;

      

   }

   @Override
   public int getCommLike(CommunityLike cl) {
      return communityDao.getCommLike(cl);
   }

   @Override
   public int updateReadCount(String no) {
      Community community = communityDao.selectCommByNo(no);
      return communityDao.updateReadCount(community);
   }

   @Override
   public void deleteCommLike(CommunityLike cl) {
      communityDao.deleteCommLike(cl);
      communityDao.updateCommLike(cl.getLikeCommNo());
      
   }

   @Override
   public void insertCommLike(CommunityLike cl) {
      communityDao.insertCommLike(cl);
      communityDao.updateCommLike(cl.getLikeCommNo());
      
   }

   @Override
   public int insertComm(Community community) {
      int result = communityDao.insertComm(community);
      log.debug("community#commNo = {}", community.getCommNo());
      
      // insert attachment * n
      List<CommunityPhoto> photos = community.getPhotos();
      if(!photos.isEmpty()) {
         for(CommunityPhoto photo : photos) {
            photo.setCmNo(community.getCommNo());
            result = insertPhoto(photo);
         }
      }
      return result;
   }

   private int insertPhoto(CommunityPhoto photo) {
      return communityDao.insertPhoto(photo);
   }

   @Override
   public CommunityPhoto selectOnePhoto(int photoNo) {
      return communityDao.selectOnePhoto(photoNo);
   }

   @Override
   public int deletePhoto(int photoNo) {
      
      return communityDao.deletePhoto(photoNo);
   }

   @Override
   public int updateComm(Community community) {
      int result = communityDao.updateComm(community);
      
      List<CommunityPhoto> photos = community.getPhotos();
      if(photos != null && !photos.isEmpty()) {
         for(CommunityPhoto photo : photos) {
            result = insertPhoto(photo);
         }
      }
      
      return result;
   }

   @Override
   public int deleteComm(String no) {
      return communityDao.deleteComm(no);
   }

   @Override
	public void insertComment(CommunityComment cc) {
		communityDao.insertComment(cc);
		
	}

	@Override
	public List<CommunityComment> selectCommentList(String commNo) {
		
		return communityDao.selectCommentList(commNo);
	}

	@Override
	public int deleteComment(CommunityComment cc) {
		return communityDao.deleteComment(cc);
		
	}

	
	
   
   
}