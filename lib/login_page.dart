import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gbnl_app/notifications_page.dart';
import 'package:gbnl_app/tools/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _firstName = '';
  String _lastName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your legal name',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 7.pW
        ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90.pW,
              child: Text('We need to know a bit about you so we can create your account.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 3.6.pW
              ),
              ),
            ),
            4.gap,
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                hintText: 'First name',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 18
                )
              ),
              onChanged: (v){
                _firstName = v;
                setState(() {});
              },
            ),
            5.gap,
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  hintText: 'Last name',
                  hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 18
                  )
              ),
              onChanged: (v){
                _lastName = v;
                setState(() {});
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: _firstName.isNotEmpty && _lastName.isNotEmpty?
          Color(0xff523AE4):null,
        elevation: 0,
          onPressed:()async{
         if(_firstName.isNotEmpty && _lastName.isNotEmpty){
           SharedPreferences pref = await SharedPreferences.getInstance();
           await pref.setString('firstName', _firstName);
           await pref.setString('lastName', _lastName);
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return NotificationsPage();
           }));
         }
          },
        child: SvgPicture.asset('assets/Chevron Right.svg')
      ),
    );
  }
}
