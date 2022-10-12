import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/soccer_model.dart';
import '../repository/auth_repo.dart';
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
  CockTailsModel drink = CockTailsModel();

  AuthProvider? _authProvider;





  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context,listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: FutureBuilder(
          future: _authProvider?.getAlcoholicDrinks(),
          builder: (context, snapshot){
            if (snapshot.connectionState== ConnectionState.done){
              return Consumer<AuthProvider>(
                builder: (_,value,__){
                  final cockTailDrink = value.mapList;
                  return  ListView.builder(
                    itemCount: cockTailDrink.length,
                    itemBuilder: (context, index) {
                      final cocktail = cockTailDrink[index];
                      return ListTile(
                        title: Text(cocktail.toString()),
                        leading: CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: Text('${index + 1}'),
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
