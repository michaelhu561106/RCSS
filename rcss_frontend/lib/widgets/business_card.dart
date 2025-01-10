import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcss_frontend/pages/chat_room_page.dart';
import 'package:rcss_frontend/pages/business_list_web_site.dart';

import '../service_implementation/index_service.dart';

class BusinessCard extends Card {
  final String unreadCount;
  final String uuid;
  final String businessName;
  final String businessId;
  final String userName;
  final String businessUrl;

  BusinessCard({
    super.key,
    required this.unreadCount,
    required this.uuid,
    required this.businessName,
    required this.businessId,
    required this.userName,
    required this.businessUrl,
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          /*ChatRoomPage(
            uuid: uuid,
            businessId: businessId,
            userName: userName,
          ),*/
          BusinessListWebSitePage(
            uuid: uuid,
            businessId: businessId,
            userName: userName,
            businessUrl: businessUrl,
            unreadCount:unreadCount,
            businessName:businessName,
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
              this.businessName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 28),
            badges.Badge(
              badgeContent: Text(
                this.unreadCount,
                style: TextStyle(color: Colors.white),
              ),
              showBadge: this.unreadCount != '0',
              child: Icon(Icons.notifications),
            )
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
                      1,
                      _titleController.text,
                      {'business_id': int.parse(businessId)},
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
