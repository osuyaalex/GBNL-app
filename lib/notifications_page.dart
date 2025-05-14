import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbnl_app/services/flutter_notifications.dart';
import 'package:gbnl_app/home_page.dart';
import 'package:gbnl_app/tools/sizes.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationService _notificationService = NotificationService();
  Future<void> _requestPermissions() async {
    await _notificationService.requestIOSPermissions();
    await _notificationService.requestAndroidPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/Icon.svg',
                height: 25.pW,
              ),
              2.gap,
              Text('Get the most out of Blott ✅',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700
              ),
              ),
              2.gap,
              SizedBox(
                width: 90.pW,
                child: Text('Allow notifications to stay in the loop with your payments, requests and groups.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 3.6.pW
                  ),
                ),
              ),
            ],
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SizedBox(
              height: 8.pH,
              width: 100.pW,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xff523AE4))
                ),
                onPressed: () async{
                  await NotificationService().init();
                  await _requestPermissions();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return HomePage();
                  }));
                },
                child: Text('Continue',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
          ),
          1.gap,
        ],
      ),
    );
  }
}
