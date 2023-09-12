import 'dart:async';
import 'package:aokiji_s_application4/presentation/filter_screen/filter_screen.dart';
import 'package:aokiji_s_application4/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail = '';
String? obtainedEmail = '';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState()
  {
    getValidation().whenComplete(() async {
      Timer(Duration(seconds: 2),() => Get.to(finalEmail == null ? SignInScreen() : FilterScreen()));
    });
    super.initState();
  }

  Future getValidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
    print(obtainedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Builder(
          builder: (context) {
            // Sử dụng Future.delayed để đợi 2 giây trước khi chuyển hướng
            

            return Container(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Image.asset(
                    'assets/images/trilogo.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 5, // Khoảng cách giữa Text và ảnh
                  ),
                  Text(
                    'B R E M',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 65,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
