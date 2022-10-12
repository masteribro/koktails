import 'package:flutter/material.dart';
import 'colors.dart';

class Constants {
  static const String boxName = 'Cocktail';


  static const String baseUrl = 'https://www.thecocktaildb.com/api/json/v1/1/';




   static const TextStyle myStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15.0,
    color: Colors.black,
  );

  static BoxDecoration errorBoxDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    border: Border.all(color: Colors.red, width: 0.5),
  );

  static InputDecoration inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    labelStyle: const TextStyle(color: AppColors.primary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(0.0),
      borderSide: const BorderSide(color: AppColors.primary),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(width: 0.5, color: AppColors.primary),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      borderSide: BorderSide(width: 0.5, color: AppColors.primary),
    ),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(width: 0.5, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        borderSide: BorderSide(width: 0.5, color: Colors.redAccent)),
  );

  static BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    border: Border.all(color: AppColors.primary, width: 0.5),
  );

  static InputDecoration defaultDecoration = const InputDecoration(
    border: UnderlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: AppColors.primary)
    )
  );

  static InputDecoration noneDecoration = const InputDecoration(
    border: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(width: 0, color: Colors.transparent)
    ),
  );
}