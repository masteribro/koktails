// ignore: file_names
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/PreviewModel.dart';
import 'package:soccer_app/Model/randomCocktail.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:dio/dio.dart';
import '../constants/global variable.dart';
class AuthProvider extends ChangeNotifier {
  bool _isLoadingPost = false;
  bool get isLoadingPost => _isLoadingPost;
  List _mapList = [];
  List get mapList => _mapList;
  SearchModel? _search;
  SearchModel? get search => _search;
  RandomCocktail? _random;
  RandomCocktail? get random => _random;

  List _cocktails = [];
  List get cocktails => _cocktails;
  List _searchedImage = [];
  List get searchedImage => _searchedImage;
  List? _searchedList ;
  List? get searchedList => _searchedList;
  late List cocktailContent;
  var string;
  var string2;
  var string3;

  AuthRepo authRepo= AuthRepo();
  ListOfDrinks? get listOfDrinks => _listOfDrinks;
  ListOfDrinks? _listOfDrinks;




  Future<ListOfDrinks> getAlcoholicContent() async {
      _listOfDrinks =  alcoholicDrink == 1  ?  await authRepo.filterCockTail():await authRepo.filterNonAlcoholicCockTail();
      if (_listOfDrinks != null) {
        return _listOfDrinks!;
      }
      throw 'something went wrong';
  }

  Future<SearchModel?> searchDrink() async {
    _search =  await authRepo.searchCocktail(searchController.text) ;
    if (_search != null) {

      return  _search;
    }
    throw 'something went wrong';
  }


  Future<RandomCocktail?> randomDrink() async {
    _random =  await authRepo.randomCockTail() ;
    notifyListeners();
    print("hell$_random");
    if (_random != null) {

      return  _random;

    }
    throw 'something went wrong';
  }

}
