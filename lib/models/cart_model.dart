import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  String? couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  //construtor
  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) => ScopedModel.of(context);

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

  void decProduct(CartProduct product) {
    product.quantity = product.quantity! - 1;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(product.cid)
        .update(product.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct product) {
    product.quantity = product.quantity! + 1;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .doc(product.cid)
        .update(product.toMap());

    notifyListeners();
  }

  void setCoupon({
    required String? couponCode,
    required int discountPercentage,
  }) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;

    for (CartProduct c in products) {
      if (c.productData != null) {
        var cPrice = c.productData!.price;
        price += c.quantity! * cPrice!;
      }
    }

    return price;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  Future<String?> finishOrder() async {
    if (products.length == 0) return null;
    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await FirebaseFirestore.instance.collection("orders").add({
      "clientId": user.firebaseUser!.uid,
      "products": products.map((cart) => cart.toMap()).toList(),
      "shipPrice": shipPrice,
      "productsPrice": productsPrice,
      "discount": discount,
      "totalPrice": productsPrice - discount + shipPrice,
      "status": 1
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("orders")
        .doc(refOrder.id)
        .set(
      {
        "orderId": refOrder.id,
      },
    );

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .get();

    for (DocumentSnapshot doc in query.docs) {
      doc.reference.delete();
    }

    products.clear();
    couponCode = null;
    discountPercentage = 0;
    isLoading = false;

    notifyListeners();
  
    return refOrder.id;
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.firebaseUser!.uid)
        .collection("cart")
        .get();

    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}
