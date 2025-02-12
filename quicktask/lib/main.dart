import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quicktask/auth/forgot_password.dart';
import 'package:quicktask/auth/login_screen.dart';
import 'package:quicktask/auth/signup_screen.dart';
import 'package:quicktask/firebase_options.dart';
import 'package:quicktask/providers/authentication_provider.dart';
import 'package:quicktask/providers/internet_connection_check_provider.dart';
import 'package:quicktask/providers/theme_provider.dart';
import 'package:quicktask/providers/todo_provider.dart';
import 'package:quicktask/screens/main_screen.dart';
import 'package:quicktask/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthenticationProvider()),
        ChangeNotifierProvider(create: (context)=>ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>TodoProvider()),
        ChangeNotifierProvider(create: (context)=>InternetConnectionCheckProvider()),
      ],

      child: Builder(
        builder: (context) {
          return MaterialApp(

            title: 'QuickTask',
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            debugShowCheckedModeBanner: false,

            theme: ThemeData(
              primaryColor: const Color(0xff93a5cf),
              brightness: Brightness.light,
              colorScheme: const ColorScheme.light(
                primary: Colors.blue,
                secondary: Colors.blueAccent,
              ),
            ),

            darkTheme: ThemeData(
              primaryColor: Colors.teal,
              brightness: Brightness.dark,
              colorScheme: const ColorScheme.dark(
                primary: Colors.teal,
                secondary: Colors.tealAccent,
              ),
            ),

            initialRoute: "/",
            routes: {
              '/':(context)=>const SplashScreen(),
              '/forgot':(context)=>const ForgotPasswordScreen(),
              '/main':(context)=>const MainScreen(),
              '/login':(context)=>const Login(),
              '/signup':(context)=>const Signup(),
            },
          );
        }
      ),
    );
  }
}

