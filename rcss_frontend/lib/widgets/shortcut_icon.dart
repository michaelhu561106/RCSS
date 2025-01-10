import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcss_frontend/pages/chat_room_page.dart';
import 'package:rcss_frontend/pages/friend_chat_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/chat_page.dart';
import '../pages/index_page.dart';
import '../service_implementation/index_service.dart';

class ShortcutIcon extends StatefulWidget {
  final String login_uuid;
  final String uuid;
  final String userName;
  final int type;
  final String imagePath;
  final String title;
  final Map<String, dynamic> shortcutUrl;
  final String unreadCount;
  final Function onDelete;

  const ShortcutIcon({
    super.key,
    required this.login_uuid,
    required this.uuid,
    required this.userName,
    required this.type,
    required this.imagePath,
    required this.title,
    required this.shortcutUrl,
    required this.unreadCount,
    required this.onDelete,
  });

  @override
  State<ShortcutIcon> createState() => _ShortcutIconState();
}

class _ShortcutIconState extends State<ShortcutIcon> {
  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox(width: 65),
            badges.Badge(
              badgeContent: Text(
                widget.unreadCount,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              showBadge: widget.unreadCount != '0',
            ),
          ],
        ),
        GestureDetector(
          onTap: () => _clickNavigate(context),
          onLongPress: () => _showDeleteShortcutDialog(context),
          child: Image.network(
            'http://10.10.10.207:8082/${widget.imagePath}',
            width: 50,
            height: 50,
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  void _deleteShortcut(
      String uuid, int shortcutTypeId, String shortcutTitle) async {
    try {
      for (ShortcutIcon shortcut in shortcuts) {
        if (shortcut.title == shortcutTitle) {
          shortcuts.remove(shortcut);

          await _indexService.deleteShortcut(
            uuid,
            shortcutTypeId,
            shortcutTitle,
          );
        }
      }
    } catch (ex) {
      print('Shortcut not found.');
    }
  }

  void _showDeleteShortcutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('確認刪除捷徑'),
            content: Text('刪除捷徑：${widget.title}？'),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                  onPressed: () => {
                        setState(() {
                          _deleteShortcut(
                              widget.uuid, widget.type, widget.title);
                          widget.onDelete();
                          Navigator.pop(context);
                        }),
                      },
                  child: Text('確認')),
            ],
          );
        });
  }

  void _clickNavigate(BuildContext context) {
    switch (widget.type) {
      case 1:
        int businessId = widget.shortcutUrl['business_id'];
        Get.to(
          ChatRoomPage(
            uuid: widget.uuid,
            businessId: businessId.toString(),
            userName: widget.userName,
          ),
        );
        break;
      case 2:
        int businessId = widget.shortcutUrl['business_id'];
        String serviceName = widget.shortcutUrl['business_service_name'];
        Get.to(
          ChatPage(
            groupName: '${serviceName}^${widget.uuid}',
            uuid: widget.uuid,
            businessId: businessId.toString(),
            serviceName: serviceName,
            userName: widget.userName,
          ),
        );
      case 3:
        String friendUuid = widget.shortcutUrl['friend_uuid'];
        String friendUserName = widget.shortcutUrl['friend_user_name'];
        String senderUuid = widget.shortcutUrl['sender_uuid'];
        Get.to(FriendChatPage(
            login_uuid: widget.login_uuid,
            groupName: '${widget.uuid}^friendUuid',
            uuid: widget.uuid,
            friendUuid: friendUuid,
            userName: widget.userName,
            friendUserName: friendUserName,
            senderUuid: senderUuid));
        break;
      case 5:
        String url = widget.shortcutUrl['url'];
        launchUrl(Uri.parse(url));
    }
  }
}
