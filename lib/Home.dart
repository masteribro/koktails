import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Utils/router.dart';
import 'package:soccer_app/constants/colors.dart';
import 'package:soccer_app/pages/alcohol.dart';
import 'package:soccer_app/pages/searchContent.dart';
import 'package:soccer_app/pages/suggestedCocktail.dart';
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

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainGreen,
        title: Text('Home',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.mainGreen, // background
                // foreground
              ),
              onPressed: (){
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.mainGreen),
                padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                );


            setState((){
              alcoholicDrink = 1;
            });
            Routers.push(context, const Alcohol());
          }, child: const Text('Alcoholic Drinks')),
          ElevatedButton(
          style: ElevatedButton.styleFrom(
          primary: AppColors.mainGreen, // background
           // foreground
               ),
              onPressed: (){

            setState((){
              alcoholicDrink = 0;
            });
            Routers.push(context, Alcohol());
          }, child: const Text('Non-Alcoholic Drinks')),
          SizedBox(height: 10,),

          Row(
            children: [
              Expanded(
                child:   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter to search for a Cocktail',
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   primary: AppColors.mainGreen, // background
                   // foreground
                 ),
                 onPressed: (){

               Routers.push(context, SearchContent());
             },
                 child: const Text('Search Button'))
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.mainGreen, // background
                    // foreground
                  ),
                  onPressed: (){
                    Routers.push(context, const SuggestedDrink());
                  },
                  child: const Text('Random Button'))
            ],
          )

        ],
      ),

    );
  }
}
