import 'package:flutter/material.dart';


class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi_off, color: Colors.red.shade300, size: 50),
                const SizedBox(height: 10),
                const Text("No Internet Connection",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text("😞",style: TextStyle(fontSize: 25),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}