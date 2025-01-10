import 'package:flutter/material.dart';

class TextListView extends StatelessWidget {
  final List<Text> texts;
  const TextListView({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GestureDetector(child: texts[index]),
            ],
          );
        });
  }
}
