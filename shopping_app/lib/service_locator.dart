import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/product/core/network/network_info.dart';
import 'features/product/data/data_sources/local_data_source.dart';
import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/data/repositories/product_repoitory_impl.dart';
import 'features/product/domain/repository/product_repository.dart';
import 'features/product/domain/usecase/get_all_products.dart';
import 'features/product/domain/usecase/get_product.dart';

final GetIt getIt = GetIt.instance;

Future<void> setup() async{
  var sharedPreferences = await SharedPreferences.getInstance();
  var client = http.Client();
  var connectivity = InternetConnectionChecker();
  getIt.registerSingleton<InternetConnectionChecker>(connectivity);
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);
  getIt.registerSingleton<http.Client>(client);
  getIt.registerSingleton<NetworkInfo>(NetworkInfoImpl(getIt()));
  getIt.registerSingleton<LocalDataSource>(LocalDataSourceImpl(sharedPreferences: getIt()));
  getIt.registerSingleton<ProductRemoteDataSource>(ProductRemoteDataSourceImpl(client: getIt()));
  getIt.registerSingleton<ProductRepository>(ProductRepoitoryImpl(productRemoteDataSource: getIt(), localDataSource: getIt(), networkInfo: getIt()));
  getIt.registerSingleton<GetAllProductsUseCase>(GetAllProductsUseCase(getIt()));
  getIt.registerSingleton<GetProductUseCase>(GetProductUseCase(getIt()));

}