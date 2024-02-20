import 'package:easy_market_client/api/auth/api_auth_client.dart';
import 'package:easy_market_client/pages/login_page/controllers/login_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Légende
                Text(
                  'welcome_text'.tr,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // Formulaire
                FormBuilder(
                  key: _controller.formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        controller: _controller.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'imput_required'.tr),
                          FormBuilderValidators.email(
                              errorText: 'email_invalid'.tr),
                        ]),
                      ),
                      SizedBox(height: 8),
                      FormBuilderTextField(
                        name: 'password',
                        controller: _controller.passwordController,
                        decoration: InputDecoration(
                          labelText: 'password'.tr,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'imput_required'.tr),
                          FormBuilderValidators.minLength(6,
                              errorText: 'so_short'.tr),
                        ]),
                      ),
                      SizedBox(height: 16),
                          Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed('/forgotpass');
                          },
                          child: Text(
                            'forgot_password'.tr,
                            style: TextStyle(
                                color: AppTheme.easyMarketMaterial[100]),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      ElevatedButton(
                        onPressed: () async {
                          if (_controller.validateForm()) {
                            print('Formulaire valide');
                            print(_controller.emailController.text);
                            print(_controller.passwordController.text);
                            bool isValid = await AuthClient().login(
                                _controller.emailController.text,
                                _controller.passwordController.text);
                            if (isValid == true) {
                              GetStorage().write('login', true);
                              Get.offNamed('/home');
                            }
                          } else {
                            print('Formulaire invalide');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.easyMarketMaterial,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10),
                            ),
                          ),
                        ),
                        child: Text('let_login'.tr, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Get.toNamed('/register');
                  },
                  child: Text(
                    'havent_account'.tr,
                    style: TextStyle(color: AppTheme.easyMarketMaterial[100]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
