import 'package:flutter/material.dart';
import 'package:rcss_frontend/widgets/invitation_card.dart';

class InvitationPageListView extends StatelessWidget {
  final List<InvitationCard> cards;

  InvitationPageListView({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return cards[index];
        });
  }
}
