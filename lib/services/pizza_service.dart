import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pizzeria/models/pizza.dart';

class PizzeriaService {
  // local host ip
  static final String uri = 'http://10.0.2.2/api/';
  
  Future<List<Pizza>> fetchPizzas() async {
    List<Pizza> list = [];
    
    try {
      final response = await http
          .get(Uri.parse('${uri}/pizzas.php'));

      if (response.statusCode == 200){
        var json = jsonDecode(utf8.decode(response.bodyBytes));
        for(final value in json){
          list.add(Pizza.fromJson(value));
        }
      } else {
        throw new Exception('Impossible de récupérer les pizzas');
      }
    } catch (e) {
      throw (e);
    }

    return list;
  }
}