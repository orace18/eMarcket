import 'package:easy_market_client/api/auth/api_auth_client.dart';
import 'package:easy_market_client/pages/register_page/controllers/register_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterPage extends StatelessWidget {
  final RegisterController _controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign_in'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilderTextField(
                  name: 'name',
                  controller: _controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'lastname'.tr,
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(
                    errorText: 'imput_required'.tr,
                  ),
                ),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'lastName',
                  controller: _controller.lastNameController,
                  decoration: InputDecoration(
                    labelText: 'firstname'.tr,
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(
                    errorText: 'imput_required'.tr,
                  ),
                ),
                SizedBox(height: 8),
                FormBuilderTextField(
                  name: 'email',
                  controller: _controller.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'imput_required'.tr,
                    ),
                    FormBuilderValidators.email(
                      errorText: 'email_invalid'.tr,
                    ),
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
                      errorText: 'imput_required',
                    ),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: 'so_short'.tr,
                    ),
                  ]),
                ),
                SizedBox(height: 16),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    String phoneText = number.phoneNumber ?? '';
                    //String countryCode = number.isoCode ?? '';
                    _controller.phoneController.text = '$phoneText';
                  },
                  initialValue: PhoneNumber(isoCode: 'BJ'),
                  inputDecoration: InputDecoration(
                    labelText: 'phone'.tr,
                    border: OutlineInputBorder(),
                  ),
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.validateForm()) {
                      print('Formulaire valide');
                      print(_controller.nameController.text);
                      print(_controller.lastNameController.text);
                      print(_controller.emailController.text);
                      print(_controller.passwordController.text);
                      print(_controller.phoneController.text);
                      bool isValid = await AuthClient().register(
                          _controller.nameController.text,
                          _controller.lastNameController.text,
                          _controller.phoneController.text,
                          _controller.emailController.text,
                          _controller.passwordController.text);
                      if (isValid == true) {
                        GetStorage().write('register', true);
                        Get.offNamed('/home');
                      }
                    } else {
                      print('Formulaire invalide');
                    }
                  },
                  child: Text(
                    'let_signup'.tr,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.easyMarketMaterial,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    'have_account'.tr,
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
