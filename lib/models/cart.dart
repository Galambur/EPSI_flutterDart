import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pizzeria/models/pizza.dart';

class CartItem {
  final Pizza pizza;
  int quantity;

  CartItem(this.pizza, [this.quantity = 1]);
}

class Cart extends ChangeNotifier{
  List<CartItem> _items = [];
  var TVA = 20/100;

  int totalItems() { return _items.length; }

  CartItem getCartItem(int index){
    return _items[index];
  }

  void addProduct(Pizza pizza) {
    int index = findCartItemIndex(pizza.id);

    if(index == -1){
      _items.add(CartItem(pizza));
    } else {
      CartItem item = _items[index];
      item.quantity++;
    }
    notifyListeners();
  }

  void removeOneProduct(Pizza pizza){
    int index = findCartItemIndex(pizza.id);

    CartItem item = _items[index];
    item.quantity--;
    if(item.quantity < 1)
      removeProduct(pizza);
    notifyListeners();
  }

  void removeProduct(Pizza pizza){
    int index = findCartItemIndex(pizza.id);
    if(index != -1) {
      _items.removeAt(index);
    }
  }

  int findCartItemIndex(int id){
    return _items.indexWhere((element) => element.pizza.id == id);
  }

  double getPrixTotalHt(){
    var prix = 0.0;
    for (var element in _items) {
      prix = prix + (element.pizza.price * element.quantity);
    }
    return prix;
  }

  double getTva(double prix){
    return prix * (20/100);
  }

  double getPrixTotalTTC(){
    var prix = getPrixTotalHt();
    var tva = getTva(prix);
    prix = prix + tva;
    return prix;
  }
}