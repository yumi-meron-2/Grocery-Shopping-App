import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repository/product_repository.dart';

class GetProductUseCase{
  final ProductRepository productRepository;

  GetProductUseCase(this.productRepository);

  Future<Either<Failure, ProductEntity>> execute(String id){
    return productRepository.getProduct(id);
  }
}