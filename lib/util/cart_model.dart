import 'package:medico/models/cart.dart';

class CartModel {
  final double price;
  final int quantity;
  final List<CartItem> cartItems;
  CartModel({this.price, this.quantity, this.cartItems});

  static CartModel extractDataFromCart(Cart cart) {
    if (cart == null) {
      return CartModel(
        price: 0,
        quantity: 0,
        cartItems: null,
      );
    }

    double price = 0;
    final int quantity =
        (cart.medicineList == null ? 0 : cart.medicineList.length) +
            (cart.diagnostic == null ? 0 : cart.diagnostic.length);
    final List<CartItem> cartItems = [];
    if (cart.medicineList != null)
      cart.medicineList.forEach((medicine) {
        price +=
            medicine.price == null || medicine.price.isNaN ? 0 : medicine.price;
        cartItems.add(CartItem(
            medicine.mongoId, medicine.drugName, medicine.price, 'Medicine'));
      });
    if (cart.diagnostic != null)
      cart.diagnostic.forEach((diagnolotic) {
        price += diagnolotic.rate == null || diagnolotic.rate.isNaN
            ? 0
            : diagnolotic.rate;
        cartItems.add(CartItem(diagnolotic.mongoId, diagnolotic.name,
            diagnolotic.rate, 'Diagnolotic'));
      });
    price = double.parse(price.toStringAsFixed(2));
    return CartModel(
      price: price,
      quantity: quantity,
      cartItems: cartItems.isEmpty ? null : cartItems,
    );
  }
}

class CartItem {
  final String id;
  final String name;
  final double price;
  final String type;
  CartItem(this.id, this.name, this.price, this.type);
}
