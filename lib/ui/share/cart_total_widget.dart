import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';

class _CartTotal extends StatelessWidget {
  var format = NumberFormat("####.00 €");

  @override
  Widget build (BuildContext context){
    return Container(
      padding: EdgeInsets.all(12.0),
      height: 220,
      child: Consumer<Cart>(
        builder: (context, cart, child) {
          final double _total = cart.getPrixTotalTTC();

          if(_total == 0){
            return Center(
              child: Text('Aucun produit',
              style: PizzeriaStyle.priceTotalTextStyle,
              ),
            );
          } else {
            return Column(
              children: [
                Table(
                  columnWidths: {
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                        children: [
                          TableCell(child: Text('TOTAL HT', style: PizzeriaStyle.priceSubTotalTextStyle)),
                          TableCell(child: Text('${format.format(cart.getPrixTotalHt())}', style: PizzeriaStyle.priceSubTotalTextStyle))
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(child: Text('TVA', style: PizzeriaStyle.priceSubTotalTextStyle)),
                          TableCell(child: Text('${format.format(cart.getTva(cart.getPrixTotalHt()))}', style: PizzeriaStyle.priceSubTotalTextStyle))
                        ]
                    ),
                    TableRow(
                        children: [
                          TableCell(child: Text('TOTAL TTC', style: PizzeriaStyle.priceTotalTextStyle)),
                          TableCell(child: Text('${format.format(cart.getPrixTotalTTC())}', style: PizzeriaStyle.priceTotalTextStyle))
                        ]
                    )
                  ],
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
            );
          }
        }
      ),
    );
  }
}