import 'package:flutter/material.dart';
import '/button_row.dart';
import '/game/epicron_stateful_widget.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: const [
            Expanded(
              child: EpicronStatefulWidget(),
            ),
            ButtonRow(),
          ],
        ),
      ),
    );
  }
}