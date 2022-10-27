
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../Model/authmodel.dart';
import '../Utils/FlushBarMixin.dart';
import '../repository/auth_repo.dart';



class AuthController extends ControllerMVC with FlushBarMixin {
  factory AuthController([StateMVC? state]) =>
      _this ??= AuthController._(state);


  AuthController._(StateMVC? state)
      : model = AuthModel(),
        super(state);
  static AuthController? _this;

  final AuthModel model;

  final AuthRepo authRepo = AuthRepo();

  void signIn() async {

  }




  void verifyOTP() async {

  }
  void signOut(BuildContext context) async {

  }
}

















