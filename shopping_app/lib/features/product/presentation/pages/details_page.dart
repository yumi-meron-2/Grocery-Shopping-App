import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shooping_app/features/product/presentation/bloc/details/get_product_bloc.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isExpanded = false;
  Map<String, bool> selectedOptions = {};
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    context.read<GetProductBloc>().add(GetProductEvent(id: widget.id));
  }

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) _quantity--;
    });
  }

  void _addToCart() {
    // Navigate back to the home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<GetProductBloc, GetProductState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState) {
            // Initialize selectedOptions with false for each option
            selectedOptions = {for (var option in state.product.options) option.name: false};

            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 280,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0), // Adjust the radius as needed
                            image: DecorationImage(
                              image: NetworkImage(state.product.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0, left: 24.0, right: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.product.title,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (state.product.discount != state.product.price)
                                  Text(
                                    '\$${state.product.price}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                      color: const Color.fromRGBO(152, 157, 163, 1),
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                Text(
                                  '\$${state.product.discount}',
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: const Color.fromRGBO(255, 99, 71, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color.fromRGBO(255, 204, 0, 1),
                                  size: 26,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  state.product.rating.toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color.fromRGBO(13, 18, 23, 1),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '(1,205)',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'See all Reviews',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: const Color.fromRGBO(105, 112, 121, 1),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            AnimatedSize(
                              duration: const Duration(milliseconds: 300),
                              child: Container(
                                width: double.infinity,
                                constraints: BoxConstraints(
                                  maxHeight: isExpanded ? double.infinity : 72,
                                ),
                                child: Text(
                                  state.product.description,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: const Color.fromRGBO(105, 112, 121, 1),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  maxLines: isExpanded ? null : 3,
                                  overflow: isExpanded
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  isExpanded ? "Show less" : "See more",
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: const Color.fromRGBO(63, 81, 243, 1),
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline, // Underline the "See more" text
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Additional Options',
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromRGBO(13, 18, 23, 1),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              children: state.product.options.map((option) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      option.name,
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(13, 18, 23, 1),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${option.price}',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: const Color.fromRGBO(13, 18, 23, 1),
                                          ),
                                        ),
                                        Checkbox(
                                          value: selectedOptions[option.name],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              selectedOptions[option.name] = value ?? false;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                            
                            const SizedBox(height: 36),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove, color: Colors.black),
                                        onPressed: _decrement,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '$_quantity',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: 8),
                                      IconButton(
                                        icon: Icon(Icons.add, color: Colors.black),
                                        onPressed: _increment,
                                      ),
                                    ],
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red, // Button color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30), // Rounded edges
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                                    label: Text(
                                      'Add to Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: _addToCart,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  width: 40,
                  height: 40,
                  top: 35,
                  left: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: CircleBorder(),
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 7.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is FailureState) {
            return const Center(
              child: Text('Failed to load product details.'),
            );
          }
          return Container(); // Fallback for unexpected states
        },
      ),
    );
  }

//   void _increment() {
//     setState(() {
//       _quantity++;
//     });
//   }

//   void _decrement() {
//     setState(() {
//       if (_quantity > 1) _quantity--;
//     });
//   }

//   void _addToCart() {
//     // Navigate back to the home screen
//     Navigator.pop(context);
//   }
}
