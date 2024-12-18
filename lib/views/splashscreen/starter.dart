import 'package:ecommerce/views/splashscreen/screen1.dart';
import 'package:ecommerce/views/splashscreen/screen2.dart';
import 'package:ecommerce/views/splashscreen/screen3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../model/Splash.dart';
import '../../res/constant/appcolor.dart';
import '../authentication/Require.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  var apptitle;

  StartScreen({this.apptitle});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var _pagecontroller = PageController(initialPage: 0);
  var initstate = 0;

  var listofcontent = [
    Splash(
        buttontitle: "Get Started",
        headertitle: "Welcome to EasyCart",
        body:
            "An advance ecommerce system that allow you purchase items with just a click and done "),
    Splash(
        buttontitle: "Continue",
        headertitle: "Find Your Favorites",
        body:
            "An advance ecommerce system that allow you purchase items with just a click and done "),
    Splash(
        buttontitle: "Ready",
        headertitle: "Fast Delivery",
        body:
            "An advance ecommerce system that allow you purchase items with just a click and done "),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    changefirstuse();
    return Scaffold(
        backgroundColor: Color(AppColorConfig.appbackground),
        appBar: null,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pagecontroller,
                      pageSnapping: true,
                      onPageChanged: (value) {
                        print(value);
                        setState(() {
                          initstate = value;
                        });
                      },
                      children: [
                        WelcomeScreen(),
                        WelcomeSecond(),
                        GettingStarted()
                      ],
                      scrollBehavior: ScrollBehavior(),
                    ),
                  ),
                  //TODO button navigation here started and dot
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "${listofcontent[initstate].headertitle}",
                            textAlign:
                                TextAlign.center, // Center the header title
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            "${listofcontent[initstate].body}",
                            textAlign: TextAlign.center, // Center the body text
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey[700]),
                          ),
                        ),
                        //TODO text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: constraints.maxWidth * 0.65,
                              child: ElevatedButton(
                                onPressed: () => initstate == 2
                                    ? Navigator.of(context)
                                        .push(MaterialPageRoute(
                                        builder: (context) {
                                          return RequireLoginandSignup();
                                        },
                                      ))
                                    : _pagecontroller.animateToPage(
                                        initstate + 1,
                                        duration: Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                      ),
                                child: Text(
                                  "${listofcontent[initstate].buttontitle}",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor:
                                      Color(AppColorConfig.primarycolor),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20, top: 50),
                          child: SmoothPageIndicator(
                              controller: _pagecontroller,
                              onDotClicked: (index) {},
                              count: listofcontent.length,
                              effect: ExpandingDotsEffect(
                                activeDotColor:
                                    Color(AppColorConfig.primarycolor),
                                dotHeight: 10,
                                dotWidth: 10,
                                radius: 23,
                                spacing: 13,
                              )),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }

  void changefirstuse() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("firstuse") == null) {
      prefs.setBool("firstuse", false);
    }
  }
}
