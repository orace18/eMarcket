import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var quantity = 1.obs;
  var price = 5.8.obs;
  var discount = 20.obs;
  String id = GetStorage().read('id').toString();

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }

  double get totalPrice {
    return price.value * quantity.value * (1 - discount.value / 100);
  }

  Future<void> addToCart(String userId, String articleId, int quantity) async {
    final body = jsonEncode({
        'userId': userId,
        'articleId': articleId,
        'quantity' : quantity
      });
    try {
      final response = await http.post(Uri.parse(addToCartUrl),
      headers: {'Content-Type': 'application/json'},
      body: body
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        returnSuccess(res['message']);
      }else{
        final res = jsonDecode(response.body);
        returnSuccess(res['message']); 
      }
    } catch (e) {
      throw Exception('Error to add to cart: $e');
    }
  }

}
