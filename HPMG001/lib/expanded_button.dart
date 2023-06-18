import 'package:flutter/material.dart';

class ExpandedButton extends StatelessWidget {
  const ExpandedButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            // Acción del botón
          },
          child: const Text('Botón'),
        ),
      ),
    );
  }
}