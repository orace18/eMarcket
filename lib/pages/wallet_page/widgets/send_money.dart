
import 'package:easy_market_client/pages/wallet_page/controllers/wallet_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SendMoneyPage extends StatelessWidget {
  final WalletController _controller = Get.put(WalletController());
  String phoneText = '';
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
                  'recharge'.tr+ ' ' +'other_user'.tr +' '+'since_your_wallet'.tr,
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
                      InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          phoneText = number.phoneNumber ?? '';

                          print('Le phone code $number');
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
                      SizedBox(height: 8),
                      FormBuilderTextField(
                        keyboardType: TextInputType.phone,
                        name: 'amount',
                        controller: _controller.amountController,
                        decoration: InputDecoration(
                          labelText: 'amount'.tr,
                          border: OutlineInputBorder(),
                        ),
                        obscureText: false,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'imput_required'.tr),
                          FormBuilderValidators.minLength(3,
                              errorText: 'short'.tr),
                        ]),
                      ),
                      SizedBox(height: 16),
                     
                      ElevatedButton(
                        onPressed: () async {
                          if (_controller.validateForm()) {
                            print('Formulaire valide');
                            print(_controller.amountController.text);
                            print("Le num est :$phoneText");
                            bool isValid = await _controller.sendMoney(
                                phoneText,
                               int.parse(_controller.amountController.text));
                            if (isValid == true) {
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
                        child: Text(
                          'recharge'.tr,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
