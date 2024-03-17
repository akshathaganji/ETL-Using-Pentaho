/* Initialize DB. This must be done ONLY ONCE. It will delete the existing data otherwise */

DROP DATABASE IF EXISTS crm;

CREATE DATABASE crm CHARACTER SET utf8mb4;

USE crm;

DROP TABLE IF EXISTS src_linkedin;

CREATE TABLE src_linkedin (
  linkedin_public_id varchar(100) NOT NULL,
  profile_filename_full varchar(200),
  profile_filename_short varchar(200),
  process_status varchar(50) NOT NULL DEFAULT 'Requested',
  process_datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(linkedin_public_id)
);


-- insert a sample linkedin profile id
-- INSERT INTO src_linkedin (linkedin_public_id) VALUES ('LINKEDIN_PROFILE_ID_HERE');


DROP TABLE IF EXISTS profile_section;

CREATE TABLE profile_section (
  section_id INTEGER unsigned NOT NULL,
  section_name varchar(40) NOT NULL,
  last_modified_datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(section_id)
);

-- insert a new linkedin profile section
INSERT INTO profile_section (section_id, section_name) VALUES (1, 'profile-photo');


DROP TABLE IF EXISTS profile_section_log;

CREATE TABLE profile_section_log (
  linkedin_public_id varchar(100) NOT NULL,
  section_id INTEGER unsigned NOT NULL,
  process_status varchar(50) NOT NULL DEFAULT 'Requested',
  process_datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(linkedin_public_id, section_id),
  FOREIGN KEY (linkedin_public_id) REFERENCES src_linkedin(linkedin_public_id),
  FOREIGN KEY (section_id) REFERENCES profile_section(section_id)
);

DROP TABLE IF EXISTS profile_photo_url;
CREATE TABLE `profile_photo_url` (
  `linkedin_public_id` varchar(100) DEFAULT NULL,
  `profile_pic_url` varchar(400) DEFAULT NULL,
  FOREIGN KEY (linkedin_public_id) REFERENCES src_linkedin(linkedin_public_id)
);
