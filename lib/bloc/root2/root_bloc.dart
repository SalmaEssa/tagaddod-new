import '../bloc.dart';

import 'package:auth_provider/AuthProvider.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';

import 'package:tagaddod/resources/links.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/root2/root_event.dart';
import 'package:tagaddod/bloc/settings/settings_bloc.dart';

import 'package:tagaddod/services/user_service.dart';
import 'package:tagaddod/services/language.dart';
import 'package:tagaddod/podo/user.dart';
import 'package:tagaddod/provider/shared_preferences_provider.dart';

class RootBloc extends BLoC<RootEvent> {
  @override
  SharedPreferencesProvider _sharedPreferencesProvider;

  void dispatch(RootEvent event) async {
    if (event is ModulesInitialized) {
      initialize();
    }
  }

  void initialize() {
    GetIt.instance.reset();

    GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc());
    GetIt.instance.registerLazySingleton<SettingsBloc>(() => SettingsBloc());
    GetIt.instance
        .registerLazySingleton<LanguageService>(() => LanguageService());

    GetIt.instance.registerSingleton<AuthProvider>(AuthProvider(User()));

    String gqLink = AppLinks.protocol + AppLinks.apiBaseLink + "/graphql";
    GetIt.instance
        .registerLazySingleton<Fly<dynamic>>(() => Fly<dynamic>(gqLink));
    GetIt.instance.registerSingleton<UserService>(UserService());
    GetIt.instance.registerSingleton<SharedPreferencesProvider>(
        SharedPreferencesProvider());

    _sharedPreferencesProvider = GetIt.instance<SharedPreferencesProvider>();
  }
}
