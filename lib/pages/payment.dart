import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
String backendUrl = '{YOUR_BACKEND_URL}';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance
String paystackPublicKey = 'pk_test_c64a6c46528fd8e5a950de53c511ec5204eb814e';
const String appName = 'Payment page';
class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _verticalSizeBox = const SizedBox(height: 20.0);
  final _horizontalSizeBox = const SizedBox(width: 10.0);
  final plugin = PaystackPlugin();
  bool get _isLocal => _radioValue == 0;
  var _border = new Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.red,
  );
  int _radioValue = 0;
  CheckoutMethod _method = CheckoutMethod.selectable;
  bool _inProgress = false;
  String? _cardNumber;
  String? _cvv;
  int? _expiryMonth;
  int? _expiryYear;

  @override
  void initState() {
    plugin.initialize(publicKey: paystackPublicKey);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  handleCheckout(BuildContext context) async {
    // if (_method != CheckoutMethod.card && _isLocal) {
    //   _showMessage('Select server initialization method at the top');
    //   return;
    // }
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount = 100000 // In base currency
      ..email = 'mohammedibrahim075@gmail.com'
      ..card = _getCardFromUI();

    if (!_isLocal) {
      var accessCode = await _fetchAccessCodeFrmServer(_getReference());
      charge.accessCode = accessCode;
    } else {
      charge.reference = _getReference();
    }

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }



  _chargeCard(Charge charge) async {
    final response = await plugin.chargeCard(context, charge: charge);

    final reference = response.reference;

    // Checking if the transaction is successful
    if (response.status) {
      _verifyOnServer(reference);
      return;
    }

    // The transaction failed. Checking if we should verify the transaction
    if (response.verify) {
      _verifyOnServer(reference);
    } else {
      setState(() => _inProgress = false);
      _updateStatus(reference, response.message);
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );

    //  Using Cascade notation (similar to Java's builder pattern)
    // return PaymentCard(
    //     number: cardNumber,
    //     cvc: cvv,
    //     expiryMonth: expiryMonth,
    //     expiryYear: expiryYear)
    //   ..name = 'Segun Chukwuma Adamu'
    //   ..country = 'Nigeria'
    //   ..addressLine1 = 'Ikeja, Lagos'
    //   ..addressPostalCode = '100001';
    //
    //  Using optional parameters
    // return PaymentCard(
    //     number: cardNumber,
    //     cvc: cvv,
    //     expiryMonth: expiryMonth,
    //     expiryYear: expiryYear,
    //     name: 'Ismail Adebola Emeka',
    //     addressCountry: 'Nigeria',
    //     addressLine1: '90, Nnebisi Road, Asaba, Deleta State');
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = new CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = new ElevatedButton(
        onPressed: function,
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

  Future<String?> _fetchAccessCodeFrmServer(String reference) async {
    String url = '$backendUrl/new-access-code';
    String? accessCode;
    try {
      print("Access code url = $url");
      http.Response response = await http.get(Uri.parse(url));
      accessCode = response.body;
      print('Response for access code = $accessCode');
    } catch (e) {
      setState(() => _inProgress = false);
      _updateStatus(
          reference,
          'There was a problem getting a new access code form'
              ' the backend: $e');
    }

    return accessCode;
  }

  void _verifyOnServer(String? reference) async {
    _updateStatus(reference, 'Verifying...');
    String url = '$backendUrl/verify/$reference';
    try {
      http.Response response = await http.get(Uri.parse(url));
      var body = response.body;
      _updateStatus(reference, body);
    } catch (e) {
      _updateStatus(
          reference,
          'There was a problem verifying %s on the backend: '
              '$reference $e');
    }
    setState(() => _inProgress = false);
  }

  _updateStatus(String? reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () =>
              ScaffoldMessenger.of(context).removeCurrentSnackBar()),
    ));
  }
}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}