
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:greenlive/core/config/storage/storage.dart';
import 'package:lottie/lottie.dart';


Future<void> _messageHandler(RemoteMessage message) async {
  
  print('background message ${message.notification.body}');
}
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool islogged;
  @override
  void initState(){
    super.initState();
    checklogin();
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
  }
  Future<void> checklogin()async{
    islogged = await Storage.getBooleans("logged");
    Future.delayed(
      Duration(seconds: 5),
      () {
        if (islogged) {
          Navigator.pushReplacementNamed(context, "tohome");
        } else {
          Navigator.pushReplacementNamed(context, "tosignview");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 500,
        height:500,
        child: LottieBuilder.asset("assets/splash/splash.json"),
      ),
    );
  }
}
