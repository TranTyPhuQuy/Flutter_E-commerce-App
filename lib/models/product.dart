import 'package:intl/intl.dart';

class Product {
  int productId;
  String name;
  double price;
  String image;
  String description;
  int cateId;
  int featured;
  int quantity;

  Product(
      {
      required this.productId,
      required this.name,
      required this.price,
      required this.image,
      required this.description,
      required this.cateId,
      required this.featured,
      required this.quantity});
  String getPriceVND() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return formatCurrency.format(price).toString();
  }
}
