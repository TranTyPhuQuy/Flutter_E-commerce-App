import 'package:intl/intl.dart';
class Product {
  int? productId;
  String? name;
  String? price;
  String? image;
  String? description;
  int? cateId;
  int? featured;

  Product(
    {
      this.productId,
      this.name,
      this.price,
      this.image,
      this.description,
      this.cateId,
      this.featured}
    );
    String getPriceVND() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return formatCurrency.format(double.parse(price ?? '0')).toString();

  }
}
