# messenger_data_base
The database's architecture for simple messenger. For the messanger example was taken a <a href="https://telegram.org" target="_blank">telegram</a>. Made on PostgreSQL.

## Building a project locally
To create all tables with corresponding relations:
```pgsql
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/db_creation_psql.sql'
```
To fill tables with data generated on <a href="https://www.mockaroo.com" target="_blank">mockaroo</a>:
```pgsql
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/user.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/device.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/user_device.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/verification.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/contact.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/channel.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/channel_subscribers.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/post.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/comment.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/bot.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/chat.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/user_chat_member.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/bot_chat_member.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/user_message.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/bot_message.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/inbox.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/inbox_chat.sql'
\i '/Users/macbook/Desktop/messenger_data_base_copy/psql scripts/data base creation/data generation/inbox_channel.sql'

```

## The structure of the database
Description of used entities for messenger's database:
1.  **USER** - a user of the messanger's application. He can create bots, channels (or subscribe), chats (or be invited), inboxes, write messages in chats, leave comments to posts, use application from different devices on the same account, add other users to contacts or block them.
2.  **DEVICE** - a physical device from which user can log in to the application: notebook, phone, PC and etc.
3.  **VERIFICATION** - every time user logs in from new device he should pass the verification by writing the verification code, which is send by messenger on the user's phone or other verified device.
5.  **CONTACT** - other user that was added to user's personal contact book for quick search of needed chat and / or showing personal data only for chosen users (for example, the settings may be so, that nobody can see user's phone number except of his contacts).
6.  **CHANNEL** - often a thematic group, where only creater can post some messages and other users (subscribers of the channel) can comment these posts. It may be a mass media, a personal or company's blog and etc. 
7.  **POST** - a separate piece of text in channel that was written by channel's creator. The post can be commented by other users.
8.  **COMMENT** - a comment to channel's post, that can be written by any user.
9.  **CHAT** - a chat between two users (personal chat), one user and one bot (bot chat) or many users (group), where every participant can write messages.
10. **MESSAGE** - a separate pice of text in chat, which can be written by bot or user.
11. **BOT** - a programmed service, which is created by users and can communicate with other users in chats. It may be a shop's assistant, that shows different products, a service for booking tickets or converting images and etc.
12. **INBOX** - a folder made by users, which contains chosen chats and channels. Every user has a "default" inbox with all user's chats and channels. However, user can create separate "custom" inboxes to sort everything. For example, he can create inbox with name "work", where all chats and channels related to his work will be placed (but after this they also stay in a "default" inbox).


### Conceptual level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Conceptual%20level.png)
*was made on <a href="https://erdplus.com" target="_blank">erdplus</a>*

### Datalogical level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Datalogical%20level.png)
*was made on <a href="https://www.diagrams.net/blog/move-diagrams-net" target="_blank">diagrams.net</a>*

### Physical level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Physical%20level.png)
*was made on <a href="https://dbeaver.io" target="_blank">DBeaver</a>*

## Some query examples
Getting all user's chats and channels:
```sql
SELECT channel.name, channel.updated
FROM public.user u
	JOIN channel_subscribers cs ON u.id = cs.subscriber_id
	JOIN channel ON cs.channel_id = channel.id
WHERE u.id = 469
UNION ALL
SELECT chat.name, chat.updated
FROM public.user u
	JOIN user_chat_member ucm ON ucm.user_id = u.id
	JOIN chat ON ucm.chat_id = chat.id
WHERE u.id = 469;
```
Getting all messages from particular chat:
```sql
-- for personal or group chat
SELECT um.created, u.name, um.text
FROM public.chat c 
JOIN user_message um ON c.id = um.chat_id
JOIN public.user u ON u.id = um.user_id
WHERE 1 = 1
	and c.id = 309
ORDER BY um.created;

-- for bot chat
SELECT created, name, text
FROM (SELECT um.created as created, u.name as name, um.text as text
	FROM public.chat c 
	JOIN user_message um ON c.id = um.chat_id
	JOIN public.user u ON u.id = um.user_id
	WHERE 1 = 1
		and c.id = 792
	UNION ALL
	SELECT bm.created, b.name, bm.text
	FROM public.chat c 
	JOIN bot_message bm ON c.id = bm.chat_id
	JOIN public.bot b ON b.id = bm.bot_id
	WHERE 1 = 1
		and c.id = 792) subq 
ORDER BY created;
```
Showing all user's contacts:
```sql
SELECT COALESCE(c.contact_name, contact_user.name) as user_name
FROM public.contact c
JOIN public.user contact_user ON c.contact_user_id = contact_user.id
WHERE 1 = 1
	and c.user_id = 24
	and c.is_blocked IS FALSE
	and (SELECT is_blocked 
     	     FROM public.contact 
	     WHERE 1 = 1
		and public.contact.user_id = contact_user.id 
		and public.contact.contact_user_id = 24) IS NOT TRUE
ORDER BY user_name;
```

