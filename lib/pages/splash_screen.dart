import 'package:all_implement_project/auth_page/sign_in_page.dart';
import 'package:all_implement_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    navigateToNextScreen();
    super.initState();
  }

  navigateToNextScreen() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    final data = sf.get("userData");

    if (data != null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          "https://www.shutterstock.com/image-vector/clipart-earth-illustration-vector-globe-600nw-2321935235.jpg",
          height: 100,
        ),
      ),
    );
  }
}
