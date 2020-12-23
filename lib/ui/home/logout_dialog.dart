import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/auth2/auth_state.dart';
import 'package:tagaddod/bloc/auth2/auth_event.dart';

import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

import '../../main_route.dart';

class LogoutDialog extends StatefulWidget {
  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  AuthBloc _authBloc = GetIt.instance<AuthBloc>();
  StreamSubscription sub;

  @override
  void initState() {
    // TODO: implement initState
    sub = _authBloc.authStateSubject.listen((state) {
      if (state is LogedOut) {
        ExtendedNavigator.of(context)
            .pushAndRemoveUntil(Routes.loginScreen, (route) => false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 30),
              child: Text(
                AppStrings.sureToLogout,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20.0),
                  child: InkWell(
                    onTap: () {
                      _authBloc.dispatch(LogOut());
                    },
                    child: Text(
                      AppStrings.logout,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.redError),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ExtendedNavigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.cancel,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.primary),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
