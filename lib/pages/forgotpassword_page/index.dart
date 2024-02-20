import 'package:easy_market_client/pages/forgotpassword_page/controller/forgotpass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassPage extends StatelessWidget {
  final ForgotPassController controller = Get.put(ForgotPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('forgot_password'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onChanged: (value) => controller.setEmail(value),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => controller.validateEmail(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.submitEmail(),
                child: Text('submit'.tr, style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
