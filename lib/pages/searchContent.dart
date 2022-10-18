import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/Model/PreviewModel.dart';
import 'package:soccer_app/constants/colors.dart';

import '../state/auth_state.dart';

class SearchContent extends StatefulWidget {
  const SearchContent({Key? key, }) : super(key: key);


  @override
  State<SearchContent> createState() => _SearchContentState();
}
class _SearchContentState extends State<SearchContent> {
  AuthProvider _authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    getContent = _authProvider.searchDrink();

  }
  late Future<SearchModel?> getContent;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainGreen,

        title: Text('${_authProvider.search?.drinks?[0].strDrink}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: getContent,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState== ConnectionState.done) {
                      return Consumer<AuthProvider>(
                          builder: (_,value,__){
                            final searchDrink = value.search?.drinks?[0];

                            return Column(
                              children: [
                                Container(
                                    width: 300,
                                    height: 300,
                                    child: Image.network("${searchDrink?.strDrinkThumb}")
                                ),
                                const SizedBox(height: 10,),
                                const Text('Ingredient:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                const SizedBox(height: 10,),
                                Text(searchDrink?.strIngredient1?? '',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                Text(searchDrink?.strIngredient2?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                Text(searchDrink?.strIngredient3?? '',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                Text(searchDrink?.strIngredient4?? '',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                Text(searchDrink?.strIngredient5?? '',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                                const SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Category:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                    const SizedBox(width: 10,),
                                    Text(searchDrink?.strCategory?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15,

                                    ),),

                                  ],
                                ),
                                const Text('Instructions:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                Text("${searchDrink?.strInstructions}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
