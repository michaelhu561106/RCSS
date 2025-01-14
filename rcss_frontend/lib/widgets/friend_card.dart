import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rcss_frontend/pages/friend_chat_page.dart';
import 'package:rcss_frontend/service_implementation/index_service.dart';

class FriendCard extends Card {
  final String login_uuid;
  final String uuid;
  final String friendUuid;
  final String userName;
  final String friendUserName;
  final String countUuid;
  final String count;

  FriendCard({
    super.key,
    required this.login_uuid,
    required this.uuid,
    required this.friendUuid,
    required this.userName,
    required this.friendUserName,
    required this.countUuid,
    required this.count,
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String uname = this.countUuid == this.uuid ? userName : friendUserName;
        String fname = this.countUuid == this.uuid ? friendUserName : userName;
        Get.to(
          FriendChatPage(
            login_uuid:this.login_uuid,
            groupName: '${this.uuid}^${this.friendUuid}',
            uuid: this.uuid,
            friendUuid: this.friendUuid,
            userName: uname,
            friendUserName: fname,
            senderUuid: this.countUuid,
          ),
        );
      },
      onLongPress: () => _showCreateNewShortcutDialog(context),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            Text(
              this.friendUserName,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.count,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              showBadge: this.count != '0',
              child: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateNewShortcutDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();

    String fname = this.countUuid == this.uuid ? friendUserName : userName;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('請輸入捷徑名稱'),
            content: TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '捷徑名稱'),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () => {
                  _indexService.createIndexPageShortcut(
                      uuid,
                      3,
                      _titleController.text,
                      {'friend_uuid': friendUuid,
                       'friend_user_name': fname,
                       'sender_uuid': countUuid,},
                      DateTime.now().toUtc().toString()),
                  Navigator.pop(context)
                },
                child: Text('確認'),
              ),
            ],
          );
        });
  }
}
