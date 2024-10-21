package com.example.demo.mapper;

import com.example.demo.vo.StoreInfoVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;

@Mapper
public interface StoreInfoMapper {

    void insertItems(HashMap<String, Object> item);

    List<StoreInfoVO> selList();
    
    //해쉬맵 넣기
    List<HashMap<String, Object>> selectShopByShopName(String keyword);

}
