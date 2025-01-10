import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/chat_service.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatPage extends StatefulWidget {
  final String groupName;
  final String uuid;
  final String businessId;
  final String serviceName;
  final String userName;

  const ChatPage({
    super.key,
    required this.groupName,
    required this.uuid,
    required this.businessId,
    required this.serviceName,
    required this.userName,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late HubConnection hubConnection;
  final TextEditingController messageController = TextEditingController();
  List<String> messages = [];
  String seperationLine = '-------------------------';

  ChatService _chatService = ChatService();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _setUnreadCountToZero();
    _showHistoryMessages();
    _setupSignalR();
  }

  @override
  void dispose() {
    hubConnection.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天室: ${widget.serviceName} - ${widget.userName}'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(messages[index]),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
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

  void _setUnreadCountToZero() async {
    try {
      await _chatService.setUnreadMessagesCountToZero(
        widget.uuid,
        widget.businessId,
        widget.groupName.split('^')[0],
      );
    } catch (ex) {
      print(ex);
    }
  }

  void _showHistoryMessages() async {
    bool isSeperationLineAdded = false;

    Map<String, dynamic> recentMessagesHistoryData =
        await _chatService.getRecentTalkHistory(
            widget.uuid, widget.businessId, widget.serviceName);
    setState(() {
      for (Map<String, dynamic> recentMessagesHistory
          in recentMessagesHistoryData['data'].reversed) {
        String timestamp = recentMessagesHistory['created_date'];
        timestamp = timestamp.split('T')[1].substring(0, 8);

        if (!recentMessagesHistory['is_user_read'] && !isSeperationLineAdded) {
          messages.add(seperationLine);
          isSeperationLineAdded = true;
        }

        if (recentMessagesHistory['is_user_talk']) {
          messages.add(
              '${recentMessagesHistory['user_name']}: ${recentMessagesHistory['talk_content']} --- [${timestamp}]');
        } else {
          messages.add(
              '${recentMessagesHistory['backend_user_name']}: ${recentMessagesHistory['talk_content']} --- [${timestamp}]');
        }
      }
    });
  }

  Future<void> _setupSignalR() async {
    hubConnection = HubConnectionBuilder()
        // HubIP
        .withUrl('http://10.0.2.2:5101/chathub')
        //.withUrl('http://10.10.10.207:5211/chathub')
        .build();
    hubConnection.start()?.then((_) {
      print("SignalR Connected");

      hubConnection.invoke('JoinGroup', args: [widget.groupName, widget.uuid]);

      hubConnection.on('SendGroupMsg', (arguments) {
        print(arguments![2]);
        setState(() {
          messages.add(
              '${arguments![1]}: ${arguments![2]} --- [${(arguments[3] as String).split(' ')[1].substring(0, 8)}]');
        });
      });
    });
  }

  Future<void> _sendMessage() async {
    if (hubConnection.state == HubConnectionState.Connected) {
      // String timestamp = formatDate(DateTime.now(), [HH, ':', mm, ':', ss]);
      await hubConnection.invoke(
        'SendMessageToGroup',
        args: [
          widget.groupName,
          widget.userName,
          messageController.text,
          int.parse(widget.businessId),
          widget.uuid,
          true,
          0,
          true,
          false,
          widget.userName,
        ],
      );
      messageController.clear();
    } else {
      print('Connection is not established yet');
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 3), curve: Curves.easeOut);
  }
}
