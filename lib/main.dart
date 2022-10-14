import 'package:flutter/material.dart';
import 'package:soccer_app/pages/SplashScreen.dart';
import 'package:soccer_app/state/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> AuthProvider())
  ],
      child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cocktail',
      theme: ThemeData(
      ),
      home:    const SplashScreen(),
    );
  }
}


