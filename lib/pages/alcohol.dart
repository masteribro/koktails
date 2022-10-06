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
  AuthRepo repo =  AuthRepo();
  CockTailsModel cockTails = CockTailsModel();
  @override
  void initState() {

    super.initState();
    context.read<AuthProvider>().getAlcoholicContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: context.read<AuthProvider>().getAlcoholicContent(),
          builder: (context, snapshot){
            if (snapshot.connectionState== ConnectionState.done){
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Text("got null");
                },
              );
            }return const Center(child: LinearProgressIndicator());
          }

      ),
    );
  }
}
