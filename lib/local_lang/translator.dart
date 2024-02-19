import 'package:easy_market_client/local_lang/lang/en_us.dart';
import 'package:easy_market_client/local_lang/lang/fr_fr.dart';
import 'package:get/get.dart';


class Translator extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {'en_US': en_US, 'fr_FR': fr_FR};

}