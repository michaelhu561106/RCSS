import 'package:flutter/material.dart';

import '../widgets/business_card.dart';

class StorePageListView extends StatelessWidget {
  final String uuid;
  final List<BusinessCard> cards;
  const StorePageListView({
    super.key,
    required this.cards,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (
          context,
          index,
        ) {
          return cards[index];
        });
  }
}
