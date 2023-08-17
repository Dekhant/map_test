import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_task/widget/map_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MaterialApp(home: MarkerIconsPage()));
}
