package com.example.demo.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class FavoriteStoreVO {
    private String storeName;
    private int count; // 기본값 0으로 설정할 수 있음

}
