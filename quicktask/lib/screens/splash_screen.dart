import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _auth=FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    nextScreen();
  }
  nextScreen(){
    final User? user=_auth.currentUser;
    if(user!=null){
      Timer(const Duration(seconds: 3), ()=>Navigator.pushReplacementNamed(context,'/main'));
    }
    else{
      Timer(const Duration(seconds: 2), ()=>Navigator.pushReplacementNamed(context,'/login'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    final height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [

            Container(
              width: width,
              height: height,
              color: Colors.white70,
            ),

            Image.asset("assets/images/logo.jpeg",
              fit: BoxFit.fill,
              filterQuality: FilterQuality.high,
              ),

          ],
        ),
      ),

      bottomSheet: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("Make your life easy with QuickTask",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),),
      ),

    );
  }
}
