import 'dart:ui';

import 'package:flutter_device_locale/flutter_device_locale.dart';
import 'package:fly_networking/GraphQB/graph_qb.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/home/home_bloc.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/provider/shared_preferences_provider.dart';
import 'dart:ui' as ui;

import 'package:tagaddod/resources/strings.dart';

/// This class contains the most common features that a user needs to
/// update the app language depending on the device language.
/// It also updates the server with the current used language to adopt in future responses

/// TODO: THIS IS JUST A COMMON USE CASE. SOME CHANGES MAY APPLY TO MATCH YOUR PROJECT USE CASE

class LanguageService {
  final Fly _fly = GetIt.instance<Fly>();
  String selectedLangCode;

  LanguageService() {
    selectedLangCode = deviceLanguage;
  }
  void setLanguage(String lang) {
    selectedLangCode = lang;
  }

  Future<String> getLanguage() async {
    SharedPreferencesProvider sharedPrefs = SharedPreferencesProvider();
    String selectedLanguage = await sharedPrefs.getLanguage();
    if (selectedLanguage == null) {
      Locale mobileLocale = await DeviceLocale.getCurrentLocale();
      return mobileLocale.languageCode;
    }
    return selectedLanguage;
  }

  Future<void> saveSelectedLanguage(String lang,String id) async {
    SharedPreferencesProvider sharedPrefs = SharedPreferencesProvider();
    selectedLangCode = lang;
    sharedPrefs.setLanguage(lang);

    selectedLangCode = lang ?? selectedLangCode;

    // if (id == null) return;

    // Node changeLanguageNode = Node(
    //   name: CodeStrings.updateCollectorNodeName,
    //   args: {
    //     CodeStrings.idColumn: id,
    //     CodeStrings.localeArgument: selectedLangCode,
    //   },
    //   cols: [CodeStrings.idColumn],
    // );

    // await _fly.mutation([changeLanguageNode]);
  }

  static String get deviceLanguage {
    String lang = ui.window.locale?.languageCode;

    if (lang != CodeStrings.englishCode && lang != CodeStrings.arabicCode) {
      return CodeStrings.englishCode;
    }

    return lang;
  }
}
