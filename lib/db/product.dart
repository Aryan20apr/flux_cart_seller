import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'products';
  void uploadProduct(
      {required String productName,
      required double price,
      required String brand,
      required String category,
      required int quantity,
      required List sizes,
      required List images}) {
    var id = Uuid();
    String productId = id.v1();

    _firestore.collection(ref).doc(productId).set({
      'name': productName,
      'id': productId,
      'brand': brand,
      'category': category,
      'images': images,
      'price': price,
      'quantity': quantity,
      'sizes available': sizes
    });
  }
}
