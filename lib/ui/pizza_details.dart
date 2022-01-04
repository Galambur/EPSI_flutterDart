import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/option_item.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:pizzeria/ui/share/total_widget.dart';
import 'package:provider/provider.dart';

class PizzaDetails extends StatefulWidget {
  final Pizza _pizza;

  PizzaDetails(this._pizza, {Key? key}) : super(key: key);

  @override
  _PizzaDetailsState createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<PizzaDetails> {
  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
      appBar: AppBarWidget(widget._pizza.title, cart),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          Text(
            'Pizza ${widget._pizza.title}',
            style: PizzeriaStyle.pageTitleTextStyle,
          ),
          Image.asset(
            widget._pizza.image,
            height: 180,
          ),
          Text(
            'Recette',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: Text(widget._pizza.garniture),
          ),
          Text(
            'Pâte et taille sélectionnées',
            style: PizzeriaStyle.headerTextStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _buildDropDownPates()),
              Expanded(child: _buildDropDownTailles()),
            ],
          ),
          Text(
            'Sauces sélectionnées',
            style: PizzeriaStyle.headerTextStyle,
          ),
          _buildDropDownSauces(),
          TotalWidget(widget._pizza.total),
          BuyButtonWidget(widget._pizza),
        ],
      )
    );
  }

  _buildDropDownPates(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.pates[widget._pizza.pate],
      items: _buildDropDownItems(Pizza.pates),
      onChanged: (item) {
        setState(() {
          widget._pizza.pate = item!.value;
        });
      },
    );
  }

  _buildDropDownTailles(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.tailles[widget._pizza.taille],
      items: _buildDropDownItems(Pizza.tailles),
      onChanged: (item) {
        setState(() {
          widget._pizza.taille = item!.value;
        });
      },
    );
  }

  _buildDropDownSauces(){
    return DropdownButton<OptionItem>(
      isExpanded: true,
      value: Pizza.sauces[widget._pizza.sauce],
      items: _buildDropDownItems(Pizza.sauces),
      onChanged: (item) {
        setState(() {
          widget._pizza.sauce = item!.value;
        });
      },
    );
  }

  _buildDropDownItems(List<OptionItem> list){
    return Iterable.generate(
      list.length,
        (i) => DropdownMenuItem<OptionItem>(
          value: list[i],
          child: Text(list[i].name),
        ),
    ).toList();
  }

  /*_buildBuyButton() {
    return Row (
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red.shade800)
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(width: 5),
              Text("Commander"),
            ],
          ),
          onPressed: () {
            print('Commander une pizza');
          },
        )
      ],
    );
  }*/
}
