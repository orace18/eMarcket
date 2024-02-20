import 'package:easy_market_client/pages/categorie_page/controllers/categorie_binding.dart';
import 'package:easy_market_client/pages/categorie_page/index.dart';
import 'package:easy_market_client/pages/chat_page/index.dart';
import 'package:easy_market_client/pages/forgotpassword_page/controller/forgotpass_binding.dart';
import 'package:easy_market_client/pages/forgotpassword_page/index.dart';
import 'package:easy_market_client/pages/home_page/controllers/home_binding.dart';
import 'package:easy_market_client/pages/home_page/index.dart';
import 'package:easy_market_client/pages/login_page/controllers/login_binding.dart';
import 'package:easy_market_client/pages/login_page/index.dart';
import 'package:easy_market_client/pages/notification_page/index.dart';
import 'package:easy_market_client/pages/onboarding_page/controllers/onboarding_binding.dart';
import 'package:easy_market_client/pages/onboarding_page/index.dart';
import 'package:easy_market_client/pages/paiement_page/controllers/paiement_binding.dart';
import 'package:easy_market_client/pages/paiement_page/index.dart';
import 'package:easy_market_client/pages/panier_page/controllers/panier_binding.dart';
import 'package:easy_market_client/pages/panier_page/index.dart';
import 'package:easy_market_client/pages/profil_page/index.dart';
import 'package:easy_market_client/pages/register_page/controllers/register_binding.dart';
import 'package:easy_market_client/pages/register_page/index.dart';
import 'package:easy_market_client/pages/settings_page/controllers/setting_binding.dart';
import 'package:easy_market_client/pages/settings_page/index.dart';
import 'package:easy_market_client/pages/splash_page/controllers/splash_binding.dart';
import 'package:easy_market_client/pages/splash_page/index.dart';
import 'package:easy_market_client/pages/transaction_page/index.dart';
import 'package:easy_market_client/pages/wallet_page/controllers/wallet_binding.dart';
import 'package:easy_market_client/pages/wallet_page/index.dart';
import 'package:get/get.dart';

class AppRouter {
  static var routes = [
    GetPage(
      name: '/splash',
      page: () =>  SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: '/onboarding',
      page: () =>  OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: '/register',
      page: () =>  RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: '/login',
      page: () =>  LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/home',
      page: () =>  HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/chat',
      page: () =>  ChatPage(),
   // binding: HomeBinding(),
    ),
    GetPage(
      name: '/cart',
      page: () =>  MonPanierPage(),
      binding: PanierBinding(),
    ),
    GetPage(
      name: '/add',
      page: () =>  CategoriePage(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: '/notification',
      page: () =>  NotificationPage(),
    //  binding: HomeBinding(),
    ),
    GetPage(
      name: '/profil',
      page: () =>  ProfilePage(),
    //  binding: HomeBinding(),
    ),
    GetPage(
      name: '/setting',
      page: () =>  SettingsPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: '/paiement',
      page: () =>  PaymentPage(),
      binding: PaiementBinding(),
    ),
      GetPage(
      name: '/wallet',
      page: () =>  WalletPage(),
      binding: WalletBinding(),
    ),
     GetPage(
      name: '/forgotpass',
      page: () =>  ForgotPassPage(),
      binding: ForgotPassBinding(),
    ),
      GetPage(
      name: '/transaction',
      page: () =>  TransactionPage(),
    //  binding: HomeBinding(),
    ),
  ];
}
