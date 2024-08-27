import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooping_app/features/product/presentation/bloc/details/get_product_bloc.dart';
import 'package:shooping_app/features/product/presentation/bloc/home/get_all_products_bloc.dart';
import 'package:shooping_app/features/product/presentation/pages/home_page.dart';
import 'package:shooping_app/features/product/presentation/pages/splash_screen.dart'; // Import the splash screen
import 'service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), 
    );
  }
}
