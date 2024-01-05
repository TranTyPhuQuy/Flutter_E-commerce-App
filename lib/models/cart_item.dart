import 'package:e_commerce_app/models/product.dart';

class CartItem {
  final Product _product;
  int _quantity;

  CartItem( 
    this._product,
    this._quantity);

  double getPrice() {
    return _product.price * _quantity;
  }

  void increaseQuantity() {
    _quantity = _quantity + 1;
  }

  void decreaseQuantity() {
    if(_quantity>1) {
    _quantity = _quantity- 1;
    }
  }
  Product getProduct() {
    return _product;
  }

  int getQuantity() {
    return _quantity;
  }
}
