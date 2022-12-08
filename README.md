# messenger_data_base
The database's architecture for simple messenger. For the messanger example was taken a <a href="https://telegram.org" target="_blank">telegram</a>. Made with PostgreSQL / psql.

## The structure of the database
Description of used entities for messenger's database:
1.  **USER** - a user of the messanger's application. He can create bots, channels (or subscribe), chats (or be invited), inboxes, write messages in chats, leave comments to posts, use application from different devices on the same account, add other users to contacts or block them.
2.  **DEVICE** - a physical device from which user can log in to the application: notebook, phone, PC and etc.
3.  **VERIFICATION** - every time user logs in from new device he should pass the verification by writing the verification code, which is send by messenger on the user's phone or other verified device.
5.  **CONTACT** - other user that was added to user's personal contact book for quick search of needed chat and / or showing personal data only for chosen users (for example, the settings may be so, that nobody can see user's phone number except of his contacts).
6.  **CHANNEL** - often a thematic group, where only creater can post some messages and other users (subscribers of the channel) can comment these posts. It may be a mass media, a personal or company's blog and etc. 
7.  **POST** - 
8.  **COMMENT** -
9.  **CHAT** -
10. **MESSAGE** -
11. **BOT** -
12. **INBOX** -


### Conceptual level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Conceptual%20level.png)
*was made on <a href="https://erdplus.com" target="_blank">erdplus</a>*

### Datalogical level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Datalogical%20level.png)
*was made on <a href="https://www.diagrams.net/blog/move-diagrams-net" target="_blank">diagrams.net</a>*

### Physical level
![](https://github.com/IlyaLoladze/messenger_data_base/blob/main/ERD/Physical%20level.png)
*was made on <a href="https://dbeaver.io" target="_blank">DBeaver</a>*



