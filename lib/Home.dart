import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Utils/router.dart';
import 'package:soccer_app/pages/alcohol.dart';
import 'package:soccer_app/repository/auth_repo.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  AuthRepo repo =  AuthRepo();
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          repo.filterCockTail('Alcoholic');
          Routers.push(context, Alcohol());


        }, child: Text('Alcoholic')),
      ),

    );
  }
}
