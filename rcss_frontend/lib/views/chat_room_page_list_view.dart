import 'package:flutter/material.dart';

class ChatRoomPageListView extends StatelessWidget {
  final List<Card> cards;
  const ChatRoomPageListView({super.key, required this.cards});

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
