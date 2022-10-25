import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/constants/colors.dart';

import '../Home.dart';
import '../main.dart';
import '../notification/Notification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool master = true;
  void navigateToNextPage(context) async {
    if(master == true){
      Noti.showBigTextNotification(title: "Welcome back", body: "Explore the world of koktails ", fln: flutterLocalNotificationsPlugin);

      Timer( const Duration(seconds: 26), () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home(


            )),
      ) );
    }else{
      null;
    }

  }
  var size,height,width;
  @override
  void initState() {
    super.initState();
    navigateToNextPage(context);
    Noti.initialize(flutterLocalNotificationsPlugin);
  }
  @override
  Widget build(BuildContext context) {
    navigateToNextPage(context);
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: AppColors.mainGreen,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

        Image.asset('assets/images/image13.gif',
          height: 200,
          width: 200,
       ),

        const SizedBox(height: 30,),
          const Align(
            alignment: Alignment.center,
            child: Text('Cocktail',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
          ),
          SizedBox(height: 30,),
          Align(
              alignment: Alignment.center,
              child: Text('Loading.......',
              style: TextStyle(
                  color: Colors.white
              ),
              )),
        ],
      ),
    );
  }
}
