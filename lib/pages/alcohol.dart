import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/Utils/IconButton.dart';
import 'package:soccer_app/constants/colors.dart';
import 'package:soccer_app/pages/preview_drink.dart';
import 'package:soccer_app/widget/favouriteButton.dart';
import '../Controller/controller.dart';
import '../Model/soccer_model.dart';
import '../Utils/LocalStorage.dart';
import '../Utils/router.dart';
import '../Utils/validation.dart';
import '../state/auth_state.dart';
import 'favouritePage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Alcohol extends StatefulWidget {
  const Alcohol({Key? key}) : super(key: key);

  @override
  State createState() => _AlcoholState();
}

class _AlcoholState extends StateMVC<Alcohol> with ValidationMixin {
  _AlcoholState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;


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
  bool moh = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainGreen,
        centerTitle: true,
        title: const Text('List of Cocktails'),
        actions:  [
          InkWell(
              onTap: (){
                Routers.push(context, const FavoritePage());
              },
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.favorite),
              ))
        ],
      ),
      body: FutureBuilder<ListOfDrinks>(
          future: getContent,
          builder: (context, snapshot){
            if (snapshot.connectionState== ConnectionState.done){
              return Consumer<AuthProvider>(
                builder: (_,value,__){
                  return  ListView.builder(
                    itemCount: value.listOfDrinks?.drinks?.length,
                    itemBuilder: (context, index) {
                      var cocktail = value.listOfDrinks?.drinks![index];
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
                          trailing: FavouriteIcon(

                            valueChanged: (bool currentState){

                              value.hassan = index;
                              value.ibrahim = value.listOfDrinks?.drinks![value.hassan].strDrink;
                              if (currentState){
                                value.removeFromFavourites(value.ibrahim);

                                value.displayMessage(context, "Item removed");
                              } else {
                                var trending = value.addToFavourites(value.ibrahim);
                                value.displayMessage(context, "Successfully added to your list");
                              }
                            },
                          ),
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
