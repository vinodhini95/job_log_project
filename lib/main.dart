
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gnb_project/dynamic_widget/utils/colors.dart';
import 'package:gnb_project/dynamic_widget/utils/router.dart';
import 'package:gnb_project/screens/intro_screens/splash_screen.dart';
import 'package:gnb_project/service/local_service/porvider_info.dart';
import 'package:gnb_project/service/service_file/fire_base_config.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';


// Override HTTP behavior to accept all SSL certificates (useful for development)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//Entry point of flutter app
void main() async {
  // Ensure that plugin service are initialized before runapp is called
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.platformOptions,
  );

  // desktop size cntrl
  if (Platform.isLinux || Platform.isWindows) {
    DesktopWindow.setWindowSize(const Size(800, 600));
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(800, 600), // Set width and height
      center: true, // Center the window
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.normal,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  //run main application widget
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: InitiateFlutterPackage().getProviderChangeNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: false,
            primaryColor: primaryColor,
            secondaryHeaderColor: globalColor,
            fontFamily: "Lato"),
        routes: Routers.routes,
        initialRoute: "/",
        home: SplashScreen(),
      ),
    );
  }
}
