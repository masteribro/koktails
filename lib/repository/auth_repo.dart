
import 'package:dio/dio.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import '../Model/PreviewModel.dart';
import '../Model/randomCocktail.dart';
import '../Utils/service.dart';

class AuthRepo with Services {

  Future<ListOfDrinks?> filterCockTail() async {
    Response? response = await apiGetRequests(
      'filter.php?a=Alcoholic'
    );
    if (response != null) {
      return ListOfDrinks.fromJson(response.data);
    }

    return null;
  }
  Future<ListOfDrinks?> filterNonAlcoholicCockTail() async {
    Response? response = await apiGetRequests(
        'filter.php?a=Non_Alcoholic'
    );
    if (response != null) {
      return ListOfDrinks.fromJson(response.data);
    }

    return null;
  }
  Future<RandomCocktail?> randomCockTail() async {
    Response? response = await apiGetRequests(
        'random.php'
    );
    if (response != null) {
      print("ghjgvj${response}");
      return RandomCocktail.fromJson(response.data);
    }
    return null;
  }
  Future<SearchModel?> searchCocktail(String cocktail) async {
    Response? response = await apiGetRequests(
        'search.php?s=$cocktail'
    );
    if (response != null) {
      return SearchModel.fromJson(response.data);
    }
    return null;
  }

  Future<Map<String, dynamic>?> login(Map<String, String> credentials) async {
    Map<String, dynamic>? response = await apiPostRequests("user/login", credentials);
    if (response != null) {
      return response;
    }
    return null;
  }

  Future<Map<String, dynamic>?> register(Map<String, String> credentials) async {
    Map<String, dynamic>? response = await apiPostRequests("user/register", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> phoneVerification(Map<String, String> credentials) async {
    Map<String, dynamic>? response = await apiPostRequests("user/register/send-otp", credentials);

    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Map<String, dynamic>?> otpVerification(Map<String, dynamic> credentials) async {
    Map<String, dynamic>? response = await apiPostRequests("user/register/validate-otp", credentials);

    if (response != null) {


      return response;
    }

    return null;
  }
}
