import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, ProductEntity>>getProduct(String id);
}