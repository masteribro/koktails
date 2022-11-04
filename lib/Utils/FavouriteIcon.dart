import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Utils/LocalStorage.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';



class FavouriteIcon extends StatefulWidget {
  final String idOfIcon;
  FavouriteIcon({Key? key, required this.valueChanged, this.idOfIcon = ""}) : super(key: key);
 Function valueChanged;

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}
class _FavouriteIconState extends State<FavouriteIcon> {
  bool moh = false;
  AuthProvider? _authProvider;
  @override
  void initState() {
    moh = Provider.of<AuthProvider>(context,listen: false).changeIconBool(widget.idOfIcon);
    debugPrint("Moh is set to: $moh for ${widget.idOfIcon} from ChangeIconBool");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed :(){
          setState((){
            moh = !moh;
          });
          widget.valueChanged(moh);
        },
        icon: moh ? Icon(Icons.favorite,color: Colors.orangeAccent,):Icon(Icons.favorite,));
  }
}
