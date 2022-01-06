import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int indexSelected;
  const BottomNavigationBarWidget(this.indexSelected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    var cart = context.watch<Cart>();
    var _totalItems = cart.totalItems();

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Acceuil'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart_outlined),
          label: 'Commande'
        ),
        BottomNavigationBarItem(
          icon: _totalItems == 0 ?
              Icon(Icons.shopping_cart_outlined) :
              Badge(
                child: Icon(Icons.shopping_cart),
                badgeContent: Text(_totalItems.toString()),
                position: BadgePosition(top: 0, end: 0),
              ),
          label: 'Panier'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label:'Profil',
        ),
      ],

      onTap: (index) {
        String page = '/';
        switch (index) {
          case 1 :
            page = '/liste';
            break;
          case 2 :
            page = '/panier';
            break;
          case 3 :
            page = '/profil';
            break;
        }
        Navigator.pushNamed(context, page);
      },
    );
  }
}