import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/models/cart.dart';
import 'package:pizzeria/models/pizza.dart';
import 'package:pizzeria/services/pizza_service.dart';
import 'package:pizzeria/ui/pizza_details.dart';
import 'package:pizzeria/ui/share/appbar_widget.dart';
import 'package:pizzeria/ui/share/bottom_navigation_bar_widget.dart';
import 'package:pizzeria/ui/share/buy_button_widget.dart';
import 'package:pizzeria/ui/share/pizzeria_style.dart';
import 'package:provider/provider.dart';

class PizzaList extends StatefulWidget {
  const PizzaList({Key? key}) : super(key: key);

  @override
  _PizzaListState createState() => _PizzaListState();
}

class _PizzaListState extends State<PizzaList> {
  late Future<List<Pizza>> _pizzas;
  PizzeriaService _service = PizzeriaService();

  @override
  void initState() {
    _pizzas = _service.fetchPizzas();
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<Cart>();

    return Scaffold(
        appBar: AppBarWidget('Nos pizzas', cart),
        body: FutureBuilder<List<Pizza>> (
          future: _pizzas,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return _buildListView(snapshot.data!);
            } else if (snapshot.hasError) {
              return Center (
                child: Text(
                  'Impossible de récupérer les données : ${snapshot.error}',
                  style: PizzeriaStyle.errorTextStyle,
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      bottomNavigationBar: BottomNavigationBarWidget(2),
    );
  }

  _buildListView(List<Pizza> pizzas) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: pizzas.length,
      itemBuilder: (context, index) {
        return _buildRow(context, pizzas[index]);
      },
    );
  }

  _buildRow(BuildContext context, Pizza pizza) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0), top: Radius.circular(2.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PizzaDetails(pizza),
                  ),
                );
              },
              child: _buildPizzaDetails(pizza),
            ),
            BuyButtonWidget(pizza)
          ],
        )
    );
  }

  _buildPizzaDetails(Pizza pizza) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(pizza.title),
          subtitle: Text(pizza.garniture),
          leading: Icon(Icons.local_pizza),
        ),
        Image.asset(
          pizza.image,
          height: 120,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fitWidth,
        ),
        Container(
          padding: const EdgeInsets.all(4.0),
          child: Text(pizza.garniture),
        )
      ],
    );
  }

  _buildBuyButton() {
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
  }
}
