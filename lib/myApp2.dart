import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/auth2/auth_state.dart';
import 'package:tagaddod/bloc/auth2/auth_event.dart';

import 'package:tagaddod/resources/strings.dart';
import 'package:auto_route/auto_route.dart';
import 'main_route.dart';
import 'package:get_it/get_it.dart';
import './bloc/settings/settings_bloc.dart';
import './bloc/settings/settings_evet.dart';
import './bloc/settings/settings_state.dart';
import 'package:tagaddod/resources/themes.dart';

import 'dart:async';
import 'package:flutter/rendering.dart';
import './bloc/root/root_bloc.dart';
import './bloc/root/root_event.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RootBloc _rootBloc;
  SettingsBloc _settingBloc;
  StreamSubscription settingsSub;
  String local_lang;
  AuthBloc _authBloc;
  StreamSubscription _authSub;

  void _initializeAfterLogout() {
    _authBloc = GetIt.instance<AuthBloc>();
    _authSub = _authBloc.authStateSubject.listen((state) {
      if (state is LogedOut) {
        _settingBloc.dispatch(InitialLanguageRequested());
        _rootBloc.dispatch(ModulesRestarted());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();

    GetIt.instance.registerSingleton<RootBloc>(RootBloc());
    _rootBloc = GetIt.instance<RootBloc>();
    _rootBloc.dispatch(ModulesInitialized());
    print("firist");
    _settingBloc = GetIt.instance<SettingsBloc>();
    print("second");

    _settingBloc.dispatch(InitialLanguageRequested());
    _initializeAfterLogout();
    _rootBloc.dispatch(PackageInfoRequested());

    settingsSub =
        _settingBloc.settingsStateSubject.listen((SettingsState state) {
      if (state is LanguageIsSelected) {
        if (state.language != CodeStrings.englishCode &&
            state.language != CodeStrings.arabicCode) {
          setState(() {
            local_lang = CodeStrings.arabicCode;
          });
        } else {
          setState(() {
            local_lang = state.language;
          });
        }
        AppStrings.setCurrentLocal(local_lang);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: local_lang == CodeStrings.arabicCode
            ? AppThemes.arabicAppTheme
            : AppThemes.englishAppTheme,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        builder: ExtendedNavigator.builder<MainRouter>(
            router: MainRouter(),
            builder: (context, extendedNav) {
              return Directionality(
                textDirection: local_lang == CodeStrings.arabicCode
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: extendedNav,
              );
            }));
  }
}
