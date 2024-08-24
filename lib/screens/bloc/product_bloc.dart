import 'package:bloc_api/screens/bloc/product_event.dart';
import 'package:bloc_api/screens/bloc/product_state.dart';
import 'package:bloc_api/screens/data/Product_model.dart';
import 'package:bloc_api/screens/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent ,ProductState>{
  ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super (ProductInitial()){
on<GetProductEvent>(( event ,  emit) async{
emit(ProductLoadingState());

try{
List<Product> listProduct = await  productRepository.getProduct();
if(listProduct.isEmpty){
emit(ProductEmptyState());
}else{
emit(ProductLoadedState(listProduct:listProduct ));
}

} catch(e){
emit(ProductErrorLoadingState(errorMessage: "some thing error"));
}


});

}
}


class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesInitial());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is AddToFavorites) {
      final currentState = state;
      if (currentState is FavoritesLoaded) {
        // Add the item to the current favorites list and yield a new state
        yield FavoritesLoaded(
          List.from(currentState.favorites)..add(event.item),
        );
      } else {
        // Initialize the favorites list with the new item
        yield FavoritesLoaded([event.item]);
      }
    } else if (event is RemoveFromFavorites) {
      final currentState = state;
      if (currentState is FavoritesLoaded) {
        // Remove the item from the current favorites list and yield a new state
        yield FavoritesLoaded(
          List.from(currentState.favorites)..remove(event.item),
        );
      }
    }
  }
}
