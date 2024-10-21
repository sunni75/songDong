package com.example.demo.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.StoreVO;
@Mapper
public interface StoreMapper {
	void insertStore(StoreVO storeVO);
	List<HashMap<String, Object>> selectAll();
	StoreVO selectOne(Long mgtNo);
	List<StoreVO> selectList(StoreVO e);
}
