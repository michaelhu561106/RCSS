import 'package:flutter/material.dart';
import 'package:rcss_frontend/pages/invitation_page.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';
import 'package:rcss_frontend/views/friend_page_list_view.dart';
import 'package:rcss_frontend/widgets/friend_card.dart';

class FriendPage extends StatefulWidget {
  final String uuid;
  final String username;

  const FriendPage({
    super.key,
    required this.uuid,
    required this.username
  });

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  final List<FriendCard> _friendCards = [];
  final FriendService _friendService = FriendService();

  @override
  void initState() {
    super.initState();
    _fetchFriendsList(widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('好友'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: FriendPageListView(
          cards: _friendCards,
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              heroTag: 'Add',
              onPressed: () => _showCreateFriendRequestDialog(context),
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 100.0,
            child: FloatingActionButton(
              heroTag: 'Invitation',
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvitationPage(uuid: widget.uuid),
                  ),
                ),
              },
              child: Icon(Icons.mail),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showCreateFriendRequestDialog(BuildContext context) {
    final TextEditingController _userNameController = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('請輸入用戶名稱'),
            content: TextField(
              controller: _userNameController,
              decoration: InputDecoration(labelText: '用戶名稱'),
            ),
            actions: [
              TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () => {
                  _friendService.createFriendRequest(
                      widget.uuid,
                      _userNameController.text,
                      DateTime.now().toUtc().toString()),
                  Navigator.pop(context)
                },
                child: Text('確認'),
              ),
            ],
          );
        });
  }

  void _fetchFriendsList(String uuid) async {
    Map<String, dynamic> friendsData =
        await _friendService.fetchFriendsList(uuid);

    setState(() {
      for (Map<String, dynamic> friend in friendsData['data']) {
        _friendCards.add(
          FriendCard(
            login_uuid:widget.uuid,
            uuid: friend['uuid'],
            friendUuid: friend['friend_uuid'],
            userName: widget.username,
            friendUserName: friend['friend_user_name'],
            countUuid: friend['count_uuid'],
            count: friend['count'].toString(),
          ),
        );
      }
    });
  }
}
