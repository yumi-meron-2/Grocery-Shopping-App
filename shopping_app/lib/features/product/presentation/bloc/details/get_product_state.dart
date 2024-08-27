part of 'get_product_bloc.dart';

sealed class GetProductState extends Equatable {
  const GetProductState();
  
  @override
  List<Object> get props => [];
}

final class GetProductInitial extends GetProductState {}
final class LoadingState extends GetProductState{}
final class SuccessState extends GetProductState{
  final ProductEntity product;
  SuccessState({required this.product});
}
final class FailureState extends GetProductState{
  final String message;
  FailureState(this.message);
}


