import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(_authProvider.searchedList[0]['strDrink']),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder(
                future: _authProvider.searchContent(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState== ConnectionState.done) {
                    return Consumer<AuthProvider>(
                        builder: (_,value,__){
                          final searchDrink = value.searchedList;
                          return Column(
                            children: [
                              Container(
                                  width: 300,
                                  height: 300,
                                  child: Image.network("${searchDrink[0]["strDrinkThumb"]}")

                              ),
                              SizedBox(height: 10,),
                              Text("${searchDrink[0]["strInstructions"]}"),
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
    );
  }
}
