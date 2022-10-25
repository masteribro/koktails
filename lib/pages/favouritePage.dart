import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_app/constants/colors.dart';
import '../state/auth_state.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Items'),
        centerTitle: true,
        backgroundColor: AppColors.mainGreen,
      ),
      body: Consumer<AuthProvider>(
        builder: (_,value,__)
          {return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: value.favoriteDrinks.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${value.favoriteDrinks[index]}',
                  textAlign: TextAlign.center,),
                );

              }
          );
        }

      ),
    );
  }
}
