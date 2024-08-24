
import '../data/Product_model.dart';


abstract class ProductEvent{}
class GetProductEvent extends ProductEvent{}


class FavoritesEvent {}
class AddToFavorites extends FavoritesEvent {
  final Product item;

  AddToFavorites(this.item);
}

class RemoveFromFavorites extends FavoritesEvent {
  final Product item;

  RemoveFromFavorites(this.item);
}
