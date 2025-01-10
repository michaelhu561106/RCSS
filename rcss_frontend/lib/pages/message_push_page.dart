import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/message_push_service.dart';
import 'package:rcss_frontend/widgets/message_push_card.dart';

import '../views/message_push_page_list_view.dart';

class MessagePushPage extends StatefulWidget {
  final String uuid;
  final String userName;
  const MessagePushPage({
    super.key,
    required this.uuid,
    required this.userName,
  });
  @override
  State<MessagePushPage> createState() => _MessagePushPageState();
}
class _MessagePushPageState extends State<MessagePushPage> {
  final List<MessagePushCard> _MessagePushCards = [];
  final MessagePushService _messagePushService = MessagePushService();

  @override
  void initState() {
    super.initState();
    getBusinessNamesAndUnreadCountsByUuid(widget.uuid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商家廣告'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: MessagePushPageListView(
          cards: _MessagePushCards,
          uuid: widget.uuid,
        ),
      ),
    );
  }
  void getBusinessNamesAndUnreadCountsByUuid(String uuid) async {
    Map<String, dynamic> businessMessagePushIsNotRead =
    await _messagePushService.getBusinessMessagePushIsNotRead(uuid);
    //print(businessMessagePushIsNotRead['data'].length);

    setState(() {
      for (Map<String, dynamic> business
      in businessMessagePushIsNotRead['data']) {
          _MessagePushCards.add(
            MessagePushCard(
              business_id: business['business_id'],
              business_message_push_id:business['business_message_push_id'],
              uuid: uuid,
              message_title: business['message_title'],
              message_content: business['message_content'],
              message_image: business['message_image'],
              message_url:business['message_url']
            ),
          );
      }
      //print(_MessagePushCards.length);

      /*for (Map<String, dynamic> business
      in businessNamesAndUnreadCountsByUuid['data']) {
        if (business['is_user_read'] == null) {
          _MessagePushCards.add(
            MessagePushCard(
              unreadCount: '0',
              uuid: uuid,
              businessName: business['business_name'],
              businessId: business['business_id'].toString(),
              userName: widget.userName,
            ),
          );
        }
      }*/
    });
  }
}
