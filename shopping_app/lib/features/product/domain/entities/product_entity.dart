import 'package:equatable/equatable.dart';

class Option {
  final String id;
  final String name;
  final double price;

  Option({
    required this.id,
    required this.name,
    required this.price,
  });
}

class ProductEntity extends Equatable {
  final String id;
  final String title;
  final String imageUrl;
  final double rating;
  final double price;
  final double discount;
  final String description;
  final List<Option> options;

  ProductEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.price,
    required this.discount,
    required this.description,
    required this.options,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        rating,
        price,
        discount,
        description,
        options,
      ];
}
