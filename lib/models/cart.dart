class Cart {
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? productPrice;
  final int? quantity;
  final String? unitTag;
  final String? image;

  Cart(
      {
      required this.productId,
      required this.productName,
      required this.initialPrice,
      required this.productPrice,
      required this.quantity,
      required this.unitTag,
      required this.image});

  Cart.fromMap(Map<dynamic, dynamic> res)
      : 
        productId = res["productId"],
        productName = res["productName"],
        initialPrice = res["initialPrice"],
        productPrice = res["productPrice"],
        quantity = res["quantity"],
        unitTag = res["unitTag"],
        image = res["image"];
  Map<String, Object?> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'initialPrice': initialPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitTag': unitTag,
      'image': image,
    };
  }
}
