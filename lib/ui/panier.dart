import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';

class Panier extends StatefulWidget {
  final Cart _cart;
  const Panier(this._cart, {Key? key}): super (key : key);

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
                      TableCell(child: Text('TOTAL HT', style: PizzeriaStyle.priceSubTotalTextStyle)),
                      TableCell(child: Text('${formatter.format(widget._cart.getPrixTotalHt())}', style: PizzeriaStyle.priceSubTotalTextStyle))
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('TVA', style: PizzeriaStyle.priceSubTotalTextStyle)),
                      TableCell(child: Text('${formatter.format(widget._cart.getTva(widget._cart.getPrixTotalHt()))}', style: PizzeriaStyle.priceSubTotalTextStyle))
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(child: Text('TOTAL TTC', style: PizzeriaStyle.priceTotalTextStyle)),
                      TableCell(child: Text('${formatter.format(widget._cart.getPrixTotalTTC())}', style: PizzeriaStyle.priceTotalTextStyle))
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

  Widget _buildItem(CartItem cartItem){
    return Row(
      children: [
        Image.asset(
          cartItem.pizza.image,
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
              'Sous total : ${cartItem.quantity * cartItem.pizza.total} €',
              style: PizzeriaStyle.priceSubTotalTextStyle,
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget._cart.removeOneProduct(cartItem.pizza);
                  });
                },
                child: Icon(Icons.remove_rounded)
            ),
            Text(cartItem.quantity.toString()),
            GestureDetector(
                onTap: () {
                  setState(() {
                    widget._cart.addProduct(cartItem.pizza);
                  });
                },
                child: Icon(Icons.add_rounded)
            )
          ],
        )
      ],
    );
  }
}


