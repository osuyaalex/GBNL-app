import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gbnl_app/login_page.dart';
import 'package:gbnl_app/services/backend_db.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:provider/provider.dart' as provider;

import 'services/flutter_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp( provider.MultiProvider(
    providers: [
      provider.ChangeNotifierProvider<BackendDb>(create:(_) => BackendDb())
    ],
      child: MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const LoginPage(),
        );
      }
    );
  }
}

