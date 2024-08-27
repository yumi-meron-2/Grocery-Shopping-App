
import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repository/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../model/product_model.dart';

class ProductRepoitoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;
  final LocalDataSource localDataSource;
  final ProductRemoteDataSource productRemoteDataSource;
  

  ProductRepoitoryImpl({required this.productRemoteDataSource, required this.localDataSource, required this.networkInfo});

  

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await productRemoteDataSource.getAllProducts();
        var listOfProduct = remoteProducts.map((model) => (model).toEntity()).toList() as List<ProductEntity>;
        localDataSource.cacheProduct(remoteProducts);

        return Right(listOfProduct);
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final List<ProductModel> productModels = localDataSource.getAllProducts();
        final List<ProductEntity> prodctEntities = productModels.map((model) => model.toEntity()).toList();
        return Right(prodctEntities);
      } catch (e) {
        return Left("Local Exception" as Failure);
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(String id)async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProduct = productRemoteDataSource.getProduct(id);
        return remoteProduct.then((value) => Right(value.toEntity()));
      } on ServerException {
        return Left(ServerFailure('Server Failure'));
      }
    } else {
      try {
        final ProductModel productModel = localDataSource.getProduct(id);
        return Future.value(Right(productModel.toEntity()));
      } catch (e) {
        return Future.value(Left("Local Exception" as Failure));
      }
    }
  }
}