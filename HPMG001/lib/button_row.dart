import 'package:flutter/material.dart';
import '/expanded_button.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        ExpandedButton(),
        ExpandedButton(),
        Spacer(),
        Spacer(),
        Spacer(),
      Spacer(),
        Spacer(),
        ExpandedButton(),
        Spacer(),
        ExpandedButton(),
      ]
    );
  }
}