import 'package:flutter/material.dart';
import 'package:googleapis/cloudcontrolspartner/v1.dart';
import 'package:rcss_frontend/service_implementation/friend_service.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class FriendChatPage extends StatefulWidget {
  final String login_uuid;
  final String groupName;
  final String uuid;
  final String friendUuid;
  final String userName;
  final String friendUserName;
  final String senderUuid;

  FriendChatPage({
    super.key,
    required this.login_uuid,
    required this.groupName,
    required this.uuid,
    required this.friendUuid,
    required this.userName,
    required this.friendUserName,
    required this.senderUuid,
  });

  @override
  State<FriendChatPage> createState() => _FriendChatPageState();
}

class _FriendChatPageState extends State<FriendChatPage> {
  late HubConnection _hubConnection;
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];
  String _seperationLine = '-------------------------';

  final FriendService _friendService = FriendService();

  @override
  void initState() {
    super.initState();
    //_setUnreadCountToZero(widget.login_uuid,widget.uuid, widget.friendUuid);
    _showFriendTalkHistory(widget.uuid, widget.friendUuid);
    _setUnreadCountToZero(widget.login_uuid,widget.uuid, widget.friendUuid);
    _setupSignalR();
  }

  @override
  void dispose() {
    _hubConnection.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室: ${widget.userName} - ${widget.friendUserName}'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setUnreadCountToZero(String login_uuid,String uuid, String friendUuid) async {
    /*Map<String, dynamic> requestBody = {
      'data': [],
      'reader_uuid': widget.uuid,
    };*/
    Map<String, dynamic> requestBody = {
      'uuid': uuid,
      'friend_uuid':friendUuid,
    };
    /*Map<String, dynamic> friendTalkHistoryData =
      await _friendService.fetchFriendTalkHistory(uuid, friendUuid);

    for (Map<String, dynamic> friendTalkHistory in friendTalkHistoryData['data'].reversed.toList()) {
      if (friendTalkHistory['sender_uuid'] == widget.friendUuid) {
        String createdDate = friendTalkHistory['created_date'];

        requestBody['data'].add({
          'uuid': uuid,
          'friend_uuid': friendUuid,
          'created_date': createdDate,
        });
      }
    }*/
    await _friendService.setUnreadFriendTalkToZero(login_uuid, requestBody);
  }

  void _showFriendTalkHistory(String uuid, String friendUuid) async {
    bool isSeperationLineAdded = false;
    bool isEqual = false;

    Map<String, dynamic> friendTalkHistoryData =
        await _friendService.fetchFriendTalkHistory(uuid, friendUuid);

    List<String> duplicatedContents = [];
    List<dynamic> friendTalkHistory =
        friendTalkHistoryData['data'].reversed.toList();
    // 2024/12/16：Michael
    String uuid1="";
    String friend_uuid1="";
    String timestamp="";
    String timestamp1="";
    // 2024/12/16：Michael
    setState(() {
      for (int i = 0; i < friendTalkHistory.length; i++) {
        // 2024/12/16：Michael start
        /*if(i>0) {
          if (!(timestamp1 == friendTalkHistory[i]['created_date'] &&
              uuid1 == friendTalkHistory[i]['uuid'] &&
              friend_uuid1 == friendTalkHistory[i]['friend_uuid'])) {
              if (friendTalkHistory[i-1]['sender_uuid'] == widget.uuid &&
                  friendTalkHistory[i-1]['reader_uuid'] == widget.uuid) {
                _messages.add(
                    '${widget.userName}: ${friendTalkHistory[i-1]['talk_content']} --- [${timestamp}]');
              } else if (friendTalkHistory[i-1]['sender_uuid'] == widget.friendUuid &&
                  friendTalkHistory[i-1]['reader_uuid'] == widget.friendUuid) {
                _messages.add(
                    '${widget.friendUserName}: ${friendTalkHistory[i-1]['talk_content']} --- [${timestamp}]');
              }
          }
        }
        timestamp1 = friendTalkHistory[i]['created_date'];
        timestamp = timestamp1.split(' ')[1].substring(0, 8);
        uuid1=friendTalkHistory[i]['uuid'];
        friend_uuid1=friendTalkHistory[i]['friend_uuid'];*/
        /*if(i>0) {
          if (!(timestamp1 == friendTalkHistory[i]['created_date'] &&
              uuid1 == friendTalkHistory[i]['uuid'] &&
              friend_uuid1 == friendTalkHistory[i]['friend_uuid'])) {
              /*if(!isEqual) {
                _messages.add(_seperationLine);
                isSeperationLineAdded=true;
              }*/
              if (friendTalkHistory[i-1]['sender_uuid'] == widget.uuid &&
                  friendTalkHistory[i-1]['reader_uuid'] == widget.uuid) {
                _messages.add(
                    '${widget.userName}: ${friendTalkHistory[i-1]['talk_content']} --- [${timestamp}]');
              } else if (friendTalkHistory[i-1]['sender_uuid'] == widget.friendUuid &&
                  friendTalkHistory[i-1]['reader_uuid'] == widget.friendUuid) {
                _messages.add(
                    '${widget.friendUserName}: ${friendTalkHistory[i-1]['talk_content']} --- [${timestamp}]');
              }
          }
        }
        if(!isSeperationLineAdded) {
          if (widget.login_uuid == friendTalkHistory[i]['reader_uuid']) {
            isEqual = true;
          }
          else {
            isEqual = false;
          }
        }*/
        /*if(i>0) {
          if (!(timestamp1 == friendTalkHistory[i]['created_date'] &&
              uuid1 == friendTalkHistory[i]['uuid'] &&
              friend_uuid1 == friendTalkHistory[i]['friend_uuid'])) {
              if(!isSeperationLineAdded && !isEqual) {
                _messages.add(_seperationLine);
                isSeperationLineAdded=true;
              }
          }
        }*/
        /*if(i==friendTalkHistory.length-1 && !isSeperationLineAdded && !isEqual)
          {
            _messages.add(_seperationLine);
          }
        else
          {
            if (!(timestamp1 == friendTalkHistory[i]['created_date'] &&
                uuid1 == friendTalkHistory[i]['uuid'] &&
                friend_uuid1 == friendTalkHistory[i]['friend_uuid'])) {
              if(!isSeperationLineAdded && !isEqual) {
                _messages.add(_seperationLine);
                isSeperationLineAdded=true;
              }
            }
          }*/
        /*timestamp1 = friendTalkHistory[i]['created_date'];
        timestamp = timestamp1.split(' ')[1].substring(0, 8);
        uuid1=friendTalkHistory[i]['uuid'];
        friend_uuid1=friendTalkHistory[i]['friend_uuid'];*/
        // 2024/12/16：Michael end


        /////////  Kevin's Code ///////////
        String timestamp = friendTalkHistory[i]['created_date'];
        timestamp = timestamp.split(' ')[1].substring(0, 8);
        if (duplicatedContents.isEmpty) {
          duplicatedContents.add(friendTalkHistory[i]['talk_content']);
        }

        if (duplicatedContents.length == 1) {
          // Reach the last element.
          if (i == friendTalkHistory.length - 1 && friendTalkHistory[i]['sender_uuid'] == widget.login_uuid) {
            _messages.add(_seperationLine);
            isSeperationLineAdded = true;
          } else if (duplicatedContents[0] ==
              friendTalkHistory[i]['talk_content']) {
            duplicatedContents.add(friendTalkHistory[i]['talk_content']);
          } else if (!isSeperationLineAdded) {
            _messages.add(_seperationLine);
            isSeperationLineAdded = true;
          }
        }

        if (duplicatedContents.length == 2) {
          duplicatedContents.clear();
        }

        if (friendTalkHistory[i]['sender_uuid'] == widget.uuid &&
            friendTalkHistory[i]['reader_uuid'] == widget.uuid) {
          _messages.add(
              '${widget.userName}: ${friendTalkHistory[i]['talk_content']} --- [${timestamp}]');
        } else if (friendTalkHistory[i]['sender_uuid'] == widget.friendUuid &&
            friendTalkHistory[i]['reader_uuid'] == widget.friendUuid) {
          _messages.add(
              '${widget.friendUserName}: ${friendTalkHistory[i]['talk_content']} --- [${timestamp}]');
        }
      }
    });
  }

  Future<void> _setupSignalR() async {
    _hubConnection = HubConnectionBuilder()
        // HubIP
        //.withUrl('http://10.0.2.2:5101/friendhub')
        .withUrl('http://10.10.10.207:5211/friendhub')
        .build();

    _hubConnection.start()!.then((_) {
      print("SignalR Connected");

      _hubConnection.invoke('JoinGroup', args: [widget.groupName, widget.uuid]);

      _hubConnection.on('SendGroupMsgFriend', (arguments) {
        print(arguments![2]);
        setState(() {
          _messages.add(
              '${arguments![1]}: ${arguments![2]} --- [${(arguments[3] as String).split(' ')[1].substring(0, 8)}]');
        });
      });
    });
  }

  Future<void> _sendMessage() async {
    if (_hubConnection.state == HubConnectionState.Connected) {
      await _hubConnection.invoke('SendMessageToGroup', args: [
        widget.groupName,
        widget.userName,
        _messageController.text,
        widget.uuid,
        widget.friendUuid,
        //widget.senderUuid,
        widget.login_uuid,
        _messageController.text,
      ]);

      /*DateTime utcNow = DateTime.now().toUtc();
      String formattedUtcNow = '${utcNow.hour}:${utcNow.minute}:${utcNow.second}';

      String uname = widget.uuid == widget.senderUuid ? widget.userName : widget.friendUserName;

      setState(() {
        _messages.add('${uname}: ${_messageController.text} --- [${formattedUtcNow}]');
      });*/

      _messageController.clear();
    } else {
      print('Connection is not established yet');
    }
  }
}
