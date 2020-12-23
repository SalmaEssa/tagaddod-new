import 'package:auto_route/auto_route.dart';
import 'package:tagaddod/ui/auth2/log_in_screen.dart';
import 'package:tagaddod/ui/home/home_screen.dart';

import 'package:tagaddod/ui/auth2/code_verify_screen.dart';
import 'package:flutter/material.dart';
import 'ui/splash_screen.dart';
import 'ui/request/navigation_screen.dart';
import 'ui/request/past_requests_screen.dart';
import 'ui/request/submit_issue_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String homeScreen = '/HomeScreen';
  static const String loginScreen = '/login-screen';
  static const String codeVerifyScreen = '/code-verification-screen';
  static const String navigationScreen = '/navigation-screen';
  static const String pastRequestsScreen = '/past-requests-screen';
  static const String submitIssueScreen = '/submit-issue-screen';
}

class MainRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes; ////this is a getter return routes list
  final _routes = <RouteDef>[
    //RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.navigationScreen, page: NavigationScreen),
    RouteDef(Routes.pastRequestsScreen, page: PastRequestsScreen),
    RouteDef(Routes.submitIssueScreen, page: SubmitIssueScreen),
    RouteDef(Routes.codeVerifyScreen, page: CodeVerifyScreen),
    RouteDef(Routes.loginScreen, page: LogInScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    CodeVerifyScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CodeVerifyScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(),
        settings: data,
      );
    },
    LogInScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LogInScreen(),
        settings: data,
      );
    },
    PastRequestsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => PastRequestsScreen(),
        settings: data,
      );
    },
    NavigationScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => NavigationScreen(),
        settings: data,
      );
    },
    SubmitIssueScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => SubmitIssueScreen(),
        settings: data,
      );
    },
  };
}
