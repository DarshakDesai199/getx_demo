import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class ApiServices {
  static Future<List<Poduct>?> fetchProducts() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'),
    );
    if (response.statusCode == 200) {
      return poductFromJson(response.body);
    }
    return null;
  }
}
