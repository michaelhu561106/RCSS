import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service_implementation/message_push_service.dart';

class MessagePushContentPage extends StatefulWidget {
  final String uuid;
  final int business_id;
  final int business_message_push_id;
  final String message_title;
  final String message_content;
  final String message_image;
  final String message_url;

  MessagePushContentPage({
    super.key,
    required String this.uuid,
    required int this.business_id,
    required int this.business_message_push_id,
    required String this.message_title,
    required String this.message_content,
    required String this.message_image,
    required String this.message_url,
  });

  @override
  State<MessagePushContentPage> createState() => _MessagePushContentPageState();
}
class _MessagePushContentPageState extends State<MessagePushContentPage> {
  final MessagePushService messagePushService = MessagePushService();
  Uri _url= new Uri();
  @override
  void initState() {
    super.initState();
    _url = Uri.parse('${widget.message_url}');
    _setUserReadMessagePush(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.message_title}"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.message_content}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 32),
            new InkWell(
                child: new Text("${widget.message_url}",style: TextStyle(
                    color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),),
                onTap: () => launchUrl(_url),
            ),
            SizedBox(height: 32),
            GestureDetector(
              //onTap: () => _clickNavigate(context),
              child: Image.network(
                'http://10.10.10.207:8082/${widget.message_image}',
                /*width: 50,
                height: 50,*/
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setUserReadMessagePush(BuildContext context) async {
    Map<String, dynamic> response = new Map<String, dynamic>();
    response = await messagePushService
        .setUserReadMessagePush(
        widget.uuid,
        widget.business_id,
        widget.business_message_push_id);
    if(response['code']!=0)
      {
        print(response['message']);
      }
  }
}