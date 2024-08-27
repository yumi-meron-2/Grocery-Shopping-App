import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooping_app/features/product/domain/entities/product_entity.dart';
import 'package:shooping_app/features/product/domain/usecase/get_product.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  GetProductUseCase getProductUseCase;
  GetProductBloc({required this.getProductUseCase}) : super(GetProductInitial()) {
    on<GetProductEvent>((event, emit) async{
      emit(LoadingState());
      var product = await getProductUseCase.execute(event.id);
      product.fold((l) => emit(FailureState(l.message)), (r) => emit(SuccessState(product: r)));
      
   
  });

  }
    }
  
