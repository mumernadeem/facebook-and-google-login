import 'package:facebook_test/Doneloginscreen.dart';
import 'package:facebook_test/google_sign_in.dart';
import 'package:facebook_test/signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildLoading()=>const Center(child: CircularProgressIndicator(),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context)=> GoogleSignInProvider(),
        child:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            final provider =Provider.of<GoogleSignInProvider>(context, listen: false);
            if(provider.isSigningIn){
              return buildLoading();
            }
            else if(snapshot.hasData){
              return const LoggedInWidget();
            }
            else{
              return const SignUpWidget();
            }
          },
        ),
      ),
    );
  }
}
