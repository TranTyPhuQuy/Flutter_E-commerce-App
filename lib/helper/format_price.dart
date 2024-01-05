import 'package:intl/intl.dart';

class FormartPrice {
    static String getPriceVND(double price) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return formatCurrency.format(price).toString();
  }
}