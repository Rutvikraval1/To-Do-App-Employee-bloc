import 'package:flutter/material.dart';

import '../../common/scaffoldWidget.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold_widget(
      body: Center(
        child: Text('This is the not found screen'),
      ),
    );
  }
}
