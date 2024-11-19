import 'package:ecommerce/viewmodel/order/stripe_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/res/constant/stripesecretkey.dart';

import '../viewmodel/order/order_bloc.dart';

class TestScreen extends StatefulWidget {
  var total;
  var currency;
   TestScreen({Key? key,this.total,this.currency  }) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Map<String, dynamic>? paymentintent;

  @override
  void initState() {
    // TODO: implement initState
  print("Totaal amount to pay here ${widget.total}");
    super.initState();
  }

  Widget build(BuildContext context) {

    makePayment(currency:widget.currency,totalamount:widget.total.toString()).then((value) {
      print("Success");



    }).catchError((err) {
      print(err);

    });
    return Scaffold(

      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var res = await http.
      post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer ${SecretKey.key}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body
      );
      print("Payment body: ${res.body.toString()}");
      return json.decode(res.body);
    } catch (error) {
      print('  createPaymentIntentresponse error');
      print(error.toString());
    }
  }

  String calculateAmount(String amount) {
    return ((int.parse(amount)) * 100).toString();
  }

  Future<void> makePayment({totalamount,currency}) async {
    print("payment");
    try {
      paymentintent = await createPaymentIntent(totalamount.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentintent!['client_secret'],
              style: ThemeMode.light,
              merchantDisplayName: 'Adnan')).then((value) {

      });
      // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
      // googlePay: const PaymentSheetGooglePay(merchantCountryCode: )
      //after successfully paid
      displayPaymentSheet();
    } catch (err) {
      print('send response error');
      print(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {

        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Payment Successfully'),
          );
        },);
        paymentintent = null;
        context.read<OrderBloc>().add(OrderStripe());
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    } on StripeException catch (e) {
      print("Stripe error catching ${e}");
      await Stripe.instance.presentPaymentSheet(

      ).then((value) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text('Error has been occur'),
          );
        },);
        paymentintent = null;
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    }
  }

}
