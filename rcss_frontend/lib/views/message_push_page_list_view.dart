import 'package:flutter/material.dart';

import '../widgets/message_push_card.dart';

class MessagePushPageListView extends StatelessWidget {
  final String uuid;
  final List<MessagePushCard> cards;
  const MessagePushPageListView({
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
