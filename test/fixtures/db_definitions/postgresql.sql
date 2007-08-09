CREATE TABLE "people" (
  "id" SERIAL,
  "name" varchar(255),
  "email" varchar(255),
	"age" int,
  PRIMARY KEY  ("id")
);
CREATE TABLE "addresses" (
  "id" SERIAL,
	"person_id" int,
  "address" varchar(255),
  PRIMARY KEY  ("id")
);
