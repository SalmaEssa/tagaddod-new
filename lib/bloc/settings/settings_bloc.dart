import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tagaddod/bloc/settings/settings_evet.dart';
import 'package:tagaddod/bloc/settings/settings_state.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/services/home.dart';
import 'package:tagaddod/services/language.dart';

import '../bloc.dart';

class SettingsBloc extends BLoC<SettingsEvent> {
  final PublishSubject<SettingsState> settingsStateSubject = PublishSubject();
  final LanguageService _languageService = GetIt.instance<LanguageService>();
  HomeService _homeService = GetIt.instance<HomeService>();
  String _language = LanguageService.deviceLanguage;
  final Fly _fly = GetIt.instance<Fly>();

  @override
  void dispatch(SettingsEvent event) async {
    if (event is InitialLanguageRequested) {
      print("InitialLanguageRequested");
      print(_language);
      await _getInitialLanguage();
    }

    if (event is ChangeLanguageTapped) {
      print("ChangeLanguageTapped");
      await _changeLanguage(event.langCode);
    }

    if (event is SetLanguageRequested) {
      print("SetLanguageRequested");
      await _changeLanguage(event.langCode);
    }
  }

  Future<void> _getInitialLanguage() async {
    print("_getInitialLanguage");

    _language = await _languageService.getLanguage();
    _fly.addHeaders({CodeStrings.languageHeader: _language});
    print(_language);
    settingsStateSubject.add(LanguageIsSelected(_language));
  }

  Future<void> _changeLanguage(String langCode) async {
    _languageService.setLanguage(langCode);
    AppStrings.setCurrentLocal(langCode);
    Collector collector = await _homeService.getCollector();
    _fly.addHeaders({CodeStrings.languageHeader: langCode});
    await _languageService.saveSelectedLanguage(
        langCode, collector.id); //i commented it
    settingsStateSubject.add(LanguageChanged());
  }

  dispose() {
    settingsStateSubject.close();
  }
}
