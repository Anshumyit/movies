import 'package:bhojapurimovie/view/splash_screen.dart';
import 'package:bhojapurimovie/viewcontroller/bottomnavitorbarprovider.dart';
import 'package:bhojapurimovie/viewcontroller/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(

      MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (_) => BottomNavitor()),
         ChangeNotifierProvider(create: (_)=>home_provider())
       ],
        child: const MyApp(),
      )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bhojapuri Movies show all',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}


