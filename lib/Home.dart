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
  int intValue = 0;
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
                    color: AppColors.mainGreen,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              CircleAvatar(),
                              SizedBox(
                                width: 300,
                              ),
                              CircleAvatar(),
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
                              cursorColor: AppColors.greyWhite,
                              controller: searchController,
                              decoration: InputDecoration(

                                suffixIcon: InkWell(
                                    onTap: ()=>Routers.push(context, SearchContent()),
                                    child: const Icon(Icons.search,color: AppColors.bgGrey1,)),

                                border: const OutlineInputBorder(

                                ),
                                hintText: 'Enter to search for a Cocktail',
                                hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.greyWhite
                                ),
                                enabledBorder: const OutlineInputBorder(
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
                    child: Column(

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
                              Routers.push(context, const Alcohol());
                            }, child: const Text('Non-Alcoholic Drinks')),
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

                                },
                                child: const Text('Search Button'))
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
                                  Provider.of<AuthProvider>(context,listen:false).randomDrink();
                                  Routers.push(context, const SuggestedDrink());
                                },
                                child: const Text('Random Button'))
                          ],
                        )

                      ],
                    )),

              ],
            ),
          )
        ),
      ),

    );
  }
}
