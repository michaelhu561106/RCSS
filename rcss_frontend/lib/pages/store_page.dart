import 'package:flutter/material.dart';
import 'package:rcss_frontend/service_implementation/store_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:rcss_frontend/widgets/business_card.dart';

import '../views/store_page_list_view.dart';

class StorePage extends StatefulWidget {
  final String uuid;
  final String userName;

  const StorePage({
    super.key,
    required this.uuid,
    required this.userName,
  });

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List<BusinessCard> _businessCards = [];
  final StoreService _storeService = StoreService();
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    getBusinessNamesAndUnreadCountsByUuid(widget.uuid);
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商家'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Stack(children: [
        StorePageListView(
          cards: _businessCards,
          uuid: widget.uuid,
        ),
      ])
      /*Container(
        child: StorePageListView(
          cards: _businessCards,
          uuid: widget.uuid,
        ),
      ),*/
    );
  }

  void getBusinessNamesAndUnreadCountsByUuid(String uuid) async {
    Map<String, dynamic> businessNamesAndUnreadCountsByUuid =
        await _storeService.getBusinessListByUuid(uuid);

    setState(() {
      for (Map<String, dynamic> business
          in businessNamesAndUnreadCountsByUuid['data']) {
        if (business['is_user_read'] != null) {
          _businessCards.add(
            BusinessCard(
              unreadCount: business['business_service_talks_is_not_read_count'],
              uuid: uuid,
              businessName: business['business_name'],
              businessId: business['business_id'].toString(),
              userName: widget.userName,
              businessUrl:business['business_url']
            ),
          );
        }
      }

      for (Map<String, dynamic> business
          in businessNamesAndUnreadCountsByUuid['data']) {
        if (business['is_user_read'] == null) {
          _businessCards.add(
            BusinessCard(
              unreadCount: '0',
              uuid: uuid,
              businessName: business['business_name'],
              businessId: business['business_id'].toString(),
              userName: widget.userName,
              businessUrl:business['business_url']
            ),
          );
        }
      }
    });
  }
}
