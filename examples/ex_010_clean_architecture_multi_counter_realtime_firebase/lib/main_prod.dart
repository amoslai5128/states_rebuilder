import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import 'injected.dart';
import 'my_app.dart';

//to run the app use : flutter run  -t lib/main_prod.dart
void main() {
  RM.env = Flavor.Prod;
  runApp(new MyApp());
}
