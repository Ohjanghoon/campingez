package com.kh.campingez.alarm.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.kh.campingez.alarm.model.dto.Alarm;
import com.kh.campingez.alarm.model.dto.AlarmEntity;

import lombok.NonNull;

public interface AlarmDao {
	
	@Insert("insert into alarm values(seq_alarm_alr_id.nextval, null, #{targetUserId}, #{alrContentId}, #{alrType}, #{alrMessage}, #{alrUrl}, default, null)")
	@SelectKey(statement = "select seq_alarm_alr_id.currval from dual", before = false, resultType = Integer.class, keyProperty = "alrId")
	int insertAlarmWithContentId(AlarmEntity alarm);

	@Select("select * from alarm where alr_id = #{alrId}")
	Alarm selectAlarmByAlrId(@NonNull int alrId);
	
	@Select("select * from alarm where target_user_id = #{userId} order by (case when alr_read_datetime is null then 1 end), alr_datetime desc")
	List<Alarm> getAlarmListByUser(String userId);
	
	@Update("update alarm set alr_read_datetime = sysdate where alr_id = #{alrId}")
	int updateAlarm(int alrId);
	
	@Select("select count(*) from alarm where target_user_id = #{userId} and alr_read_datetime is null")
	int getNotReadCount(String userId);
	
	@Insert("insert into alarm values(seq_alarm_alr_id.nextval, null, #{targetUserId}, null, #{alrType}, #{alrMessage}, #{alrUrl}, default, null)")
	@SelectKey(statement = "select seq_alarm_alr_id.currval from dual", before = false, resultType = Integer.class, keyProperty = "alrId")
	int insertAlarmWithoutContentId(AlarmEntity alarm);
	
	@Insert("insert into alarm values(seq_alarm_alr_id.nextval, null, #{targetUserId}, null, #{alrType}, #{alrMessage}, null, default, null)")
	@SelectKey(statement = "select seq_alarm_alr_id.currval from dual", before = false, resultType = Integer.class, keyProperty = "alrId")
	int insertAlarmWithoutContentIdAndUrl(AlarmEntity reportUserAlarm);

}
