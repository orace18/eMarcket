import 'package:easy_market_client/helpers/constants.dart';
import 'package:easy_market_client/pages/paiement_page/controllers/paiement_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PaymentPage extends GetWidget<PaiementController> {
  @override
  Widget build(BuildContext context) {
    PaiementController controller = Get.put(PaiementController());
    return Scaffold(
      appBar: AppBar(
        title: Text('payment'.tr),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    String phoneText = number.phoneNumber ?? '';
                    String country = number.dialCode ?? '';
                    String phoneNumberWithoutCode =
                        phoneText.substring(country.length);
                    controller.phoneIsoCode = number.isoCode ?? 'BJ';
                    controller.phoneNumberController.text =
                        '$phoneNumberWithoutCode';
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
                SizedBox(height: 16),
                TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller.reasonController,
                  decoration: InputDecoration(
                    labelText: 'reason'.tr,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: controller.amountController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'amount'.tr,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    String email = controller.emailController.text;
                    String country = controller.phoneNumberController.text;
                    String reason = controller.reasonController.text;
                    String montantText = controller.amountController.text;
                    int montant = int.parse(montantText);
                    Get.to(controller.openKkiapayPayment());
                   // controller.makeRecharge(montant, '45454545');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.easyMarketMaterial,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)),
                    ),
                  ),
                  child: Text('recharge'.tr,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
