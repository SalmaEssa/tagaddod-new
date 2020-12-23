import 'package:auth_provider/AuthProvider.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tagaddod/PODO/user.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/location/location_bloc.dart';
import 'package:tagaddod/bloc/home/home_bloc.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/bloc/root/root_event.dart';
import 'package:tagaddod/bloc/settings/settings_bloc.dart';
import 'package:tagaddod/provider/shared_preferences_provider.dart';
import 'package:tagaddod/resources/links.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/services/home.dart';
import 'package:tagaddod/services/language.dart';
import 'package:tagaddod/services/request.dart';
import 'package:tagaddod/services/user_service.dart';

import '../bloc.dart';

class RootBloc extends BLoC<RootEvent> {
  SharedPreferencesProvider _sharedPreferencesProvider;

  @override
  void dispatch(RootEvent event) async {
    if (event is ModulesInitialized) {
      _initData();
      _initSharedPreferences();
    }

    if (event is ModulesRestarted) {
      // _initData();
      //_initSharedPreferences();
    }

    if (event is PackageInfoRequested) {}
  }

  void _initData() {
    GetIt.instance.reset();
    String gqLink = AppLinks.protocol + AppLinks.apiBaseLink + "/graphql";

    GetIt.instance.registerSingleton<Fly<dynamic>>(Fly<dynamic>(gqLink));
    GetIt.instance
        .registerLazySingleton<AuthProvider>(() => AuthProvider(User()));
    GetIt.instance.registerSingleton<UserService>(UserService());
    GetIt.instance
        .registerLazySingleton<LanguageService>(() => LanguageService());
    GetIt.instance.registerSingleton<SharedPreferencesProvider>(
        SharedPreferencesProvider());
    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
    GetIt.instance.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
    GetIt.instance.registerLazySingleton<LocationBloc>(() => LocationBloc());
    GetIt.instance.registerLazySingleton<HomeBloc>(() => HomeBloc());
    GetIt.instance.registerLazySingleton<HomeService>(() => HomeService());
    GetIt.instance
        .registerLazySingleton<RequestService>(() => RequestService());
    GetIt.instance.registerLazySingleton<RequestBloc>(() => RequestBloc());
  }

  void _restartGetIt() {
    GetIt.instance.registerSingleton<RootBloc>(RootBloc());
    GetIt.instance
        .registerLazySingleton<AuthProvider>(() => AuthProvider(User()));
    GetIt.instance.registerSingleton<UserService>(UserService());
    GetIt.instance
        .registerLazySingleton<LanguageService>(() => LanguageService());
    GetIt.instance.registerSingleton<SharedPreferencesProvider>(
        SharedPreferencesProvider());
    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
    GetIt.instance.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
    GetIt.instance.registerLazySingleton<LocationBloc>(() => LocationBloc());

    GetIt.instance.registerLazySingleton<HomeBloc>(() => HomeBloc());
    GetIt.instance.registerLazySingleton<HomeService>(() => HomeService());
  }

  Future<void> _getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print("App name is $appName");
    print("Package name is $packageName");
    print("Version is $version");
    print("Build number is $buildNumber");

    String cachedBuild = await _sharedPreferencesProvider
        .getBuildNumber(CodeStrings.buildNumberKey);
    if (cachedBuild == null ||
        int.parse(buildNumber) > int.parse(cachedBuild)) {
      _clearCache();
      _sharedPreferencesProvider.setBuildNumber(buildNumber);
    }
  }

  void _clearCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  void _initSharedPreferences() {
    _sharedPreferencesProvider = GetIt.instance<SharedPreferencesProvider>();
  }
}
