import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class FavouriteIcon extends StatefulWidget {
  FavouriteIcon({Key? key, required this.valueChanged}) : super(key: key);
 Function valueChanged;
  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  @override

  bool moh = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed :(){

          widget.valueChanged(moh);
          setState((){
            moh = !moh;
          });
        },
        icon: moh ? Icon(Icons.favorite,color: Colors.orangeAccent,):Icon(Icons.favorite,));
  }
}
