import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/settings/settings_bloc.dart';
import 'package:tagaddod/bloc/settings/settings_evet.dart';
import 'package:tagaddod/bloc/settings/settings_state.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/shared_widgets/restart_widget.dart';
import '../../main_route.dart';

class ChangeLanguageDialoug extends StatefulWidget {
  @override
  _ChangeLanguageDialougState createState() => _ChangeLanguageDialougState();
}

class _ChangeLanguageDialougState extends State<ChangeLanguageDialoug> {
  String selectedLang = AppStrings.currentCode == CodeStrings.arabicCode
      ? CodeStrings.arabicCode
      : CodeStrings.englishCode;
  SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  StreamSubscription sub;
  @override
  void initState() {
    // TODO: implement initState
    sub = _settingsBloc.settingsStateSubject.listen((state) {
      if (state is LanguageChanged) {
        ExtendedNavigator.of(context).push(Routes.splashScreen);

        //RestartWidget.restartApp(context); //???
        // setState(() {});
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
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.chooseLanguage,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              title: Text(
                AppStrings.arabic,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.accentYellow,
                value: CodeStrings.arabicCode,
                groupValue: selectedLang,
                onChanged: (String value) {
                  setState(() {
                    selectedLang = value;
                    print(selectedLang);
                  });
                },
              ),
            ),
            ListTile(
              title: Text(
                AppStrings.english,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              leading: Radio(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: AppColors.accentYellow,
                value: CodeStrings.englishCode,
                groupValue: selectedLang,
                onChanged: (String value) {
                  setState(() {
                    selectedLang = value;
                    print(selectedLang);
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20.0),
                    child: InkWell(
                      onTap: () {
                        print(selectedLang);
                        if (AppStrings.currentCode != selectedLang) {
                          _settingsBloc
                              .dispatch(ChangeLanguageTapped(selectedLang));
                        }
                        if (AppStrings.currentCode == selectedLang) {
                          ExtendedNavigator.of(context).pop();
                        }
                      },
                      child: Text(
                        AppStrings.confirm,
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
            ),
          ],
        ),
      ),
    );
  }
}
