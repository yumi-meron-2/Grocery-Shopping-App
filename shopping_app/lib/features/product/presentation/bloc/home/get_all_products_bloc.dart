import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shooping_app/features/product/domain/entities/product_entity.dart';
import 'package:shooping_app/features/product/domain/usecase/get_all_products.dart';

part 'get_all_products_event.dart';
part 'get_all_products_state.dart';

class GetAllProductsBloc extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  
  GetAllProductsUseCase getAllProductsUseCase;
  
  GetAllProductsBloc({required this.getAllProductsUseCase}) : super(HomePageInitial()) {
    
    on<GetAllProductsEvent>((event, emit) async {

      emit(HomeLoadingState());

      var products = await getAllProductsUseCase.call();
      

      emit(products.fold((l) => HomeFailureState(l.message), (r) => HomeLoadedState(products: r) ));
    
      
    });
    
  }
}
