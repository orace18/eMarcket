import 'package:easy_market_client/pages/profil_page/controllers/profil_controller.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditePage extends StatelessWidget {
  final ProfilController _controller = Get.put(ProfilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('address'.tr),
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
                  name: 'address',
                  controller: _controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'address'.tr,
                    border: OutlineInputBorder(),
                  ),
                  validator: FormBuilderValidators.required(
                    errorText: 'imput_required'.tr,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_controller.validateForm()) {
                      print('Formulaire valide');
                      print(_controller.nameController.text);
                      GetStorage().write('addresse', _controller.nameController.text);
                    } else {
                      print('Formulaire invalide');
                    }
                  },
                  child: Text('send'.tr,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
