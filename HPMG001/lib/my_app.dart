import 'package:flutter/material.dart';
import 'package:hpmg001/controllers/rosant_controller.dart';
import '/models/rosant/rosant.dart';
import '/my_app_state.dart';

class MyApp extends StatefulWidget {
  final Rosant rosant = Rosant();
  final Function performMovement = RosantController.performMovement;
  MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}
