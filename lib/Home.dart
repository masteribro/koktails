import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soccer_app/Model/soccer_model.dart';
import 'package:soccer_app/Utils/router.dart';
import 'package:soccer_app/constants/colors.dart';
import 'package:soccer_app/pages/alcohol.dart';
import 'package:soccer_app/pages/searchContent.dart';
import 'package:soccer_app/repository/auth_repo.dart';
import 'package:soccer_app/state/auth_state.dart';
import 'package:provider/provider.dart';
import 'constants/global variable.dart';
import 'main.dart';
import 'notification/Notification.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
String backendUrl = '{YOUR_BACKEND_URL}';
String paystackPublicKey = 'pk_test_c64a6c46528fd8e5a950de53c511ec5204eb814e';
const String appName = 'Payment page';


class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  AuthRepo repo =  AuthRepo();

  AuthProvider _authProvider = AuthProvider();

  final plugin = PaystackPlugin();
  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: paystackPublicKey);
    _authProvider = Provider.of<AuthProvider>(context,listen: false);
    random = _authProvider.getAlcoholicContent();
    Noti.initialize(flutterLocalNotificationsPlugin);

  }
  int intValue = 0;
  Future <ListOfDrinks?>? random;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _verticalSizeBox = const SizedBox(height: 20.0);
  final _horizontalSizeBox = const SizedBox(width: 10.0);
  bool get _isLocal => _radioValue ==0 ;
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
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    // getting the size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
                      color: AppColors.mainGreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: const [
                              InkWell(child: CircleAvatar()),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: const [
                              Text('What cocktail are you interested in?', style: TextStyle(
                                fontSize: 20,
                                color: AppColors.greyWhite,
                              ),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: TextField(
                              cursorColor: Colors.blueGrey,
                              controller: searchController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.greyWhite,
                                suffixIcon: InkWell(
                                    onTap: ()=>Routers.push(context, const SearchContent()),
                                    child: const Icon(Icons.search,color: AppColors.bgGrey1,)),
                                border: const OutlineInputBorder(
                                ),
                                hintText: 'Enter to search for a Cocktail',
                                hintStyle: Theme.of(context).textTheme.caption?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: AppColors.greyWhite), //<-- SEE HERE

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      color: AppColors.mainBackground,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(

                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap:(){
                                      handleCheckout(context);
                                    },
                                    child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Category')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      setState((){
                                        alcoholicDrink = 1;
                                      });
                                      Routers.push(context, const Alcohol());
                                    },
                                    child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Alcoholic')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap:(){
                                      setState((){
                                        alcoholicDrink = 0;
                                      });
                                      Routers.push(context, const Alcohol());
                                    },
                                   child: Container(
                                      height: 50.0,
                                      width: 100.0,
                                      child: Center(child: Text('Non-Alcoholic')),
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.circular(10.0),
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.black12,
                                                Colors.white70
                                              ]
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey ,
                                                blurRadius: 2.0,
                                                offset: Offset(2.0,2.0)
                                            )
                                          ]
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     ElevatedButton(
                              //         style: ElevatedButton.styleFrom(
                              //           primary: AppColors.mainGreen, // background
                              //           // foreground
                              //         ),
                              //         onPressed: (){
                              //           Provider.of<AuthProvider>(context,listen:false).randomDrink();
                              //           Routers.push(context, const SuggestedDrink());
                              //         },
                              //         child: const Text('Random Button'))
                              //   ],
                              // ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Trending Cocktails ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                ],
                              ),
                              SizedBox(height: 20,),
                              FutureBuilder(
                                future: random,
                                builder: ( context,  snapshot)
                                {
                                  if (snapshot.connectionState== ConnectionState.done) {
                                    return Consumer<AuthProvider>(
                                      builder: (_,value,__){
                                        var rng = Random();
                                        var listOfDrink = value.listOfDrinks?.drinks?.sublist(rng.nextInt(10)+20,rng.nextInt(25)+31);

                                        return GridView.count(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 60.0,
                                          mainAxisSpacing: 60.0,
                                          children: List.generate(listOfDrink?.length ?? 0, (index) {
                                            return Card(
                                              elevation: 50,
                                              shadowColor: AppColors.mainGreen,
                                                child: Container(child: Image.network("${listOfDrink?[index].strDrinkThumb}"))
                                            );
                                          }),
                                        );
                                      },

                                    );
                                  } else if (snapshot.hasError) {
                                    return Column(
                                      children: [
                                        Text('${snapshot.error}'),
                                      ],
                                    );

                                  }
                                  return const CircularProgressIndicator();
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          )
        ),
      ),

    );
  }
  void _handleRadioValueChanged(int? value) {
    if (value != null) setState(() => _radioValue = 0);
  }
  handleCheckout(BuildContext context) async {
    // if (_method !=  _isLocal) {
    //   _showMessage('Select server initialization method at the top');
    //   return;
    // }
    setState(() => _inProgress = true);
    _formKey.currentState?.save();
    Charge charge = Charge()
      ..amount = 200 // In base currency
      ..email = 'mohammedibrahim075@gmail.com'
      ..card = _getCardFromUI();
    charge.reference = _getReference();
    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      // _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Your transaction was not successful");
      rethrow;
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
        "kok",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
