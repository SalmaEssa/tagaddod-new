abstract class SettingsEvent{}

class InitialLanguageRequested extends SettingsEvent{}

class ChangeLanguageTapped extends SettingsEvent{
  String langCode;
  ChangeLanguageTapped(this.langCode);
}

class SetLanguageRequested extends SettingsEvent{
  String langCode;
  SetLanguageRequested(this.langCode);
}