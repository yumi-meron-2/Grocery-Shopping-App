import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required String id,
    required String title,
    required String imageUrl,
    required double rating,
    required double price,
    required double discount,
    required String description,
    required List<Option> options,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          rating: rating,
          price: price,
          discount: discount,
          description: description,
          options: options,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var optionsFromJson = json['options'] as List;
    List<Option> optionsList = optionsFromJson.map((optionJson) {
      return Option(
        id: optionJson['id'],
        name: optionJson['name'],
        price: (optionJson['price'] as num).toDouble(),
      );
    }).toList();

    return ProductModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      description: json['description'],
      options: optionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'rating': rating,
      'price': price,
      'discount': discount,
      'description': description,
      'options': options.map((option) => {
            'id': option.id,
            'name': option.name,
            'price': option.price,
          }).toList(),
    };
  }
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      imageUrl: imageUrl,
      rating: rating,
      price: price,
      discount: discount,
      description: description,
      options: options,
    );
  }
}