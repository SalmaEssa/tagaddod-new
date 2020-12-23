abstract class SettingsState {}

class LanguageIsSelected extends SettingsState {
  final String language;

  LanguageIsSelected(this.language);
}

class LanguageChanged extends SettingsState{}
