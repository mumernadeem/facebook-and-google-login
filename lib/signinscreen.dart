import 'dart:convert';

import 'package:facebook_test/fb_model.dart';
import 'package:facebook_test/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  late FbModel profile = FbModel();
  fbsignin() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile'],
    );
    FacebookPermissions? permissions = await FacebookAuth.instance.permissions;
    final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      print('logged in');
      var uri = Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}');
      var graphResponse = await http.get(uri);
      print(graphResponse.body);
      profile = FbModel.fromJson(jsonDecode(graphResponse.body));
      print(profile.email);
    }
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      print(profile.name);
      var data = {"Email": profile.email.toString()};
      print(data);
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: 175,
                child: const Text(
                  'Welcome Back To MyApp',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              child: OutlinedButton.icon(
                onPressed: (){
                  final provider=Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googlelogin();
                },
                icon: const Icon(Icons.ads_click,color: Colors.red,),
                label: const Text('Sign in with Google',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(4),
              child: OutlinedButton.icon(
                onPressed: (){},
                icon: const Icon(Icons.ads_click,color: Colors.yellow,),
                label: const Text('Sign in with Facebook',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                ),
              ),
            ),
            const SizedBox(height: 12,),
            const Text('Login to Continue',style: TextStyle(
                fontSize: 16
            ),),
            const Spacer(),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 175,
              child: const Text(
                'Welcome Back To MyApp',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            child: OutlinedButton.icon(
              onPressed: (){
                final provider=Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googlelogin();
              },
              icon: const Icon(Icons.ads_click,color: Colors.red,),
              label: const Text('Sign in with Google',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            child: OutlinedButton.icon(
              onPressed: (){
                fbsignin();
              },
              icon: const Icon(Icons.ads_click,color: Colors.yellow,),
              label: const Text('Sign in with Facebook',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              ),
            ),
          ),
          const SizedBox(height: 12,),
          const Text('Login to Continue',style: TextStyle(
              fontSize: 16
          ),),
          const Spacer(),
        ],
      ),
    );
  }
}
