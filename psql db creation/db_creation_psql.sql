-- for me

CREATE DATABASE messanger_data_base;
\c messanger_data_base


-- for project

CREATE TABLE IF NOT EXISTS public.user (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	personal_tag VARCHAR(50) UNIQUE NOT NULL,
	name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(50) UNIQUE NOT NULL,
	is_phone_hidden BOOL NOT NULL,
	email VARCHAR(50));

CREATE TABLE IF NOT EXISTS public.contact (
	user_id BIGSERIAL NOT NULL REFERENCES public.user(ID),
	contact_user_id BIGSERIAL NOT NULL REFERENCES public.user(ID),
	created TIMESTAMP NOT NULL,
	contact_name VARCHAR(50),
	is_blocked BOOL NOT NULL,
	PRIMARY KEY (user_id, contact_user_id));

CREATE TABLE IF NOT EXISTS public.device (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	number VARCHAR(50) NOT NULL UNIQUE,
	name VARCHAR(20),
	type VARCHAR(20) NOT NULL,
	company_name VARCHAR(20));

CREATE TABLE IF NOT EXISTS user_device (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	user_id BIGSERIAL NOT NULL REFERENCES public.user(ID),
	device_id BIGSERIAL NOT NULL REFERENCES public.device(ID),
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP,
	is_verified BOOL NOT NULL);
	
CREATE TABLE IF NOT EXISTS verification (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	code VARCHAR(10) NOT NULL,
	user_device_id BIGSERIAL NOT NULL REFERENCES user_device(id));

CREATE TABLE IF NOT EXISTS public.channel(
	id BIGSERIAL NOT NULL PRIMARY KEY,
	user_owner_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	channel_tag VARCHAR(10) NOT NULL UNIQUE,
	name VARCHAR(20) NOT NULL,
	description VARCHAR(20));

CREATE TABLE IF NOT EXISTS channel_subscribers (
	channel_id BIGSERIAL NOT NULL REFERENCES public.channel(id),
	subscriber_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	created TIMESTAMP NOT NULL,
	PRIMARY KEY (channel_id, subscriber_id));


CREATE TABLE IF NOT EXISTS public.post (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	channel_id BIGSERIAL NOT NULL REFERENCES public.channel(id),
	created TIMESTAMP NOT NULL,
	edited TIMESTAMP,
	text VARCHAR(100) NOT NULL);


CREATE TABLE IF NOT EXISTS public.comment(
	id BIGSERIAL NOT NULL PRIMARY KEY,
	post_id BIGSERIAL NOT NULL REFERENCES public.post(id),
	user_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	created TIMESTAMP NOT NULL,
	edited TIMESTAMP,
	text VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS public.bot (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	user_owner_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	created TIMESTAMP NOT NULL,
	edited TIMESTAMP,
	tag VARCHAR(10) NOT NULL UNIQUE,
	name VARCHAR(10) NOT NULL,
	description VARCHAR(30));

CREATE TABLE IF NOT EXISTS public.chat (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	updated TIMESTAMP NOT NULL,
	is_personal BOOL NOT NULL,
	user_owner_id BIGSERIAL REFERENCES public.user(id),
	name VARCHAR(10));

CREATE TABLE IF NOT EXISTS user_chat_member (
	created TIMESTAMP NOT NULL,
	chat_id BIGSERIAL NOT NULL REFERENCES public.chat(id),
	user_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	PRIMARY KEY (chat_id, user_id));

CREATE TABLE IF NOT EXISTS bot_chat_member (
	created TIMESTAMP NOT NULL,
	chat_id BIGSERIAL NOT NULL REFERENCES public.chat(id),
	bot_id BIGSERIAL NOT NULL REFERENCES public.bot(id),
	PRIMARY KEY (chat_id, bot_id));

CREATE TABLE IF NOT EXISTS user_message (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	edited TIMESTAMP,
	chat_id BIGSERIAL NOT NULL REFERENCES public.chat(id),
	user_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	text VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS bot_message (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	created TIMESTAMP NOT NULL,
	edited TIMESTAMP,
	chat_id BIGSERIAL NOT NULL REFERENCES public.chat(id),
	bot_id BIGSERIAL NOT NULL REFERENCES public.bot(id),
	text VARCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS public.inbox (
	id BIGSERIAL NOT NULL PRIMARY KEY,
	user_owner_id BIGSERIAL NOT NULL REFERENCES public.user(id),
	created TIMESTAMP NOT NULL,
	name VARCHAR(10));

CREATE TABLE IF NOT EXISTS inbox_channel (
	inbox_id BIGSERIAL NOT NULL REFERENCES public.inbox(id),
	channel_id BIGSERIAL NOT NULL REFERENCES public.channel(id),
	PRIMARY KEY (inbox_id, channel_id));

CREATE TABLE IF NOT EXISTS inbox_chat (
	inbox_id BIGSERIAL NOT NULL REFERENCES public.inbox(id),
	chat_id BIGSERIAL NOT NULL REFERENCES public.chat(id),
	PRIMARY KEY (inbox_id, chat_id));








