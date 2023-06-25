import 'package:flutter/material.dart';
import '/models/rosant/rosant.dart';
import '/my_app_state.dart';

class MyApp extends StatefulWidget {
  final Rosant rosant = Rosant();
  MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}
