// ignore: file_names
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/PreviewModel.dart';
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
  List _search = [];
  List get search => _search;

  List _cocktails = [];
  List get cocktails => _cocktails;
  List _searchedImage = [];
  List get searchedImage => _searchedImage;
  List _searchedList = [];
  List get searchedList => _searchedList;
  late List cocktailContent;
  var string;
  var string2;
  var string3;
    PreviewModel? preview;
  AuthRepo authRepo= AuthRepo();


CockTailsModel cockTailDrink = CockTailsModel();

  Future<Iterable> getAlcoholicContent() async {
      Response? response =  alcoholicDrink == 1  ?  await authRepo.filterCockTail():await authRepo.filterNonAlcoholicCockTail();
      if (response != null) {
        _cocktails = response.data['drinks'];
        string = _cocktails.map((product) => product,
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
  Future hassan () async{
    preview = PreviewModel(name: mapList[0]['strDrink'], description: mapList[0]["strInstructions"]);
    return preview!.name;
  }



  Future<Iterable> searchDrink() async {
    Response? response =  await authRepo.searchCocktail(searchController.text);
    if (response != null) {
      _search = response.data['drinks'];
      string3 = _search.map((product) => product,
      );
      print('hello 3fkkh;ihhi${string3}');
      return string3;

    }
    throw 'something went wrong';
  }
  Future<void> searchContent() async {
    _isLoadingPost = true;
    notifyListeners();
    final response = await searchDrink();
    _searchedList= response.toList(growable: true);
    _isLoadingPost = false;
    notifyListeners();
  }
}
