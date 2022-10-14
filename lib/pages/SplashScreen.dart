import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/constants/colors.dart';

import '../Home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool master = true;
  void navigateToNextPage(context) async {
    if(master == true){
      Timer( const Duration(seconds: 26), () => Navigator.push(
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
