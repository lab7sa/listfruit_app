import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'Fruit.dart';

class HttpHandler {

  static var _ROOT_URL = Uri.https('www.givethumb.com', '/tutorial/FruitApi/getFruit');


  static Future<List<Fruit>> getFruit()async {
    try {
      http.Response response = await http.get(_ROOT_URL);

      print('body data dtat ${response.body}');
      //Server return 200 ok response
      if (response.statusCode == 200) {

        print('body data 200 ${response.body}');
        //parse the JSON
        Iterable result = convert.jsonDecode(response.body);

        return result.map((fruit) => Fruit.fromJSON(fruit)).toList();
      } else {
        throw Exception('Failed to fitch fruit');
      }
    } catch (e) {
      return e;
    }
  }
}



