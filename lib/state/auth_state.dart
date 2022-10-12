// ignore: file_names
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:dio/dio.dart';
import '../Home.dart';
import '../Utils/LocalStorage.dart';
import '../constants/global variable.dart';




class AuthProvider extends ChangeNotifier {
  bool _isLoadingPost = false;
  bool get isLoadingPost => _isLoadingPost;
  List _mapList = [];
  List get mapList => _mapList;

  List _cocktails = [];
  List get cocktails => _cocktails;
  late List cocktailContent;
  var string;
  var string2;
  AuthRepo authRepo= AuthRepo();


CockTailsModel cockTailDrink = CockTailsModel();

  Future<Iterable> getAlcoholicContent() async {
      Response? response =  alcoholicDrink == 1  ?  await authRepo.filterCockTail():await authRepo.filterNonAlcoholicCockTail();
      if (response != null) {
        _cocktails = response.data['drinks'];
        string = _cocktails.map((product) => product['strDrink'],
        );
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


  Future<Iterable> searchDrink() async {
    Response? response =  await authRepo.searchCocktail(searchController.text);
    if (response != null) {
      _cocktails = response.data['drinks'];
      string2 = _cocktails.map((product) => product['strDrink'],
      );
      print('hello hi${string2}');
      return string2;

    }
    throw 'something went wrong';
  }


}
