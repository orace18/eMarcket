import 'dart:convert';
import 'package:easy_market_client/api/api_contantes.dart';
import 'package:easy_market_client/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthClient {

  Future<bool> register(String nom, String prenom, String phone, String mail,
      String password) async {
    try {
      final body = jsonEncode({
        'lastname': nom,
        'firstname': prenom,
        'phone': phone,
        'email': mail,
        'password': password,
        'userType': userType
      });
      final resquest = await http.post(Uri.parse(registerUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      if (resquest.statusCode == 200 || resquest.statusCode == 201) {
        final res = jsonDecode(resquest.body);
        returnSuccess(res['message']);
        GetStorage().write('nom', res['user']['lastname']);
        GetStorage().write('prenom', res['user']['firstname']);
        GetStorage().write('email', res['user']['email']);
        GetStorage().write('id', res['user']['user_id']);
        GetStorage().write('phone', res['user']['phone']);
        GetStorage().write('token', res['token']);
        return true;
      } else {
        final res = jsonDecode(resquest.body);
        returnError(res['message']);
        return false;
      }
    } catch (error) {
      throw Exception('Erreur lors de l\'inscription');
    }
  }

  Future<bool> login(String mail, String password) async {
    final body = jsonEncode({'email': mail, 'password': password});
    try {
      final resquet = await http.post(Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'}, body: body);
      if (resquet.statusCode == 200 || resquet.statusCode == 201) {
        final res = jsonDecode(resquet.body);
        returnSuccess(res['message']);
        GetStorage().write('nom', res['lastname']);
        print(
            "Le nom est : ${GetStorage().write('nom', res['user']['lastname'])}");
        GetStorage().write('nom', res['user']['lastname']);
        GetStorage().write('prenom', res['user']['firstname']);
        GetStorage().write('email', res['user']['email']);
        GetStorage().write('id', res['user']['id']);
        GetStorage().write('phone', res['user']['phone']);
        GetStorage().write('token', res['token']);
        return true;
      } else {
        final res = jsonDecode(resquet.body);
        returnError(res['message']);
        return false;
      }
    } catch (error) {
      throw Exception('Erreur lors de la connexion');
    }
  }

  RxBool isLoggedIn = true.obs;
  final box = GetStorage();

  Future<void> logout() async {
    await box.write('isLoggedIn', false);
    isLoggedIn.value = false;
    Get.offAllNamed("/login");
  }  
}