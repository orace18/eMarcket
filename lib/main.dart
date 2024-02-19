import 'package:easy_market_client/local_lang/translator.dart';
import 'package:easy_market_client/notification_service.dart';
import 'package:easy_market_client/providers/themes/theme.dart';
import 'package:easy_market_client/providers/themes/theme_provider.dart';
import 'package:easy_market_client/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider();
    return GetMaterialApp(
      navigatorKey: Get.key,
      translations: Translator(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      title: 'Easy Market',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.theme,
      initialRoute: '/splash',
      getPages: AppRouter.routes,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
    );
  }
}
