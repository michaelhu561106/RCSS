import 'package:flutter/material.dart';
import 'package:rcss_frontend/widgets/friend_card.dart';

class FriendPageListView extends StatelessWidget {
  final List<FriendCard> cards;

  FriendPageListView({
    super.key,
    required this.cards,
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
      },
    );
  }
}
