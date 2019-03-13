/*
# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.35)
# Database: golang123
# Generation Time: 2018-04-12 15:52:36 +0000
# ************************************************************
*/

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS article_category;

CREATE TABLE article_category (
  id serial NOT NULL,
  article_id bigint NOT NULL,
  category_id bigint NULL,
  PRIMARY KEY (id)
);


DROP TABLE IF EXISTS articles;

CREATE TABLE articles (
  id serial NOT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  browse_count  bigint NOT NULL DEFAULT '0',
  comment_count bigint NOT NULL DEFAULT '0',
  collect_count bigint NOT NULL DEFAULT '0',
  status bigint NOT NULL,
  content text,
  html_content text,
  content_type bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  last_comment_at timestamp DEFAULT NULL,
  user_id bigint NOT NULL,
  last_user_id bigint DEFAULT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS book_categories;

CREATE TABLE book_categories (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  sequence bigint NOT NULL,
  parent_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS book_category;

CREATE TABLE book_category (
  id serial NOT NULL,
  book_id bigint NOT NULL,
  book_category_id bigint NOT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS book_chapter_comments;

CREATE TABLE book_chapter_comments (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  status varchar(100) NOT NULL DEFAULT '',
  content text,
  html_content text,
  content_type bigint NOT NULL,
  parent_id bigint NOT NULL,
  book_id bigint NOT NULL,
  chapter_id bigint NOT NULL,
  user_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS book_chapters;

CREATE TABLE book_chapters (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  browse_count  bigint NOT NULL,
  comment_count bigint  NOT NULL,
  content text,
  html_content text,
  content_type bigint NOT NULL,
  user_id bigint NOT NULL,
  parent_id bigint NOT NULL,
  book_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS book_comments;

CREATE TABLE book_comments (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  status varchar(100) NOT NULL DEFAULT '',
  star bigint NOT NULL,
  content text,
  html_content text,
  content_type bigint NOT NULL,
  parent_id bigint NOT NULL,
  book_id bigint NOT NULL,
  user_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS books;

CREATE TABLE books (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  cover_url varchar(200) DEFAULT NULL,
  browse_count bigint NOT NULL,
  comment_count bigint NOT NULL,
  collect_count bigint NOT NULL,
  status varchar(100) NOT NULL DEFAULT '',
  read_limits varchar(100) NOT NULL DEFAULT '',
  content text,
  html_content text,
  content_type bigint NOT NULL,
  user_id bigint NOT NULL,
  star bigint NOT NULL,
  one_star_count bigint NOT NULL,
  two_star_count bigint NOT NULL,
  three_star_count bigint NOT NULL,
  four_star_count bigint NOT NULL,
  five_star_count bigint NOT NULL,
  total_star_count bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS careers;

CREATE TABLE careers (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  company varchar(200) NOT NULL DEFAULT '',
  title varchar(200) NOT NULL DEFAULT '',
  user_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
  id serial NOT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  sequence bigint NOT NULL,
  parent_id bigint NOT NULL DEFAULT '0',
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS collects;

CREATE TABLE collects (
  id serial NOT NULL,
  user_id bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  source_id bigint NOT NULL,
  source_name varchar(100) NOT NULL DEFAULT '',
  folder_id bigint NOT NULL,
  PRIMARY KEY (id)
);





DROP TABLE IF EXISTS comments;

CREATE TABLE comments (
  id serial NOT NULL,
  content text,
  html_content text,
  content_type bigint NOT NULL,
  parent_id bigint NOT NULL DEFAULT '0',
  status bigint NOT NULL,
  ups bigint NOT NULL DEFAULT '0',
  source_id bigint NOT NULL,
  source_name varchar(100) NOT NULL,
  user_id bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS crawler_articles;

CREATE TABLE crawler_articles (
  id serial NOT NULL,
  title varchar(500) NOT NULL DEFAULT '',
  content text NOT NULL,
  url varchar(4000) NOT NULL,
  "from" bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  article_id bigint NOT NULL,
  PRIMARY KEY (id)
);





DROP TABLE IF EXISTS folders;

CREATE TABLE folders (
  id serial NOT NULL,
  user_id bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  name varchar(200) NOT NULL DEFAULT '', /* 收藏夹名称 */
  parent_id bigint NOT NULL,  /* 父收藏夹, 0表示无父收藏夹 */
  PRIMARY KEY (id)
);





DROP TABLE IF EXISTS images;

CREATE TABLE images (
  id serial NOT NULL,
  url varchar(200) NOT NULL DEFAULT '',
  width bigint DEFAULT NULL,
  height bigint DEFAULT NULL,
  mime varchar(20) NOT NULL DEFAULT '',
  title varchar(100) NOT NULL DEFAULT '',
  orignal_title varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS key_value_configs;

CREATE TABLE key_value_configs (
  id serial NOT NULL,
  key_name varchar(100) NOT NULL DEFAULT '',
  value varchar(500) NOT NULL DEFAULT '',
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS messages;

CREATE TABLE messages (
  id serial NOT NULL,
  from_user_id bigint NOT NULL,
  to_user_id bigint NOT NULL,
  source_id bigint NOT NULL,
  source_name varchar(100) NOT NULL DEFAULT '',
  comment_id bigint DEFAULT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  readed boolean NOT NULL,
  type varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS schools;

CREATE TABLE schools (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  speciality varchar(200) NOT NULL DEFAULT '',
  user_id bigint NOT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS top_articles;

CREATE TABLE top_articles (
  id serial NOT NULL,
  article_id bigint NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS ups;

CREATE TABLE ups (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  target_id bigint NOT NULL, /* 文章id或评论id */
  type bigint NOT NULL,  /* 1:为文章点赞;2:为评论点赞 */
  user_id bigint NOT NULL,
  PRIMARY KEY (id)
);



DROP TABLE IF EXISTS user_votes;

CREATE TABLE user_votes (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  user_id bigint NOT NULL,
  vote_id bigint NOT NULL,
  vote_item_id bigint NOT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id serial NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  activated_at timestamp DEFAULT NULL,
  name varchar(100) NOT NULL DEFAULT '',
  email varchar(50) DEFAULT '',
  phone varchar(50) DEFAULT NULL,
  pass varchar(100) NOT NULL DEFAULT '',
  score bigint NOT NULL,
  article_count bigint NOT NULL DEFAULT '0',
  collect_count bigint NOT NULL DEFAULT '0',
  signature varchar(200) DEFAULT NULL,
  role bigint NOT NULL,
  status bigint NOT NULL,
  avatar_url varchar(500) NOT NULL DEFAULT '',
  cover_url varchar(500) DEFAULT NULL,
  comment_count bigint NOT NULL,
  sex smallint NOT NULL DEFAULT '0',
  location varchar(200) DEFAULT NULL,
  introduce varchar(500) DEFAULT NULL,
  PRIMARY KEY (id)
);




DROP TABLE IF EXISTS vote_items;

CREATE TABLE vote_items (
  id serial NOT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  count bigint NOT NULL DEFAULT '0',
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  vote_id bigint NOT NULL,
  PRIMARY KEY (id)
);





DROP TABLE IF EXISTS votes;

CREATE TABLE votes (
  id  serial NOT NULL,
  name varchar(200) NOT NULL DEFAULT '',
  browse_count bigint NOT NULL DEFAULT '0',
  comment_count bigint NOT NULL DEFAULT '0',
  collect_count bigint NOT NULL DEFAULT '0',
  status bigint NOT NULL,
  content text,
  html_content text,
  content_type bigint NOT NULL,
  end_at timestamp NOT NULL,
  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL,
  deleted_at timestamp DEFAULT NULL,
  last_comment_at timestamp DEFAULT NULL,
  user_id bigint NOT NULL,
  last_user_id bigint DEFAULT NULL,
  PRIMARY KEY (id)
);



INSERT INTO users (
  created_at,
  updated_at,
  deleted_at,
  name,
  pass,
  email,
  sex,
  location,
  introduce,
  phone,
  score,
  article_count,
  comment_count,
  collect_count,
  signature,
  role,
  avatar_url,
  cover_url,
  status
) VALUES (
  now(),
  now(),
  NULL,
  'golang123',
  '1520046516c8c86ea21899d7392ed8d21e47d501c7',
  '',
  '0',
  '',
  '',
  '',
  '0',
  '0',
  '0',
  '0',
  '',
  '3',
  '/images/avatar/1.png',
  '',
  '2'
);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
