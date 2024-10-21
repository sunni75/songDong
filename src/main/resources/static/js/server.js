const express = require('express');
const oracledb = require('oracledb');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

const dbConfig = {
    user: 'bbs', // 사용자 이름
    password: 'bbs', // 비밀번호
    connectString: '192.168.30.10:1521/XE' // 연결 문자열
};

// 즐겨찾기 추가
app.post('/api/favorites', async (req, res) => {
    const { storeName } = req.body;

    if (!storeName) {
        return res.status(400).json({ message: '가게 이름이 필요합니다.' });
    }

    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        // 즐겨찾기 추가 쿼리
        await connection.execute(
            `MERGE INTO FAVORITE_STORES dst
            USING (SELECT :storeName AS STORE_NAME FROM dual) src
            ON (dst.STORE_NAME = src.STORE_NAME)
            WHEN MATCHED THEN
                UPDATE SET COUNT = COUNT + 1
            WHEN NOT MATCHED THEN
                INSERT (STORE_NAME, COUNT) VALUES (src.STORE_NAME, 1);`,
            { storeName }
        );

        await connection.commit();
        res.status(201).json({ message: '즐겨찾기 추가됨' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: '오류 발생' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// 즐겨찾기 목록 조회
app.get('/api/favorites', async (req, res) => {
    let connection;

    try {
        connection = await oracledb.getConnection(dbConfig);

        const result = await connection.execute(
            `SELECT STORE_NAME, COUNT
            FROM FAVORITE_STORES
            ORDER BY COUNT DESC`
        );

        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: '오류 발생' });
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// 서버 시작
app.listen(8080, () => {
    console.log('서버가 포트 8080에서 실행 중');
});

