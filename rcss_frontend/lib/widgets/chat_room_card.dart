import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcss_frontend/pages/chat_page.dart';

import '../service_implementation/index_service.dart';

class ChatRoomCard extends Card {
  final String avatarPath;
  final String unreadCount;
  final String serviceName;
  final String uuid;
  final String businessId;
  final String userName;

  ChatRoomCard({
    super.key,
    required this.avatarPath,
    required this.unreadCount,
    required this.serviceName,
    required this.uuid,
    required this.businessId,
    required this.userName,
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatPage(
            groupName: '${this.serviceName}^${this.uuid}',
            uuid: this.uuid,
            businessId: this.businessId,
            serviceName: this.serviceName,
            userName: this.userName,
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
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset(avatarPath!),
            ),
            SizedBox(width: 20),
            Text(
              serviceName!,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.unreadCount!,
                style: TextStyle(color: Colors.white),
              ),
              showBadge: this.unreadCount != '0',
              child: Icon(Icons.notifications),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateNewShortcutDialog(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
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
                      2,
                      _titleController.text,
                      {
                        'business_id': int.parse(businessId),
                        'business_service_name': serviceName
                      },
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
