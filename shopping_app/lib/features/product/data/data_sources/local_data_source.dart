import 'dart:convert';

import '../model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> cacheProduct(List<ProductModel> products);
  List<ProductModel> getAllProducts();
  ProductModel getProduct(String id);
}

class LocalDataSourceImpl implements LocalDataSource{
  var key = 'chachedproducts';
  SharedPreferences sharedPreferences;
  LocalDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<void> cacheProduct(List<ProductModel> products) async {
    var jsonMap = json.encode(products.map((product) => product.toJson()).toList());
    bool response = await sharedPreferences.setString(key, jsonMap);
    if (response == false){
      throw Exception('Local error');
    }
  }
  List<ProductModel> _jsonToProductList(String response){
    var listJson = json.decode(response);

    List<ProductModel> listOfProducts = [];
    for (var prod in listJson){
      listOfProducts.add(ProductModel.fromJson(prod));
    }

    return listOfProducts;
  }

  @override
  List<ProductModel> getAllProducts() {
    var response = sharedPreferences.getString(key);
    if (response != null){
      List<ProductModel> listOfChachedProducts = _jsonToProductList(response);
      return listOfChachedProducts;
    }else{
      throw Exception('no chached data');
    }

  }
  
  @override
  ProductModel getProduct(String id) {
    var response = sharedPreferences.getString(key);
    if (response != null){
      List<ProductModel> listOfChachedProducts = _jsonToProductList(response);
      for (var prod in listOfChachedProducts){
        if (prod.id == id){
          return prod;
        }
      }
      throw Exception('no product with this id');
    }else{
      throw Exception('no chached data');
    }
  }

  
}