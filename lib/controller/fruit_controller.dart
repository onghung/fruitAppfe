import '../models/cart_model.dart';
import '../models/fruit_model.dart';
import '../server/tab_response.dart';

class Controller {
  final TabRepository _repository = TabRepository();

  Future<List<Fruit>> fetchFruits() async {
    return await _repository.fetchBooks();
  }

  Future<List<Cart>> fetchCarts() async {
    return await _repository.fetchCart();
  }
}
