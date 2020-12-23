import 'package:flutter/material.dart';
import 'package:tagaddod/ui/shared_widgets2/header.dart';
import 'package:tagaddod/ui/shared_widgets2/loading_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tagaddod/main_route.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/services.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/auth2/auth_state.dart';
import 'package:tagaddod/bloc/auth2/auth_event.dart';

class CodeVerifyScreen extends StatefulWidget {
  @override
  _CodeVerifyScreenState createState() => _CodeVerifyScreenState();
}

class _CodeVerifyScreenState extends State<CodeVerifyScreen> {
  TextDirection td = AppStrings.currentCode == CodeStrings.arabicCode
      ? TextDirection.rtl
      : TextDirection.ltr;
  bool abled = false;
  bool loading = false;
  String code;
  bool visible = false;
  bool succsess = true;
  bool resendCode = false;
  Duration resendCodeDuration;
  Timer resendTimer;
  Timer logInError;
  String title;
  String errorMsg;
  StreamSubscription authsSub;
  AuthBloc authbloc = GetIt.instance<AuthBloc>();
  String phoneNumber;
  void logInErrorFun(String msg, String t) {
    print("LogIn error Fun");
    setState(() {
      visible = true;
      succsess = false;
      errorMsg = msg;
      title = t;
      loading = false;
    });
    if (logInError != null) // to ensure it will begin again
    {
      logInError.cancel();
      logInError = null;
    } // as  asign to know if it continue now

    logInError = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        visible = false;
        logInError.cancel();
        logInError = null;
      });
    });
  }

  void resendCodeFun(AuthState state) {
    print("reseent");
    setState(() {
      errorMsg = AppStrings.verificationCodeResentSuccess;
      title = AppStrings.success;
      visible = true;
      succsess = true;
    });
    if (logInError != null) // to ensure it will begin again
      logInError.cancel();
    logInError = null; // as  asign to know if it continue now

    logInError = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        visible = false;
        logInError.cancel();
        logInError = null;
      });
    });
  }

  void _submitcode() {
    setState(() {
      loading = true;
    });
    authbloc.dispatch(VerifyCode(code));
  }

//// el moraba3 ele beyegy tgen it disapeear after wail after resending the code
  Widget toast() {
    if (title == null) {
      setState(() {
        title = succsess ? AppStrings.success : AppStrings.fail;
      });
    }
    return Container(
      width: 600,
      height: 70,
      padding: EdgeInsetsDirectional.only(start: 10, end: 10),
      child: Card(
        color: succsess ? AppColors.greenSuccessLight : AppColors.redErrorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  color: succsess ? AppColors.greenSuccess : AppColors.redError,
                ),
                _buildCircularSign(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title != null
                          ? title
                          : succsess
                              ? AppStrings.success
                              : AppStrings.fail,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      errorMsg,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0, top: 13),
              child: InkWell(
                child: Icon(
                  Icons.close,
                  color: succsess ? AppColors.greenSuccess : AppColors.redError,
                ),
                onTap: () {
                  setState(() {
                    visible = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularSign() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: succsess ? AppColors.greenSuccess : AppColors.redError,
      ),
      child: succsess
          ? Icon(Icons.check, color: AppColors.white, size: 12)
          : Icon(Icons.close, color: AppColors.white, size: 12),
    );
  }

  void inilizeTimer() {
    resendCodeDuration = Duration(seconds: 30);

    resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (resendCodeDuration.inSeconds <= 0) {
        resendTimer.cancel();
        resendTimer = null;
        setState(() {
          resendCode = true;
        });
      }
      setState(() {
        resendCodeDuration =
            Duration(seconds: resendCodeDuration.inSeconds - 1);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    inilizeTimer();
    authsSub = authbloc.authStateSubject.listen((AuthState state) {
      if (state is LogInError) logInErrorFun(state.msg, state.title);
      if (state is PhoneNumberis) {
        print("phone number is ");
        setState(() {
          phoneNumber = state.phone;
          print(phoneNumber);
        });
      }
      if (state is OTPResend) resendCodeFun(state);
      if (state is LogedIn) {
        if (state.user != null) {
          ExtendedNavigator.of(context)
              .pushAndRemoveUntil(Routes.homeScreen, (_) => false);
        }
      }

      // print("no phonee foumd");
    });
    authbloc.dispatch(GetthePhone());

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    authsSub.cancel();
    if (resendTimer != null) {
      resendTimer.cancel();
      resendTimer = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            AssetStrings.leaf,
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                SmallHeader(),
                Positioned.directional(
                  textDirection: td,
                  top: 58,
                  child: Row(
                    children: [
                      BackButton(
                        color: AppColors.white,
                        // onPressed:  ExtendedNavigator.of(context).push(Routes.);,
                      ),
                      Text(
                        AppStrings.verifyPhone,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppColors.white),
                      ),
                    ],
                  ),
                )
              ]),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  AppStrings.writeVerifyCode,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  phoneNumber == null ? "" : phoneNumber,
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      activeColor: AppColors.lightGrayBackground,
                      inactiveColor: AppColors.lightGrayBackground,
                      inactiveFillColor: AppColors.lightGrayBackground,
                      selectedColor: AppColors.lightGrayBackground,
                      selectedFillColor: AppColors.lightGrayBackground,
                      activeFillColor: AppColors.lightGrayBackground,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 53,
                      fieldWidth: 48,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    keyboardType: TextInputType.number,
                    enableActiveFill: true,
                    onChanged: (value) {
                      if (value.length == 6 && !abled) {
                        setState(() {
                          abled = true;
                        });
                      }
                      if (value.length != 6 && abled) {
                        setState(() {
                          abled = false;
                        });
                      }
                      code = value;
                    },
                    appContext: context,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 30),
                child: LoadingButton(
                  enabled: abled,
                  loading: loading,
                  child: AppStrings.verifyPhone,
                  fun: _submitcode,
                ),
              ),
              SizedBox(
                height: 27,
              ),
              if (resendCode == true)
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      AppStrings.resendCode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.primaryDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    onPressed: () {
                      authbloc.dispatch(ReSendOTP());

                      inilizeTimer();
                      setState(() {
                        loading = false;

                        resendCode = false;
                      });
                      //resetTimer();
                    },
                  ),
                ),
              if (resendCode == false)
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppStrings.resendCodeIn,
                          style: TextStyle(
                            color: AppColors.darkText,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "00:${resendCodeDuration.inSeconds.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
              if (visible)
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    toast()
                  ],
                )
            ],
          ),
        ),
      ]),
    );
  }
}
