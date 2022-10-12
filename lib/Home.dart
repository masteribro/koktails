import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Utils/router.dart';
import 'package:soccer_app/pages/alcohol.dart';
import 'package:soccer_app/pages/searchContent.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:soccer_app/state/auth_state.dart';
import 'package:provider/provider.dart';

import 'constants/global variable.dart';



class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  AuthRepo repo =  AuthRepo();
  AuthProvider _authProvider = AuthProvider();
var search = searchController;
  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context,listen: false);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ElevatedButton(onPressed: (){
                setState((){
                  alcoholicDrink = 1;
                });
                Routers.push(context, const Alcohol());
              }, child: const Text('Alcoholic Drinks')),
              ElevatedButton(onPressed: (){
                setState((){
                  alcoholicDrink = 0;
                });
                Routers.push(context, Alcohol());
              }, child: const Text('Non-Alcoholic Drinks')),
            ],
          ),
          SizedBox(height: 10,),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                ),
              )
            ],
          ),
          Row(
            children: [
             ElevatedButton(onPressed: (){

               Routers.push(context, SearchContent());
             },
                 child: const Text('Search Button'))
            ],
          )

        ],
      ),

    );
  }
}
