import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}): super (key : key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Mon panier'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget._cart.totalItems(),
              itemBuilder: (context, index) {
                return _buildItem(widget._cart.getCartItem(index));
              },
            ),
          ),
          Row(
            children: [
              Text('Total'),
              Text('30 €'),
            ],
          ),
          Container(
            child: ElevatedButton(
              child: Text('Valider'),
              onPressed: () {
                print('Valider');
              },
            ),
          )
        ],
      )
    );
  }
}

Widget _buildItem(CartItem cartItem){
  return Row(
    children: [
      Image.asset(
        'assets/images/pizzas/${cartItem.pizza.image}',
        //height: 120,
        width: 100.0,
        //fit: BoxFit.fitWidth,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cartItem.pizza.title,
            style: PizzeriaStyle.baseTextStyle,
          ),
          Row(
            children: [
              Text('${cartItem.pizza.total} €'),
              IconButton(
                  onPressed: (){
                    cartItem.quantity--;
                    print(cartItem.quantity);
                  },
                  icon: Icon(Icons.remove_circle_outline)
              ),
              Text(cartItem.quantity.toString()),
              IconButton(
                  onPressed: () {
                    cartItem.quantity++;
                    print(cartItem.quantity);
                  },
                  icon: Icon(Icons.add_circle_outline)
              ),
            ],
          ),
          Text(
            'Sous total : ${cartItem.quantity * cartItem.pizza.total}',
            style: PizzeriaStyle.priceSubTotalTextStyle,
          ),
        ],
      )
    ],
  );
}
