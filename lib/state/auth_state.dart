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
   List _cocktails = [];
  List get cocktails => _cocktails;

  Future<List<dynamic>?> getAlcoholicContent() async {
    try {
      _isLoadingPost = true;
      notifyListeners();
      Response? response = await authRepo.filterCockTail('Alcohol');
      if (response != null && response.statusCode == 200) {
        await LocalStorage().store('Alcohol', response.data['data']);
        _mapList = await LocalStorage().fetch("Alcohol");
        _cocktails = _mapList.map((e) => CockTailsModel(drinks: e['drinks'])).toList();

      }
    } catch (e) {}
    _isLoadingPost = false;
    notifyListeners();
    print(_cocktails);
    return  _cocktails;

  }


}
