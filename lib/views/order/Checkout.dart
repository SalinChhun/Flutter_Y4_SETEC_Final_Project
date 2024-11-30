import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/views/order/DeliveryAddress.dart';

import 'package:ecommerce/views/order/Success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/res/constant/stripesecretkey.dart';
import '../../helper/GoogleLocation.dart';
import '../../helper/HexColorConverter.dart';
import '../../helper/StripeService.dart';
import '../../model/Address.dart';
import '../../model/Order/OrderRequest.dart';
import '../../model/Product/CartModel.dart';
import '../../viewmodel/order/order_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  List<CartItem>? cartitem;

  var subtotal;
  var qtytotal;

  var discount;
  var uid;
  var imgid;
  var sizeid;

  Checkout(
      {Key? key,
      this.cartitem,
      this.subtotal,
      this.discount,
      this.qtytotal,
      this.uid,
      this.imgid,
      this.sizeid})
      : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  Map<String, dynamic>? paymentintent;

  var indexchose = 0;
  var initpayment = 0;
  var selectedmethod = 0;
  int? addressid;
  var userinput = TextEditingController();
  var istap = true;
  var showiconpwd = false;

  var iserrordesc = true;
  var txtdesc = TextEditingController();
  var formdesc = GlobalKey<FormState>();

  void _onAddressSelected(int? addressId) {
    setState(() {
      print('select address id ${addressId}');
      addressid = addressId;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void PopUpUnauthorize(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Missing Delivery Address",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Color(AppColorConfig.primarycolor),
            ),
          ),
          content: Text(
            "Please select your delivering address first ",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12.8,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          elevation: 0,
          actions: [
            ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(AppColorConfig.primarycolor),
                    elevation: 0,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black.withOpacity(0.14)),
                        borderRadius: BorderRadius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Comfirm",
                      style: TextStyle(fontSize: 12.8, color: Colors.white),
                    )
                  ],
                ))
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    var cart = widget.cartitem;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Check Out',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
          print("State google is updated");
          print(state);
          if (state is OrderStripePending) {
            showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(AppColorConfig.bgcolor),
                  ),
                );
              },
            );
            List<Productss>? item = [];

            for (int index = 0; index < cart!.length; index++) {
              // print(cart[index].sizeid);
              // print(cart[index].colorid.id);
              item.add(Productss(
                id: cart![index].productid,
                quantity: cart![index].qty,
                colorselection: cart![index].colorid.id,
                size: cart![index].sizeid,
              ));
            }
            OrderRequestV2 order = OrderRequestV2(
                customer: widget.uid, method: "online", productss: item);

            BlocProvider.of<OrderBloc>(context, listen: false).add(
                PostOrderEvent(addressid: addressid, orderRequestV2: order));
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return Text('');
          }
          if (state is OrderSuccessCompleted) {
            print("Success");
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Success(
                            order: state?.orderReponse,
                          )));
            });
          }
          if (state is OrderError) {
            return Center(
              child: Text("Error has been occur"),
            );
          }
          return SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text("Free Shipping",style: TextStyle(
                      //   fontSize: 12.8,
                      //   fontWeight: FontWeight.w500,
                      //   color: Color(AppColorConfig.success)
                      // ),),
                      SizedBox(
                        height: 20,
                      ),
                      //TODO list product
                      LimitedBox(
                        maxHeight: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cart?.length ?? 0,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            Color colorcode =
                                HexColor(cart?[index].colorid.code);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Product Image
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${cart![index].imgurl}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Product Details
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Product Title
                                          Text(
                                            '${cart![index].producttitle}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          const SizedBox(height: 8),

                                          // Product Details Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Size and Color
                                              Row(
                                                children: [
                                                  Text(
                                                    'Size: ${cart[index].sizetext} • ',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 16,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      color: colorcode,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // Quantity
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                ),
                                                child: Text(
                                                  'Qty: ${cart![index].qty}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey.shade700,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 8),

                                          // Price and Total
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '\$${cart[index].price.toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(AppColorConfig
                                                      .primarycolor),
                                                ),
                                              ),
                                              Text(
                                                'Total: \$${(cart[index].price * cart[index].qty).toStringAsFixed(2)}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey.shade800,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      //TODO order detail
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 30,
                          ),
                          //TODO address
                          DeliveryAddress(
                            onAddressSelected: _onAddressSelected,
                          ),
                          //TODO Payment
                          SizedBox(
                            height: 40,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Payment Method",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //TODO payment type

                          ListTile(
                            style: ListTileStyle.list,
                            onTap: () {
                              setState(() {
                                initpayment = 0;
                                print(initpayment);
                              });
                            },
                            selected: initpayment == 1,
                            tileColor: Color.fromRGBO(112, 16, 223, 100)
                                .withOpacity(0.4),
                            shape: Border.all(
                                color: Colors.grey.withOpacity(0.25)),
                            contentPadding: EdgeInsets.all(10),
                            leading: Image.asset(
                              'assets/logo/Money icon.png',
                              width: 50,
                              height: 50,
                            ),
                            title: Text(
                              "Cash on Delivery",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "Pay when product arrive",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.8,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            style: ListTileStyle.list,
                            onTap: () {
                              setState(() {
                                initpayment = 1;
                                print(initpayment);
                              });
                            },
                            selected: initpayment == 1,

                            selectedTileColor: Color.fromRGBO(112, 16, 223, 100)
                                .withOpacity(0.4),
                            // tileColor: Color(AppColorConfig.primarylight),
                            shape: Border.all(
                                color: Colors.grey.withOpacity(0.25)),
                            contentPadding: EdgeInsets.all(10),

                            leading: Image.asset(
                              'assets/logo/Credit Card Icon.png',
                              width: 50,
                              height: 50,
                              color: Colors.black,
                            ),
                            title: Text(
                              "Credit or Debit Card",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              "Visa or Mastercard",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.8,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          //TODO Product Details

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Product Detail",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Divider(),

                          //TODO product row

                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 15, top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Product Qty',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      'x ${widget.qtytotal}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      '\$ ${widget.subtotal}',
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Fees',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(
                                    ' FREE ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Divider(),
                              Container(
                                margin: EdgeInsets.only(bottom: 135, top: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(112, 16, 223, 100)
                                        .withOpacity(0.4)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'SubTotal',
                                      style: TextStyle(
                                          color: Color(
                                              AppColorConfig.primarycolor),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '\$ ${widget.subtotal}',
                                      style: TextStyle(
                                          color: Color(
                                              AppColorConfig.primarycolor),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )),
          );
        },
      ),
      bottomNavigationBar: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return Text('');
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: FloatingActionButton.extended(
                    backgroundColor: Color(AppColorConfig.primarycolor),
                    elevation: 0,
                    isExtended: true,
                    extendedPadding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    onPressed: () {
                      //TODO submit order
                      print("Submit Order");
                      print("User  address id is ${addressid}");

                      if (addressid == null) {
                        print("True True");
                        PopUpUnauthorize(context);
                        return;
                      }
                      //TODO do some event

                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(AppColorConfig.bgcolor),
                            ),
                          );
                        },
                      );
                      List<Productss>? item = [];

                      for (int index = 0; index < cart!.length; index++) {
                        print(cart![index].colorid.id);
                        item.add(Productss(
                          id: cart![index].productid,
                          quantity: cart![index].qty,
                          colorselection: cart![index].colorid.id,
                          size: cart![index].sizeid,
                        ));
                      }
                      print("Error");

                      print("Item in cart");
                      print(item.length);
                      //TODO orderrequest
                      print(item);

                      print(widget.uid);
                      print(initpayment);
                      print("SAda");

                      if (initpayment == 1) {
                        print("What is our init state");
                        double total = 0;
                        var qtytotal = 0;
                        cart?.forEach((element) {
                          print(element.price);
                          total += (element!.price * element.qty);
                          qtytotal += element!.qty!;
                        });
                        //TODO stripe payment function
                        makePayment(
                          currency: "USD",
                          totalamount: total.ceil().toString(),
                        ).then((value) {
                          print("Success");
                        }).catchError((err) {
                          print(err);
                        });
                      } else {
                        print(item[0].colorselection);
                        print(item[0].quantity);

                        OrderRequestV2 order = OrderRequestV2(
                          customer: widget.uid,
                          method: initpayment == 0 ? "Cash" : "online",
                          productss: item,
                        );

                        BlocProvider.of<OrderBloc>(context, listen: false).add(
                          PostOrderEvent(
                              addressid: addressid, orderRequestV2: order),
                        );
                      }
                    },
                    label: Text(
                      'Place Order',
                      style: TextStyle(fontSize: 15.8, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
      var res = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          headers: {
            'Authorization': 'Bearer ${StripeService.clientkey}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: body);
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

  Future<void> makePayment({totalamount, currency}) async {
    print("payment");
    try {
      paymentintent = await createPaymentIntent(totalamount.toString(), 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentintent!['client_secret'],
                  style: ThemeMode.light,
                  merchantDisplayName: 'Adnan'))
          .then((value) {
        displayPaymentSheet();
      });
      // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92'),
      // googlePay: const PaymentSheetGooglePay(merchantCountryCode: )
      //after successfully paid
      Navigator.pop(context);
    } catch (err) {
      print('send response error');
      print(err.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Payment Successfully'),
            );
          },
        );
        paymentintent = null;
        context.read<OrderBloc>().add(OrderStripe());
        Navigator.pop(context);
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    } on StripeException catch (e) {
      print("Stripe error catching ${e}");
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error has been occur'),
            );
          },
        );
        paymentintent = null;
      }).onError((error, stackTrace) {
        print("error is --- ${error}");
      });
    }
  }
}
