import 'package:google_sign_in/google_sign_in.dart';


// class AuthService{
//   //google sign in
//
//
//   Future<Map<String,String?>>  signInWithGoogle() async {
//      final GoogleSignInAccount? googleuser = await  GoogleSignIn().signIn();
//     // print(googleuser?.email);
//
//     //  print(googleuser);
//     //
//     //
//     //
//     //  print("Photo url is ");
//     //  print(googleuser?.photoUrl.toString());
//      // print(googleuser?.displayName);
//
//
//
//       final GoogleSignInAuthentication? googleauth = await googleuser?.authentication;
//      //  print(googleauth?.accessToken);
//      // print(googleauth?.idToken);
//      // print(googleauth?.idToken);
//
//       //create credential
//      var user = {
//        "email":googleuser?.email,
//        "displayname":googleuser?.displayName,
//        "id":googleuser?.id
//      };
//      return user;
//
//   }
// }


class AuthService {
  // ...

  Future<Map<String, String?>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in
      if (googleUser == null) {
        print("Google sign-in canceled by user");
        return {} ; // or you can throw an exception or handle it in another way
      }

      final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      // create credential
      var user = {
        "email": googleUser?.email,
        "displayname": googleUser?.displayName,
        "id": googleUser?.id,
      };
      return user;
    } catch (e) {
      print("Error during Google sign-in: $e");
      // handle the error as needed
      return {}; // or you can throw an exception or handle it in another way
    }
  }
}
