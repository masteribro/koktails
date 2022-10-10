// ignore: file_names
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:dio/dio.dart';
import '../Utils/LocalStorage.dart';

AuthRepo authRepo= AuthRepo();

class AuthProvider extends ChangeNotifier {
  bool _isLoadingPost = false;
  bool get isLoadingPost => _isLoadingPost;
  List _mapList = [];
  List get mapList => _mapList;
  late List _json;
  List get json => _json;
  List _cocktails = [];
  List get cocktails => _cocktails;
  late List cocktailContent;
  var string;

CockTailsModel cockTailDrink = CockTailsModel();
  // Drinks drinks = Drinks();

  Future<Iterable> getAlcoholicContent() async {
      Response? response = await authRepo.filterCockTail();
      if (response != null) {
        await LocalStorage().store('comment_data', response.data['drinks']);
        _cocktails = await LocalStorage().fetch("comment_data");
        string = _cocktails.map((product) => product['strDrink'],
        );
        print('nie$string');
        return string;
      }
      throw 'something went wrong';
  }
  Future<void> getAlcoholicDrinks() async {
    _isLoadingPost = true;
    notifyListeners();
    final response = await getAlcoholicContent();
    _mapList= response.toList(growable: true);
    _isLoadingPost = false;
    notifyListeners();
  }


}
