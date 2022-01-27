import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  var format = NumberFormat("####.00 €");

  @override
  Widget build(BuildContext context){
    var cart = context.watch<Cart>();

    return ListView.builder(
      itemCount: cart.totalItems(),
      itemBuilder: (context, index) {
        return _buildItem(cart.getCartItem(index), cart);
      },
    );
  }

  Widget _buildItem(CartItem cartItem, Cart cart){
    return Row(
      children: [
        Image.asset(
          cartItem.pizza.image,
          width: 100.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartItem.pizza.title,
              style: PizzeriaStyle.baseTextStyle,
            ),
            Text('${cartItem.pizza.total} €'),
            Text(
              'Sous total : ${cartItem.quantity * cartItem.pizza.total} €',
              style: PizzeriaStyle.priceSubTotalTextStyle,
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: (){
                  cart.removeOneProduct(cartItem.pizza);
                },
                icon: Icon(Icons.remove_circle_outline)
            ),
            Text(cartItem.quantity.toString()),
            IconButton(
                onPressed: () {
                  cart.addProduct(cartItem.pizza);
                },
                icon: Icon(Icons.add_circle_outline)
            ),
          ],
        ),
      ],
    );
  }
}
