package com.kh.campingez.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.campingez.community.model.dto.Community;
import com.kh.campingez.community.model.dto.CommunityComment;
import com.kh.campingez.community.model.dto.CommunityLike;
import com.kh.campingez.community.model.dto.CommunityPhoto;


public interface CommunityService {

   List<Community> selectCommListFree(Map<String, Integer> param);
   
   List<Community> selectCommListHoney(Map<String, Integer> param);

   int getTotalContentFree();
   
   int getTotalContentHoney();

   Community selectCommByNo(String no);

   int getCommLike(CommunityLike cl);

   int updateReadCount(String no);
   
   void deleteCommLike(CommunityLike cl);

   void insertCommLike(CommunityLike cl);

   int insertComm(Community community);

   CommunityPhoto selectOnePhoto(int photoNo);

   int deletePhoto(int photoNo);

   int updateComm(Community community);

   int deleteComm(String no);

   void insertComment(CommunityComment cc);

   List<CommunityComment> selectCommentList(String commNo);

   int deleteComment(String commentNo);

   String getUserReportComm(Map<String, Object> param);

   List<Community> communityFind(Map<String, Integer> param, String categoryType, String searchType, String searchKeyword);

   int getFindTotalContent(String categoryType, String searchType, String searchKeyword);

String selectCommNoByCommentNo(String commentNo);
	

}