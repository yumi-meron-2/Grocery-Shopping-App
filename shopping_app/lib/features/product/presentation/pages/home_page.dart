import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shooping_app/features/product/presentation/bloc/home/get_all_products_bloc.dart';
import 'package:shooping_app/features/product/presentation/widgets/card.dart';

import '../../data/model/product_model.dart';
import '../../domain/entities/product_entity.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 22,
                width: 24,
                child: Image.asset('assets/images/CheeseBurger.png'),
              ),
              SizedBox(width: 8),
              Text(
                'Burger',
                style: GoogleFonts.roboto(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Gray background
                  borderRadius: BorderRadius.circular(30.0), // Adjust radius for rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Optional: Add shadow for better visibility
                      blurRadius: 5,
                      offset: Offset(0, 3), // Offset for the shadow
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16.0), // Adjust padding for the icon
                      child: Icon(Icons.search, color: Colors.grey),
                    ),
                    border: InputBorder.none, // Remove border from the TextField
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding as needed
                  ),
                  onChanged: (query) {
                    // Call the search functionality
                  },
                ),
              ),


              SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<GetAllProductsBloc, GetAllProductsState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }else if (state is HomeLoadedState){
                      final List<ProductEntity> products = state.products;
                      return GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(product: products[index]);
                        },
                      );
                    }
                    return const Center(
                      child: Text('Failed to load products'),
                    );
                  },
                )

              )

            ],
          ),
        ),
      ),
    );
  }
}
