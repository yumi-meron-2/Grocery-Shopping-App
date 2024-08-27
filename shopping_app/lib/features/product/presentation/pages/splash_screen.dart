import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shooping_app/features/product/presentation/bloc/details/get_product_bloc.dart';
import 'package:shooping_app/features/product/presentation/bloc/home/get_all_products_bloc.dart';
import 'package:shooping_app/features/product/presentation/pages/home_page.dart';
import 'package:shooping_app/service_locator.dart'; // Import service locator

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHomePage();
  }

  void _navigateToHomePage() async {
    await Future.delayed(Duration(seconds: 3)); // Adjust the delay as needed
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  GetAllProductsBloc(getAllProductsUseCase: getIt())
                    ..add(GetAllProductsEvent()),
            ),
            BlocProvider(
              create: (context) => GetProductBloc(getProductUseCase: getIt()),
            ),
          ],
          child: HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Imagesplash.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            
          ),
          Center(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to',
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'SPEEDY CHOW',
                          style: GoogleFonts.roboto(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
