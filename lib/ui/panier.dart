import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import '../models/cart_total.dart';
import '../models/cart_list.dart';

class Panier extends StatelessWidget {
  Panier({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CartList(),
            )
          ),
          CartTotal(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}



