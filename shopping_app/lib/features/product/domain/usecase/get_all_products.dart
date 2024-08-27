import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../core/error/failure.dart';
import '../repository/product_repository.dart';
import '../entities/product_entity.dart';

class GetAllProductsUseCase {
  final ProductRepository productRepository;

  GetAllProductsUseCase(this.productRepository);

  Future<Either<Failure, List<ProductEntity>>> call(){
    return productRepository.getAllProducts();
  }
}