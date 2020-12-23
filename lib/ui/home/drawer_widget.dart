import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/home/bloc.dart';
import 'package:tagaddod/main_route.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'dart:math';

import 'package:tagaddod/ui/home/change_language_dialoug.dart';
import 'package:tagaddod/ui/home/logout_dialog.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final TextDirection td = AppStrings.currentCode == CodeStrings.arabicCode
      ? TextDirection.ltr
      : TextDirection.rtl;

  String language = AppStrings.currentCode == CodeStrings.arabicCode
      ? AppStrings.arabic
      : AppStrings.english;

  HomeBloc homeBloc = GetIt.instance<HomeBloc>();
  StreamSubscription sub;
  Collector collector;

  @override
  void initState() {
    // TODO: implement initState
    sub = homeBloc.homeSubject.listen((state) {
      if (state is CollectorIs) {
        setState(() {
          collector = state.collector;
        });
      }
    });
    homeBloc.dispatch(CollectorRequested());
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
    return SizedBox(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildHeader(),
              InkWell(
                onTap: () {
                  ExtendedNavigator.of(context).pop();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) {
                        return ChangeLanguageDialoug();
                      });
                },
                child: _buildListItem(Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.language,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    Text(language,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryDark)),
                  ],
                )),
              ),
              InkWell(
                onTap: () {
                  ExtendedNavigator.of(context).push(Routes.pastRequestsScreen);
                },
                child: _buildListItem(Text(AppStrings.requestHistory,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
              ),
              /*  InkWell(
                onTap: () {
                  ExtendedNavigator.of(context).push(Routes.home2);
                },
                child: _buildListItem(Text(AppStrings.address,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
              ),*/
              _buildListItem(Text(AppStrings.contactSupport,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
              InkWell(
                onTap: () {
                  ExtendedNavigator.of(context).pop();
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) {
                        return LogoutDialog();
                      });
                },
                child: _buildListItem(Text(AppStrings.logout,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.redError))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  AssetStrings.leafRotated,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 130),
        decoration: BoxDecoration(
          color: AppColors.primaryDark,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Image.asset(
                AssetStrings.smallLeaf,
                fit: BoxFit.cover,
                height: 100,
                matchTextDirection: true,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 15, bottom: 5),
              child: Text(
                collector != null ? collector.name : "",
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                  top: 5, start: 15, bottom: 30),
              child: Text(
                collector != null ? collector.phone : "",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ));
  }

  Widget _buildListItem(Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: child,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(color: AppColors.borderColor),
        )
      ],
    );
  }
}
