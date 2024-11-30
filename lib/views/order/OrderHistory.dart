import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/viewmodel/order/order_bloc.dart';
import 'package:ecommerce/views/ErrorPage.dart';
import 'package:ecommerce/views/order/Tracking.dart';
import 'package:ecommerce/views/widget/other/EmptyWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../model/Order/OrderUser.dart';
import '../widget/LoadingIcon.dart';

class OrderHistory extends StatefulWidget {
  OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory>
    with TickerProviderStateMixin {
  var init = 0;
  var tabindex = 0;
  TabController? _vcontroller;

  List<Results>? history;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _vcontroller = TabController(initialIndex: 0, vsync: this, length: 3);
  }

  Widget build(BuildContext context) {
    sendorderuser();
    print("tab bar render");
    return DefaultTabController(
      length: 3,
      initialIndex: init,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              "Order History",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            bottom: TabBar(
              onTap: (value) {
                print(value);
                setState(() {
                  tabindex = value;
                });
              },
              controller: _vcontroller,
              labelStyle: TextStyle(fontSize: 14.8, color: Colors.white),
              padding: EdgeInsets.all(0),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              indicatorColor: Color(AppColorConfig.success),
              indicatorPadding: EdgeInsets.all(7),
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.withOpacity(0.3)),
              labelColor: Colors.white,
              unselectedLabelStyle:
                  TextStyle(fontSize: 12.8, color: Colors.grey),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Pending',
                ),
                Tab(
                  text: 'Delivering',
                ),
                Tab(
                  text: 'Completed',
                ),
              ],
            ),
            backgroundColor: Colors.black,
            elevation: 0),
        body: SafeArea(
          child: TabBarView(
            children: [
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, state) {
                  // TODO: implement listener
                  print(state);
                },
                builder: (context, state) {
                  if (state is OrderUserLoading) {
                    return LoadingIcon();
                  }
                  if (state is OrderUserComplete) {
                    List<Results>? results = [];
                    if (tabindex == 0) {
                      print("Tab index is 0");
                      state.orderDetail?.results!.forEach((element) {
                        if (element.status!.toLowerCase() == "pending") {
                          results!.add(element);
                        }
                      });
                    } else if (tabindex == 1) {
                      results!.clear();
                      state.orderDetail?.results!.forEach((element) {
                        if (element.status!.toLowerCase() == "delivering") {
                          results.add(element);
                        }
                      });
                      print("Tab index is 1");
                    } else {
                      results!.clear();
                      print("Tab index is 2");
                      state.orderDetail?.results!.forEach((element) {
                        if (element.status!.toLowerCase() == "completed") {
                          results.add(element);
                        }
                      });
                    }

                    print(results.length);
                    return results.length! != 0
                        ? SizedBox.expand(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ListView.builder(
                                itemCount: results.length ?? 0,
                                itemBuilder: (context, index) {
                                  var order = results[index];
                                  // varconst order = history[index];
                                  var orderdate = DateFormat('dd-MM-yyyy kk:mm')
                                      .format(DateTime.parse(
                                          order!.shippedAt.toString()));

                                  return Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.1))),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              fullscreenDialog: true,
                                              builder: (context) {
                                                return TrackingScreen(
                                                  appbar: 'Tracking',
                                                  orderid: order.id,
                                                );
                                              },
                                            ));
                                      },

                                      dense: true,

                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          right: 15,
                                          top: 15,
                                          bottom: 15),
                                      tileColor: Colors.white,
                                      style: ListTileStyle.list,
                                      isThreeLine: true,
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Order # ${order.id}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: order.status!
                                                                  .toLowerCase() ==
                                                              "pending"
                                                          ? Color(AppColorConfig
                                                              .negativelight)
                                                          : order.status!
                                                                      .toLowerCase() ==
                                                                  "delivering"
                                                              ? Colors.black
                                                              : Color(
                                                                  0xffC2E5DF),
                                                    ),
                                                    child: Text(
                                                      "${order.status}",
                                                      style: TextStyle(
                                                          fontSize: 12.8,
                                                          color: order.status!
                                                                      .toLowerCase() ==
                                                                  "pending"
                                                              ? Color(AppColorConfig
                                                                  .negativecolor)
                                                              : order.status!
                                                                          .toLowerCase() ==
                                                                      "delivering"
                                                                  ? Colors.white
                                                                  : Color(AppColorConfig
                                                                      .success),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  // Icon(Icons.attach_money_rounded,color: Colors.black,),
                                                  Text(
                                                      "Payment : \$ ${order!.amount}"),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  // Icon(Icons.paypal,color: Colors.black,),
                                                  Text(
                                                      "Order Date : ${orderdate}")
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),

                                      subtitle: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: order.status!
                                                        .toLowerCase() ==
                                                    "pending"
                                                ? Color(AppColorConfig
                                                    .negativelight)
                                                : order.status!.toLowerCase() ==
                                                        "delivering"
                                                    ? Colors.black
                                                    : Color(0xffC2E5DF),
                                            borderRadius:
                                                BorderRadius.circular(0)),

                                        // margin: EdgeInsets.only(top: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_pin,
                                                  color: order.status!
                                                              .toLowerCase() ==
                                                          "pending"
                                                      ? Color(AppColorConfig
                                                          .negativecolor)
                                                      : order.status!
                                                                  .toLowerCase() ==
                                                              "delivering"
                                                          ? Colors.white
                                                          : Color(AppColorConfig
                                                              .success),
                                                ),
                                                Container(
                                                  width: 290,
                                                  child: Text(
                                                    "     ${order?.address?.street},",
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: order.status!
                                                                  .toLowerCase() ==
                                                              "pending"
                                                          ? Color(AppColorConfig
                                                              .negativecolor)
                                                          : order.status!
                                                                      .toLowerCase() ==
                                                                  "delivering"
                                                              ? Colors.white
                                                              : Color(
                                                                  AppColorConfig
                                                                      .success),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : EmptyCard(
                            maintitle: 'No History Yet',
                            subtitle: 'You haven\'t make any order yet',
                            img: 'assets/logo/.png',
                            btntitle: 'Explore Our Product',
                          );
                  }
                  if (state is OrderUserError) {
                    return const ErrorPage();
                  } else {
                    return LoadingIcon();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendorderuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt("userid");
    BlocProvider.of<OrderBloc>(context, listen: false)
        .add(GetUserorder(userid: prefs.getInt("userid")));
  }
}
