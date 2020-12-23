import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fly_networking/fly.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/auth2/auth_state.dart';
import 'package:tagaddod/bloc/auth2/auth_event.dart';

import 'package:tagaddod/bloc/settings/bloc.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

import '../main_route.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc _authBloc = GetIt.instance<AuthBloc>();
  bool hasUser;
  String locale = "";
  StreamSubscription _settingsSub;
  StreamSubscription auth;
  SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();

  @override
  void initState() {
    auth = _authBloc.authStateSubject.listen((AuthState state) {
      print("here is the listner (initState) ");
      if (state is HasUser) {
        hasUser = state.has_user;
        print("there is noo  useer found");
        print(state.has_user);
        tryToProceed();
      }
    });
    _authBloc.dispatch(CheackHasUser());

    _settingsSub = _settingsBloc.settingsStateSubject.listen((state) {
      if (state is LanguageIsSelected) {
        setState(() {
          locale = state.language == CodeStrings.englishCode ? 'en' : 'ar';
        });
      }
    });
    _settingsBloc.dispatch(InitialLanguageRequested());

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _settingsSub.cancel();
    auth.cancel();
    super.dispose();
  }

  void tryToProceed() {
    if (hasUser == null) {
      return;
    }

    if (hasUser) {
      ExtendedNavigator.of(context)
          .pushAndRemoveUntil(Routes.homeScreen, (route) => false);
      return;
    } else {
      print("yesthere is nooooot");
      ExtendedNavigator.of(context)
          .pushAndRemoveUntil(Routes.loginScreen, (route) => false);
      //if we commented it we will see the logoo

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Directionality(
        textDirection: locale == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AssetStrings.bigLeaf,
                matchTextDirection: true,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Image.asset(
                  locale == "en"
                      ? AssetStrings.logoBusinessEnGreen
                      : AssetStrings.logoBusinessArGreen,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
