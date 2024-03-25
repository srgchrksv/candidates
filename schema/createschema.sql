
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";


CREATE TABLE "dim_date" (
  "date" DATE PRIMARY KEY ,
  "day" INT,
  "month" INT,
  "year" INT
);

CREATE TABLE "dim_interview_status" (
  "interview_status_id" INT PRIMARY KEY,
  "interview_status" VARCHAR(10)
);

CREATE TABLE "dim_user" (
  "user_id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "name" VARCHAR(50),
  "document_id" VARCHAR(50)
);

CREATE TABLE "dim_document" (
  "document_id" VARCHAR(50) PRIMARY KEY,
  "document_expiry_date" DATE
);

CREATE TABLE "fact_interviews" (
  "interview_id" UUID PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "interview_status_id" INT,
  "user_id" UUID
);

ALTER TABLE "dim_user" ADD FOREIGN KEY ("document_id") REFERENCES "dim_document" ("document_id");

ALTER TABLE "dim_document" ADD FOREIGN KEY ("document_expiry_date") REFERENCES "dim_date" ("date");

ALTER TABLE "fact_interviews" ADD FOREIGN KEY ("interview_status_id") REFERENCES "dim_interview_status" ("interview_status_id");

ALTER TABLE "fact_interviews" ADD FOREIGN KEY ("user_id") REFERENCES "dim_user" ("user_id");


INSERT INTO dim_interview_status (interview_status_id, interview_status) VALUES 
(1, 'Pending'),
(2, 'Passed'),
(3, 'Failed');
