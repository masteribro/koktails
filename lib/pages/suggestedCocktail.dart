import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/Model/randomCocktail.dart';
import '../state/auth_state.dart';

class SuggestedDrink extends StatefulWidget {
  const SuggestedDrink({Key? key}) : super(key: key);

  @override
  State<SuggestedDrink> createState() => _SuggestedDrinkState();
}

class _SuggestedDrinkState extends State<SuggestedDrink> {
  AuthProvider? _authProvider;
  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context,listen:false);
    random = _authProvider?.randomDrink();
    super.initState();

  }
   Future <RandomCocktail?>? random;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children:[
          FutureBuilder(
            future: random,
            builder: ( context,  snapshot)
            {
              if (snapshot.connectionState== ConnectionState.done) {
                return Consumer<AuthProvider>(
                    builder: (_,value,__){
                      final randomDrink = value.random?.drinks?[0];
                      return Column(
                        children: [
                          Text(
                            randomDrink?.idDrink ?? "",
                            style: TextStyle(color: Colors.black),
                          ),
                          Container(
                              width: 300,
                              height: 300,
                              child: Image.network("${randomDrink?.strDrinkThumb}")
                          ),

                        ],
                      );
                    }
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
          )
        ],
      ) ,
    );
  }
}
