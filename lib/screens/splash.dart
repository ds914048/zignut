
import 'dart:async';
import 'package:elememt3zignuts/screens/sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  bool isLoading = true;

  @override
  void initState() {
    isLoading = false;
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElasticInDown(
                child: ZoomIn(
                  duration: const Duration(seconds: 2),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: MediaQuery.of(context).size.height*0.2,
                      ),
                      const SizedBox(height: 15,),
                      Image.asset(
                        "assets/images/nameLogo.png",
                        height: MediaQuery.of(context).size.height*0.15,

                      ),
                    ],
                  ),
                ),
                duration: const Duration(seconds: 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getBool("isLoggedIn")==true){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Home()));
    }else{
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignIn()));

    }



    }


}
