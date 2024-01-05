import 'package:intl/intl.dart';

class Categoryy {
  int cateId;
  String name;
  String image;

  Categoryy({
    required this.cateId,
    required this.name,
    required this.image,
  });

  @override
  String toString() {
    return 'Categoryy(cateId: $cateId, name: $name, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Categoryy &&
        other.cateId == cateId &&
        other.name == name &&
        other.image == image;
  }

  @override
  int get hashCode => cateId.hashCode ^ name.hashCode ^ image.hashCode;
}
