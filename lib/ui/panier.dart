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
  double tva = 0.0;

  setTva(){
    setState(() {
      tva = widget._cart.totalItems() / 100 * 20;
    });
    return tva;
  }

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
          Container(
            child: (
              Table(
                columnWidths: {
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Text('TOTL HT', style: PizzeriaStyle.priceSubTotalTextStyle)),
                      TableCell(child: Text('${(widget._cart.getPrixTotalHt())} €', style: PizzeriaStyle.priceSubTotalTextStyle))
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('TVA', style: PizzeriaStyle.priceSubTotalTextStyle)),
                      TableCell(child: Text('${(widget._cart.getTva(widget._cart.getPrixTotalHt()))} €', style: PizzeriaStyle.priceSubTotalTextStyle))
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('TOTAL TTC', style: PizzeriaStyle.priceTotalTextStyle)),
                      TableCell(child: Text('${(widget._cart.getPrixTotalTTC())} €', style: PizzeriaStyle.priceTotalTextStyle))
                    ]
                  )
                ],
              )
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red.shade800),
              ),
              child: Text('Valider le panier'),
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
          Text('${cartItem.pizza.total} €'),
          Text(
            'Sous total : ${cartItem.quantity * cartItem.pizza.total}',
            style: PizzeriaStyle.priceSubTotalTextStyle,
          ),
        ],
      ),
      Row(
        children: [
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
      )
    ],
  );
}
