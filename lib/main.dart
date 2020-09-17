import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './src/pages/history/history_page.dart';
import './src/pages/main_page.dart';
import './src/utils/colors_utils.dart';
import './src/utils/routeUtils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortcut Whats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorsUtils.primaryColor,
        scaffoldBackgroundColor: ColorsUtils.backgroundScaffold,
        buttonTheme: ButtonThemeData(
            buttonColor: ColorsUtils.backgroundButton,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RouteUtils.home,
      routes: {
        RouteUtils.home: (_) => MainPage(),
        RouteUtils.history: (_) => HistoryPage()
      },
    );
  }
}
