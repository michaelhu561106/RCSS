import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';
import 'package:rcss_frontend/views/invitation_page_list_view.dart';
import 'package:rcss_frontend/widgets/friend_card.dart';

import '../widgets/invitation_card.dart';

class InvitationPage extends StatefulWidget {
  final String uuid;

  InvitationPage({
    super.key,
    required this.uuid,
  });

  @override
  State<InvitationPage> createState() => _InvitationPageState();
}

class _InvitationPageState extends State<InvitationPage> {
  final List<InvitationCard> invitationCards = [];
  final FriendService _friendService = FriendService();

  @override
  void initState() {
    super.initState();
    _getFriendInvitationList(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友邀請'),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: InvitationPageListView(
          cards: invitationCards,
        ),
      ),
    );
  }

  void _getFriendInvitationList(String uuid) async {
    Map<String, dynamic> friendInvitationData =
        await _friendService.getFriendInvitationList(uuid);

    setState(() {
      for (Map<String, dynamic> friendInvitation
          in friendInvitationData['data']) {
        invitationCards.add(
          InvitationCard(
            uuid: friendInvitation['uuid'],
            friendUuid: friendInvitation['friend_uuid'],
            createdDate: friendInvitation['created_date'],
            userName: friendInvitation['user_name'],
          ),
        );
      }
    });
  }
}
