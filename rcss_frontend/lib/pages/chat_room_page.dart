import 'package:flutter/material.dart';
import 'package:rcss_frontend/widgets/chat_room_card.dart';

import '../service_implementation/store_service.dart';
import '../views/chat_room_page_list_view.dart';

class ChatRoomPage extends StatefulWidget {
  final String uuid;
  final String businessId;
  final String userName;

  const ChatRoomPage({
    super.key,
    required this.uuid,
    required this.businessId,
    required this.userName,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<ChatRoomCard> _chatRoomCards = [];
  final StoreService _storeService = StoreService();

  @override
  void initState() {
    super.initState();
    getBusinessServiceNamesAndUnreadCountsByUuidAndBusinessId(
        widget.uuid, widget.businessId, widget.userName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: ChatRoomPageListView(
          cards: _chatRoomCards,
        ),
      ),
    );
  }

  void getBusinessServiceNamesAndUnreadCountsByUuidAndBusinessId(
      String uuid, String businessId, String userName) async {
    Map<String, dynamic> businessServiceNamesAndUnreadCounts =
        await _storeService.getBusinessServicesListByUuidAndBusinessId(
            uuid, businessId);
    print(businessServiceNamesAndUnreadCounts);

    setState(() {
      for (Map<String, dynamic> businessService
          in businessServiceNamesAndUnreadCounts['data'])
        _chatRoomCards.add(
          ChatRoomCard(
            avatarPath: '',
            unreadCount: (businessService[
                        'business_service_talks_is_not_read_count'] ==
                    null
                ? '0'
                : businessService['business_service_talks_is_not_read_count']),
            serviceName: businessService['business_service_name'],
            uuid: uuid,
            businessId: businessId,
            userName: userName,
          ),
        );
    });
  }
}
