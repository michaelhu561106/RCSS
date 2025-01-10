import 'package:flutter/material.dart';
import 'package:rcss_frontend/widgets/shortcut_icon.dart';

class IndexPageGridView extends StatelessWidget {
  final List<ShortcutIcon> icons;
  const IndexPageGridView({
    super.key,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 10,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        return icons[index];
      },
    );
  }
}
