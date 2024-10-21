package com.example.demo.commonController;

import com.example.demo.service.StoreService2;
import com.example.demo.vo.FavoriteStoreVO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "http://localhost:8080")
@RestController
@RequestMapping("/api/favorites")
public class FavoriteStoreController {

    @Autowired
    private StoreService2 storeService;

    @PostMapping
    public ResponseEntity<Void> addFavorite(@RequestBody String storeName) {
        boolean success = storeService.saveFavoriteStore(storeName); // 즐겨찾기 추가
        return success ? ResponseEntity.ok().build() : ResponseEntity.status(500).build();
    }

    @DeleteMapping
    public ResponseEntity<Void> removeFavorite(@RequestBody String json) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            FavoriteStoreVO favoriteStore = objectMapper.readValue(json, FavoriteStoreVO.class);
            boolean success = storeService.removeFavoriteStore(favoriteStore.getStoreName());
            return success ? ResponseEntity.ok().build() : ResponseEntity.status(500).build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build();
        }
    }
}
