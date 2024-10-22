package com.example.demo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.StoreMapper2;
import com.example.demo.service.StoreService2;
import com.example.demo.vo.StoreInfoVO;


	@Service
	public class StoreService2Impl implements StoreService2 {

	    @Autowired
	    private StoreMapper2 storeMapper;

	    @Override
	    public List<StoreInfoVO> getAllStores() {
	        return storeMapper.getAllStores();
	    }
	    
	    @Override
	    public boolean saveFavoriteStore(String storeName) {
	        try {
	            storeMapper.insertFavoriteStore(storeName); // 매퍼에서 호출
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	    
	    @Override
	    public boolean removeFavoriteStore(String storeName) {
	        try {
	            storeMapper.deleteFavoriteStore(storeName); // 매퍼에서 호출
	            return true;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        }
	    }

	}

