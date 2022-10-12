
import 'package:dio/dio.dart';
import '../Utils/service.dart';

class AuthRepo with Services {

  Future<Response?> filterCockTail() async {
    Response? response = await apiGetRequests(
      'filter.php?a=Alcoholic'
    );
    if (response != null) {
      return response;
    }

    return null;
  }
  Future<Response?> filterNonAlcoholicCockTail() async {
    Response? response = await apiGetRequests(
        'filter.php?a=Non_Alcoholic'
    );
    if (response != null) {
      return response;
    }

    return null;
  }

  Future<Response?> searchCocktail(String cocktail) async {
    Response? response = await apiGetRequests(
        "search.php?s=$cocktail");

    if (response != null) {
      return response;
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
