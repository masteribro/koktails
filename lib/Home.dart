import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/Utils/router.dart';
import 'package:soccer_app/constants/colors.dart';
import 'package:soccer_app/pages/alcohol.dart';
import 'package:soccer_app/pages/searchContent.dart';
import 'package:soccer_app/pages/suggestedCocktail.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:soccer_app/state/auth_state.dart';
import 'package:provider/provider.dart';

import 'Model/randomCocktail.dart';
import 'Utils/LocalStorage.dart';
import 'Utils/gridCard.dart';
import 'constants/global variable.dart';
import 'main.dart';
import 'notification/Notification.dart';


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
    random = _authProvider.getAlcoholicContent();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }
  int intValue = 0;
  Future <ListOfDrinks?>? random;

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    // getting the size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      color: AppColors.mainGreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              InkWell(child: CircleAvatar()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text('What cocktail are you interested in?', style: TextStyle(
                                fontSize: 20,
                                color: AppColors.greyWhite,
                              ),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(
                              cursorColor: Colors.blueGrey,
                              controller: searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.greyWhite,
                                suffixIcon: InkWell(
                                    onTap: ()=>Routers.push(context, const SearchContent()),
                                    child: const Icon(Icons.search,color: AppColors.bgGrey1,)),
                                border: const OutlineInputBorder(
                                ),
                                hintText: 'Enter to search for a Cocktail',
                                hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.greyWhite), //<-- SEE HERE

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.mainBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(

                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap:(){},
                                    child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Category')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      setState((){
                                        alcoholicDrink = 1;
                                      });
                                      Routers.push(context, const Alcohol());
                                    },
                                    child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Alcoholic')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      setState((){
                                        alcoholicDrink = 0;
                                      });
                                      Routers.push(context, const Alcohol());
                                    },
                                   child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Non-Alcoholic')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     ElevatedButton(
                              //         style: ElevatedButton.styleFrom(
                              //           primary: AppColors.mainGreen, // background
                              //           // foreground
                              //         ),
                              //         onPressed: (){
                              //           Provider.of<AuthProvider>(context,listen:false).randomDrink();
                              //           Routers.push(context, const SuggestedDrink());
                              //         },
                              //         child: const Text('Random Button'))
                              //   ],
                              // ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Trending Cocktails ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 20,),
                              FutureBuilder(
                                future: random,
                                builder: ( context,  snapshot)
                                {
                                  if (snapshot.connectionState== ConnectionState.done) {
                                    return Consumer<AuthProvider>(
                                      builder: (_,value,__){
                                        var rng = Random();
                                        var listOfDrink = value.listOfDrinks?.drinks?.sublist(rng.nextInt(10)+20,rng.nextInt(25)+31);

                                        return GridView.count(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 60.0,
                                          mainAxisSpacing: 60.0,
                                          children: List.generate(listOfDrink?.length ?? 0, (index) {
                                            return Card(
                                              elevation: 50,
                                              shadowColor: AppColors.mainGreen,
                                                child: Container(child: Image.network("${listOfDrink?[index].strDrinkThumb}"))
                                            );
                                          }),
                                        );
                                      },

                                    );
                                  } else if (snapshot.hasError) {
                                    return Column(
                                      children: [
                                        Text('${snapshot.error}'),
                                      ],
                                    );

                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          )
        ),
      ),

    );
  }
}
