import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  SharedPreferences prefs;
  String LINK = "Link";
  String BUILDNUMBER = "build";
  String LANGUAGE = "Language";

  void setLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANGUAGE, language);
  }

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LANGUAGE);
  }

  void setBuildNumber(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(BUILDNUMBER, number);
  }

  Future<String> getBuildNumber(String BUILD) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BUILD);
  }

  void setLink(String link) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LINK, link);
  }

  Future<String> getLink(String LINK) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LINK) == null) {
      return null;
    }
    String link = prefs.getString(LINK);
    return link;
  }
}
