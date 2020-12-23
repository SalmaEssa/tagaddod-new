import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/home/bloc.dart';
import 'package:tagaddod/bloc/settings/bloc.dart';
import 'package:tagaddod/podo/collector.dart';
import 'package:tagaddod/podo/regionRequest.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/home/drawer_widget.dart';
import 'package:tagaddod/ui/shared_widgets/common_headers.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../main_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _streamSubscription;
  StreamSubscription _settingsSub;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  HomeBloc _homeBloc = GetIt.instance<HomeBloc>();
  SettingsBloc _settingsBloc = GetIt.instance<SettingsBloc>();
  String greeting = "";
  TimeOfDay now = TimeOfDay.now();
  int yesterdaySuccessReqs = 0;
  int monthSuccessReqs = 0;
  int yesterdayFailReqs = 0;
  int monthFailReqs = 0;
  int todayPendingReqs = 0;
  int todayFailedReqs = 0;
  int todayCollectedReqs = 0;
  List<RegionRequest> regionRequests = [];
  Collector collector;
  bool loading = true;

  @override
  void initState() {
    initializeDateFormatting();

    _settingsSub = _settingsBloc.settingsStateSubject.listen((state) {
      if (state is LanguageIsSelected) {
        setState(() {
          Intl.defaultLocale =
              state.language == CodeStrings.englishCode ? 'en' : 'ar';

          /// to chose the date will be arabic or english
        });
      }
    });
    _settingsBloc.dispatch(InitialLanguageRequested());

    _streamSubscription = _homeBloc.homeSubject.listen((state) {
      if (state is PastSuccessRequestsAre) {
        setState(() {
          yesterdaySuccessReqs = state.yestertdayReqs;
          monthSuccessReqs = state.monthReqs;
        });
      }
      if (state is PastFailedRequestsAre) {
        setState(() {
          yesterdayFailReqs = state.yestertdayReqs;
          monthFailReqs = state.monthReqs;
        });
      }
      if (state is TodayRequestsAre) {
        setState(() {
          todayCollectedReqs = state.collected;
          todayPendingReqs = state.pending;
          todayFailedReqs = state.failed;
        });
      }
      if (state is RegionRequestsAre) {
        setState(() {
          regionRequests = state.regionRequests;
        });
      }
      if (state is CollectorIs) {
        setState(() {
          collector = state.collector;
          loading = false;
        });
      }
    });
    _homeBloc.dispatch(HomePageLaunched());
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _settingsSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrayBackground,
      key: _scaffoldKey,
      drawer: SideDrawer(),
      body: loading
          ? _buildLoadingWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleHeader(child: _buildHeaderChild()),
                  (todayCollectedReqs != 0 ||
                          todayFailedReqs != 0 ||
                          todayPendingReqs != 0)
                      ? _buildTodaysRequestWidget()
                      : _buildEmptyWidget(AppStrings.todayRequests,
                          AppStrings.noRequestsToday, AssetStrings.todayEmpty),
                  (yesterdaySuccessReqs != 0 || yesterdayFailReqs != 0)
                      ? _buildYesterdayRequestsWidget(
                          AppStrings.yesterdayRequests,
                          yesterdaySuccessReqs.toString(),
                          yesterdayFailReqs.toString())
                      : _buildEmptyWidget(
                          AppStrings.yesterdayRequests,
                          AppStrings.noRequestsYesterday,
                          AssetStrings.yesterday),
                  (monthSuccessReqs != 0 || monthFailReqs != 0)
                      ? _buildYesterdayRequestsWidget(AppStrings.thisMonth,
                          monthSuccessReqs.toString(), monthFailReqs.toString())
                      : Container()
                ],
              ),
            ),
    );
  }

  Widget _buildLoadingWidget() {
    return Column(
      children: [
        TitleHeader(child: _buildHeaderChild()),
        Expanded(child: Container()),
        SpinKitThreeBounce(
          color: AppColors.primary,
          size: 20,
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _buildHeaderChild() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEE d MMM').format(new DateTime.now()),
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                (now.hour >= 0 && now.hour < 12)
                    ? collector != null
                        ? AppStrings.goodMorning + " " + collector.name
                        : ""
                    : collector != null
                        ? AppStrings.goodEvening + " " + collector.name
                        : "",
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          FlatButton(
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            },
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.settings,
              color: AppColors.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTodaysRequestWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  AppStrings.todayRequests,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Divider(
                color: AppColors.borderColor,
              ),
              _todayRequestsRow(),
              Divider(
                color: AppColors.borderColor,
              ),
              _buildTodayRegionWidget(),
              regionRequests.length != 0 ? _buildMapButton() : Container()
            ],
          ),
        ),
      ),
    );
  }

  Widget _todayRequestsRow() {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTodayTotalItem(AppStrings.remaining, AppColors.accentYellow,
              todayPendingReqs.toString()),
          Container(
              height: 75,
              child: VerticalDivider(
                color: AppColors.borderColor,
              )),
          _buildTodayTotalItem(AppStrings.collected, AppColors.accentDark,
              todayCollectedReqs.toString()),
          Container(
              height: 75,
              child: VerticalDivider(
                color: AppColors.borderColor,
              )),
          _buildTodayTotalItem(AppStrings.failed, AppColors.redError,
              todayFailedReqs.toString()),
        ],
      ),
    );
  }

  Widget _buildTodayTotalItem(String text, Color color, String number) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black),
          ),
          SizedBox(width: 10),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayRegionWidget() {
    return regionRequests.length != 0
        ? Container(
            constraints: BoxConstraints(maxHeight: 110),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ListView.builder(
              itemCount: regionRequests.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _buildRegionItem(regionRequests[index].name,
                    regionRequests[index].total.toString());
              },
            ),
          )
        : Container();
  }

  Widget _buildRegionItem(String region, String number) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12.0),
      child: DottedBorder(
        padding: EdgeInsets.zero,
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: AppColors.innerBorder,
        radius: Radius.circular(12),
        child: Container(
          constraints: BoxConstraints(minWidth: 82),
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Text(
                region,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapButton() {
    return InkWell(
      onTap: () {
        ExtendedNavigator.of(context).push(Routes.navigationScreen);
      },
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Center(
          child: Text(
            AppStrings.requestMap,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildYesterdayRequestsWidget(
      String type, String success, String fail) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 25.0),
                child: Text(
                  type,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 10),
                    width: 118,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.greenSuccessLight,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          success,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(AppStrings.successDiliver,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    width: 118,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.redErrorLight,
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fail,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(AppStrings.failDeliver,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(String title, String body, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(image),
                ),
              ),
              Center(
                child: Text(
                  body,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
