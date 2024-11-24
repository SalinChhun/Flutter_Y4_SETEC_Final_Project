import 'package:ecommerce/res/constant/appcolor.dart';
import 'package:ecommerce/res/constant/appfont.dart';
import 'package:ecommerce/views/client/NavScreen.dart';
import 'package:flutter/material.dart';
import '../client/Home.dart';
import 'Login/LoginScreen.dart';
import 'Register/Register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequireLoginandSignup extends StatefulWidget {
  const RequireLoginandSignup({Key? key}) : super(key: key);

  @override
  State<RequireLoginandSignup> createState() => _RequireLoginandSignupState();
}

class _RequireLoginandSignupState extends State<RequireLoginandSignup> {
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/lotties/animation_login.gif',
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                // color: Colors.black45, // Optional: to darken the image
              ),
            ),
            // Foreground content
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Space for the image at the top
                Expanded(
                  child: Container(),
                ),
                SizedBox(height: 14),

                // Buttons
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return loginScreen();
                                },
                              ),
                              (route) {
                                return false;
                              },
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeightConfig.medium,
                              color: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.color,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(AppColorConfig.primarycolor),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        width: double.maxFinite,
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisterScreen();
                                },
                              ),
                              (route) {
                                return false;
                              },
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeightConfig.medium,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.46),
                              ),
                            ),
                            backgroundColor: Color(AppColorConfig.bgcolor),
                          ),
                        ),
                        width: double.maxFinite,
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyNavScreen();
                              },
                            ),
                            (route) {
                              return false;
                            },
                          );
                        },
                        child: Text(
                          "Continue as guest",
                          style: TextStyle(
                            fontSize: 12.8,
                            color: Color(AppColorConfig.primarycolor),
                            fontWeight: FontWeightConfig.medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}