import 'services/dependency.dart' as dep;
import 'package:flutter/material.dart';
import 'app/home/my_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

