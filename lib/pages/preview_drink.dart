import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/PreviewModel.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class PreviewCocktail extends StatefulWidget {
  const PreviewCocktail({Key? key, required this.previewModel, required this.description, required this.image}) : super(key: key);
 final String previewModel;
 final String description;
 final String image;
  @override
  State<PreviewCocktail> createState() => _PreviewCocktailState();
}

class _PreviewCocktailState extends State<PreviewCocktail> {
  AuthProvider? _authProvider;
  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context,listen: false);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(widget.previewModel),
      ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children:  [
           const SizedBox(height: 20,),
           Image.network(widget.image),
           const SizedBox(height: 20,),
           Text(widget.description)

         ],
       ),
    );
  }
}
