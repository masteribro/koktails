import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/constants/colors.dart';
import 'package:soccer_app/pages/preview_drink.dart';
import '../Model/soccer_model.dart';

import '../state/auth_state.dart';

class Alcohol extends StatefulWidget {
  const Alcohol({Key? key}) : super(key: key);

  @override
  State<Alcohol> createState() => _AlcoholState();
}

class _AlcoholState extends State<Alcohol> {



  getMeth()async{
    await Provider.of<AuthProvider>(context,listen: false).getAlcoholicContent();
  }


  AuthProvider? _authProvider;
  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    getContent =  _authProvider!.getAlcoholicContent();
    super.initState();
  }
  late Future<ListOfDrinks> getContent;
ListOfDrinks list = ListOfDrinks();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ListOfDrinks>(
          future: getContent,
          builder: (context, snapshot){
            if (snapshot.connectionState== ConnectionState.done){
              return Consumer<AuthProvider>(
                builder: (_,value,__){
                  return  ListView.builder(
                    itemCount: value.listOfDrinks?.drinks?.length,
                    itemBuilder: (context, index) {
                      final cocktail = value.listOfDrinks?.drinks![index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviewCocktail(
                                previewModel: cocktail?.strDrink??'',
                                description:  cocktail?.strDrink??'',
                                image:  cocktail?.strDrinkThumb??'',
                              )),
                            );
                        },
                        child: ListTile(
                          title: Text("${cocktail?.strDrink}"),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.mainGreen,
                            child: Text('${index + 1}', style: const TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      );
                    },
                  );
                },
              );

            }

          return const Center(child: LinearProgressIndicator());
          }
          ),


    );

  }
}
