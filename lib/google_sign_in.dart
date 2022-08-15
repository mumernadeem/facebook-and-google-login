
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  bool permit = false;
  double lat = 0.0;
  double long = 0.0;
  void updatePermit(bool value) {
    permit = value;
    notifyListeners();
  }

  void updateLatLong(double lati, double longi) {
    lat = lati;
    long = longi;
    notifyListeners();
  }

  final googleSignIn = GoogleSignIn();
  bool _isSigningIn = false;
  GoogleSignInProvider() {
    _isSigningIn = false;
  }
  bool get isSigningIn => _isSigningIn;
  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  Future googlelogin() async {
    isSigningIn = true;
    final user = await googleSignIn.signIn();
    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var authresult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      isSigningIn = false;
      var userInfo = authresult.user!.email;
      print("User email ===============" + userInfo.toString());
      var data = {"Email": userInfo.toString()};
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
