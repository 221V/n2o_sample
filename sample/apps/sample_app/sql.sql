
CREATE TABLE "test_table" (
  "id" serial NOT NULL,
  "title" varchar(255) NOT NULL DEFAULT '',
  "text" TEXT NOT NULL DEFAULT '',
  "status" smallint NOT NULL DEFAULT 1,
  "inserted_at" TIMESTAMP NOT NULL,
  "updated_at" TIMESTAMP NOT NULL,
--  "updated_at" TIMESTAMP NOT NULL DEFAULT LOCALTIMESTAMP(0),
  PRIMARY KEY ("id")
);
ALTER SEQUENCE test_table_id_seq RESTART WITH 701;

INSERT INTO "test_table" (title, text, inserted_at, updated_at) VALUES ('test1', 'test text 1', LOCALTIMESTAMP(0), LOCALTIMESTAMP(0));
INSERT INTO "test_table" (title, text, inserted_at, updated_at) VALUES ('test2', 'test text 2', LOCALTIMESTAMP(0), LOCALTIMESTAMP(0));
INSERT INTO "test_table" (title, text, inserted_at, updated_at) VALUES ('тест3', 'test текст 3 лол', LOCALTIMESTAMP(0), LOCALTIMESTAMP(0));


