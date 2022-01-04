import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/cart_total_widget.dart';
import 'package:pizzeria/ui/share/cart_list_widget.dart';

class Panier extends StatefulWidget {
  const Panier({Key? key}): super (key : key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  var formatter = NumberFormat("####.00 €");

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
              child: _CartList(),
            );
          ),
          _CartTotal(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }
}



