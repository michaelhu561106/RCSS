import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcss_frontend/pages/message_push_content_page.dart';

import '../service_implementation/index_service.dart';

class MessagePushCard extends Card {
  final int business_id;
  final String uuid;
  final int business_message_push_id;
  final String message_title;
  final String message_content;
  final String message_image;
  final String message_url;

  MessagePushCard({
    super.key,
    required this.business_id,
    required this.uuid,
    required this.business_message_push_id,
    required this.message_title,
    required this.message_content,
    required this.message_image,
    required this.message_url
  });

  final IndexService _indexService = IndexService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          MessagePushContentPage(
            uuid:this.uuid,
            business_id:this.business_id,
            business_message_push_id:this.business_message_push_id,
            message_title: this.message_title,
            message_content: this.message_content,
            message_image: this.message_image,
            message_url: this.message_url
          ),
        );
      },
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            Text(
              this.message_title,
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
