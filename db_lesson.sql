-- Q1
CREATE TABLE departments (
department_id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- Q2
ALTER TABLE people
  ADD COLUMN department_id INT UNSIGNED NULL AFTER email;


-- Q3
-- 部署一覧追加
INSERT INTO departments (name)
VALUES ('営業'),
       ('開発'),
       ('経理'),
       ('人事'),
       ('情報システム');



-- 10人にするために5人を追加
INSERT INTO people (name,department_id)
VALUES ('佐藤さとう',1),
       ('鈴木すず',1),
       ('伊藤いと',1),
       ('浅井あさ',2);

INSERT INTO people (name,department_id)
VALUES ('吉良きら',2);
       

-- 1営業*3,2開発*4,3経理*1,4人事*1,6情シ*1
UPDATE people
SET  department_id = CASE person_id
    WHEN 1 THEN 2   -- 1のIDの人 → 開発
    WHEN 2 THEN 2   -- 2のidの人 → 開発
    WHEN 3 THEN 3   -- 3のidの人 → 経理
    WHEN 4 THEN 4   -- 4のidの人 → 人事
    WHEN 6 THEN 6   -- 6のidの人 → 情報システム
END
WHERE person_id IN (1,2,3,4,6);



-- 日報条件
-- 10件日報を作成、紐づけ、
INSERT INTO reports (person_id, content)
VALUES (1, '打ち合わせ'),
       (2, '整備'),
       (3, '経理処理'),
       (4, '人事評価制度'),
       (6, '情報システム'),
       (7, '営業チームと議論'),
       (8, '仕様書を作成'),
       (9, '請求書の発行作業'),
       (10, '面談'),
       (11, '改善案');
＋
UPDATE reports
SET content = CONCAT(content, 'について報告します。')
WHERE LENGTH(content) < 10;


-- 年齢降順、男性の名前と年齢の取得
SELECT name, age
FROM people
WHERE gender = '1'
ORDER BY age DESC;


-- 人数分の情報追加
UPDATE people SET age = 46, gender = 2 WHERE person_id = 7;
UPDATE people SET age = 54, gender = 2 WHERE person_id = 8;
UPDATE people SET age = 19, gender = 1 WHERE person_id = 9;
UPDATE people SET age = 34, gender = 1 WHERE person_id = 10;
UPDATE people SET age = 22, gender = 1 WHERE person_id = 11;


-- Q6 テーブル・レコード・カラムという3つの単語を適切に使用して、下記のSQL文を日本語で説明してください。
SELECT
  `name`, `email`, `age`　　3つのカラムだけを選択する
FROM
  `people`　　peopleのテーブルからデータを取得する
WHERE
  `department_id` = 1　　IDが1に該当するレコードだけにする
ORDER BY
  `created_at`;　　カラムを昇順にする


-- Q7 営業部に所属する人だけを年齢の昇順で取得してください。
SELECT name, gender, age
FROM people
WHERE (gender = '2' AND age BETWEEN 20 AND 29)
OR (gender = '1' AND age BETWEEN 40 AND 49);



-- Q8  営業部に所属する人だけを年齢の昇順で取得してください。
SELECT *
FROM  people
WHERE department_id = 1
ORDER BY age ASC;


-- Q9　開発部に所属している女性の平均年齢を取得してください。
SELECT AVG(age) AS average_age FROM people 
WHERE gender = '2' AND department_id  = '2';



-- Q10　名前と部署名とその人が提出した日報の内容を同時に取得してください。（日報を提出していない人は含めない）
SELECT p.name,d.name,r.content
FROM  people AS p
INNER JOIN  departments AS d ON p.department_id = d.department_id
INNER JOIN reports AS r ON p.person_id = r.person_id




-- Q11　日報を一つも提出していない人の名前一覧を取得してください。
SELECT p.name,d.name,r.content
FROM  people AS p
INNER JOIN  departments AS d ON p.department_id = d.department_id
left OUTER JOIN reports AS r ON p.person_id = r.person_id
where r.person_id is null; 



DELETE FROM reports
WHERE report_id = '20';


