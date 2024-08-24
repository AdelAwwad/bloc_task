import 'package:bloc_api/screens/data/Product_model.dart';

abstract class ProductState{}
class ProductInitial extends ProductState{}  // is empty
class ProductLoadingState extends ProductState{}
class ProductLoadedState extends ProductState{
  List<Product> listProduct;
  ProductLoadedState({required this.listProduct});
}
class ProductEmptyState extends ProductState{}
class ProductErrorLoadingState extends ProductState{
  String errorMessage;
  ProductErrorLoadingState({required this.errorMessage});
}
abstract class FavoritesState {}
class FavoritesInitial extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Product> favorites;

  FavoritesLoaded(this.favorites);
}

