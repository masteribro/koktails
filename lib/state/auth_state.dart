// ignore: file_names
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/PreviewModel.dart';
import 'package:soccer_app/Model/randomCocktail.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import '../constants/global variable.dart';
class AuthProvider extends ChangeNotifier {
  int hassan = 0;
  var ibrahim;
  bool _favorite = false;
  bool get favorite => _favorite;
  List _favoriteDrinks = [];
  List get favoriteDrinks => _favoriteDrinks;
  bool _isLoadingPost = false;
  bool get isLoadingPost => _isLoadingPost;
  final bool _favourite = false;
  bool get favourite => _favourite;
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
      notifyListeners();
      throw 'something went wrong';
  }

  Future<SearchModel?> searchDrink() async {
    _search =  await authRepo.searchCocktail(searchController.text) ;
    if (_search != null) {

      return  _search;
    }
    notifyListeners();
    throw 'something went wrong';
  }

  void addToFavourites(String drink){
    _favoriteDrinks.add(drink);
    print(_favoriteDrinks);
    notifyListeners();
  }

  void removeFromFavourites(String drink){
    _favoriteDrinks.removeLast();
    print(_favoriteDrinks);
    notifyListeners();
  }

  Future<RandomCocktail?> randomDrink() async {
    _random =  await authRepo.randomCockTail() ;
    notifyListeners();
    if (_random != null) {
      notifyListeners();
      return  _random;
    }
    notifyListeners();
    throw 'something went wrong';
  }
  void displayMessage(context, String text ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        duration: Duration(seconds: 2),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Text(text,
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );

  }
}
