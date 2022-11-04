
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

  // void _checkPayment() {
  //   try {
  //     PaystackPayManager(context: context)
  //       ..setSecretKey("YOUR-SECRET-KEY")
  //     // ..setCompanyAssetImage(Image(image: NetworkImage("YOUR-IMAGE-URL")))
  //       ..setAmount(100000)
  //       ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
  //       ..setCurrency("NGN")
  //       ..setEmail("samuelbeebest@gmail.com")
  //       ..setFirstName("Samuel")
  //       ..setLastName("Adekunle")
  //       ..setMetadata(
  //         {
  //           "custom_fields": [
  //             {
  //               "value": "TechWithSam",
  //               "display_name": "Payment_to",
  //               "variable_name": "Payment_to"
  //             }
  //           ]
  //         },
  //       )
  //       ..onSuccesful(_onPaymentSuccessful)
  //       ..onPending(_onPaymentPending)
  //       ..onFailed(_onPaymentFailed)
  //       ..onCancel(_onCancel)
  //       ..initialize();
  //   } catch (error) {
  //     print('Payment Error ==> $error');
  //   }
  // }
  //
  // void _onPaymentSuccessful(Transaction transaction) {
  //   print('Transaction succesful');
  //   print(
  //       "Transaction message ==> ${transaction.message}, Ref ${transaction.refrenceNumber}");
  // }
  //
  // void _onPaymentPending(Transaction transaction) {
  //   print('Transaction Pending');
  //   print("Transaction Ref ${transaction.refrenceNumber}");
  // }
  //
  // void _onPaymentFailed(Transaction transaction) {
  //   print('Transaction Failed');
  //   print("Transaction message ==> ${transaction.message}");
  // }
  //
  // void _onCancel(Transaction transaction) {
  //   print('Transaction Cancelled');
  // }





  void verifyOTP() async {

  }
  void signOut(BuildContext context) async {

  }
}

















