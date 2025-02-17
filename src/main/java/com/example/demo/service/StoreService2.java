package com.example.demo.service;

import java.util.List;

import com.example.demo.vo.StoreInfoVO;

public interface StoreService2 {
	List<StoreInfoVO> getAllStores();
	
	boolean saveFavoriteStore(String storeName); // 즐겨찾기 저장 메서드 추가
	
	boolean removeFavoriteStore(String storeName); // 즐겨찾기 삭제 메서드 추가
	
}
