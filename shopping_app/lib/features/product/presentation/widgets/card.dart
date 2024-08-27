import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shooping_app/features/product/presentation/pages/details_page.dart';

import '../../domain/entities/product_entity.dart';

class ProductCard extends StatefulWidget{
  final ProductEntity product;
  const ProductCard({required this.product});
  
  @override
  _ProductCardState createState() => _ProductCardState(); 
} 

class _ProductCardState extends State<ProductCard>{
  bool isLiked = false;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(id: widget.product.id)));
      },
      child: Stack(
        children:[ 
          Container(
            height: 190,
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0), 
                  child: Container(
                    height: 120, 
                    width: double.infinity, 
                    child: Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.cover, 
                    ),
                  ),
                ),
              SizedBox(height: 4,),
              Text(widget.product.title, style: GoogleFonts.roboto(fontSize: 12, color: Color.fromRGBO(13, 18, 23, 1), fontWeight: FontWeight.w500),),
              SizedBox(height: 4,),
              Row(
                children: [
                  Icon(Icons.star, color: Color.fromRGBO(255, 204, 0, 1), size: 13,),
                  SizedBox(width: 4,),
                  Text(widget.product.rating.toString(), style: GoogleFonts.roboto(fontSize: 11, color: Color.fromRGBO(13, 18, 23, 1), fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(height: 4,),
              Row(children: [
                if( widget.product.discount != widget.product.price)
                  Text('\$${widget.product.price}', style: GoogleFonts.roboto(fontSize: 16, color: Color.fromRGBO(152, 157, 163, 1), fontWeight: FontWeight.w400, decoration: TextDecoration.lineThrough, ),),
                  SizedBox(width: 8,),
                  Text('\$${widget.product.discount}', style: GoogleFonts.roboto(fontSize: 16, color: Color.fromRGBO(255, 99, 71, 1), fontWeight: FontWeight.w600),),
        
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
              child: Container(
                padding: EdgeInsets.all(4),  // Reduced padding
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 18, 
                  ),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}