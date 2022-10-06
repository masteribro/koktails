
import 'package:dio/dio.dart';
import '../Utils/service.dart';

class AuthRepo with Services {

  Future<Response?> filterCockTail(String type) async {
    Response? response = await apiGetRequests(
      "filter.php?a=$type",
    );

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

      print(response);
      return response;
    }

    return null;
  }
}
