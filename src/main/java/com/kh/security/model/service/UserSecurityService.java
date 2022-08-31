package com.kh.security.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.campingez.user.model.dto.User;
import com.kh.security.model.dao.UserSecurityDao;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserSecurityService implements UserDetailsService {

	@Autowired
	UserSecurityDao userSecurityDao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userSecurityDao.loadUserByUsername(username);
		if(user == null) {
			throw new UsernameNotFoundException(username);
		}
		log.info("user = {}" , user);
		return user;
	}

}
