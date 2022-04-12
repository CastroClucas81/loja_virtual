import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CartProduct {
  String? cid;
  String? category;
  String? pid;
  int? quantity;
  String? size;
  ProductData? productData;

  CartProduct.fromDocument(DocumentSnapshot snapshot) {
    cid = snapshot.id;
    category = snapshot["category"];
    pid = snapshot["pid"];
    quantity = snapshot["quantity"];
    size = snapshot["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData!.toResumedMap(),
    };
  }
}
