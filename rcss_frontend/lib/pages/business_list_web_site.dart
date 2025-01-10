import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/store_service.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rcss_frontend/widgets/business_card.dart';
import 'package:rcss_frontend/pages/chat_room_page.dart';

class BusinessListWebSitePage extends StatefulWidget {
  final String uuid;
  final String userName;
  final String businessId;
  final String businessUrl;
  final String unreadCount;
  final String businessName;

  const BusinessListWebSitePage({
    super.key,
    required this.uuid,
    required this.userName,
    required this.businessId,
    required this.businessUrl,
    required this.unreadCount,
    required this.businessName,
  });

  @override
  State<BusinessListWebSitePage> createState() => _BusinessListWebSitePageState();
}

class _BusinessListWebSitePageState extends State<BusinessListWebSitePage> {
  final List<BusinessCard> _businessCards = [];
  final StoreService _storeService = StoreService();
  //late final WebViewController controller;
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    /*controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.businessUrl),
      );*/
    var url = WebUri(widget.businessUrl);
    webViewController?.loadUrl(urlRequest: URLRequest(url: url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:GestureDetector(
            onTap: ()
            /*=> _chatRoomPage(widget.uuid,widget.businessId,widget.businessName)*/ {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    ChatRoomPage(
                      uuid: widget.uuid,
                      businessId: widget.businessId,
                      userName: widget.userName,
                    )),
              );
            },
            /*Get.to(
            ChatRoomPage(
                uuid: widget.uuid,
                businessId: widget.businessId,
                userName: widget.userName,
              ),
            );*//*
          }*/
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "${widget.businessName}(${widget.unreadCount})",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: Stack(children: [
          //WebViewWidget(
            //controller: controller,
          //),
            InAppWebView(
            //key: webViewKey,
            //webViewEnvironment: webViewEnvironment,
            initialUrlRequest:
            URLRequest(url: WebUri(widget.businessUrl)),
            //initialSettings: settings,
            //pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            }),
        ])
    );
  }
  void _chatRoomPage(String uuid,String businessId,String businessName) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatRoomPage(
      uuid: uuid,
      businessId: businessId,
      userName: businessName,
    )));
  }
}