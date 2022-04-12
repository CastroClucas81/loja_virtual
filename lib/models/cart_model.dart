import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  CartModel(this.user);

  void addCartItem(CartProduct product) {
    products.add(product);

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .add(product.toMap())
        .then((doc) {
      product.cid = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct product) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(product.cid)
        .delete();

    products.remove(product);

    notifyListeners();
  }
}
