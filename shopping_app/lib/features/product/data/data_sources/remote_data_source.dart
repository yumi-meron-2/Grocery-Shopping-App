import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../core/constants/constants.dart';
import '../../core/error/exception.dart';
import '../model/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<List<ProductModel>> getAllProducts() async {
    // var header = {
    //     'Content-Type': 'application/json',
    //      };
    final response = await client.get(Uri.parse(Urls.baseUrl));
    if (response.statusCode == 200){
      
      // print(response.body);
      var myJson = json.decode(response.body)['data'] as List<dynamic>;
      // print(myJson);
      var listOfProduct = myJson.map((model) => ProductModel.fromJson(model)).toList() as List<ProductModel>;
  
      return listOfProduct;

    }else{
      throw ServerException();
    }
  }
  
  @override
  Future<ProductModel> getProduct(String id) async {
    // var header = {
    //     'Content-Type': 'application/json',
    //      };
    final response = await client.get(Uri.parse("${Urls.baseUrl}/$id"),);
    if (response.statusCode == 200){
      print(response.body);
      return ProductModel.fromJson(json.decode(response.body)['data']);
    }else{
      throw ServerException();
    }
  }
}