import 'package:flutter/material.dart';
import 'package:tagaddod/ui/shared_widgets2/header.dart';
import 'package:tagaddod/ui/shared_widgets2/loading_button.dart';
import 'package:auto_route/auto_route.dart';

import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import '../../resources/colors.dart';
import '../../resources/strings.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tagaddod/main_route.dart';
import 'package:tagaddod/bloc/auth2/auth_bloc.dart';
import 'package:tagaddod/bloc/auth2/auth_event.dart';

import 'package:get_it/get_it.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _txtController = TextEditingController();
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool enabled = false;
  bool loading = false;
  String phoneNumber;
  AuthBloc authbloc = GetIt.instance<AuthBloc>();

  FormFieldValidator _invalNum(String input) {
    phoneNumber = _txtController.text.trim();
    convertToEnglishNum();
    input = phoneNumber;
    return (numm) {
      if (num.tryParse(input) == null && input.isNotEmpty)
        return AppStrings.invalidPhone;
      return null;
    };
  }

  void _submitForm() {
    FocusScope.of(context).unfocus();

    phoneNumber = _txtController.text.trim();
    if (phoneNumber.contains("٠")) convertToEnglishNum();
    if (_formKey.currentState.validate() == true) {
      print("beforee");
      authbloc.dispatch(SendOTP(phoneNumber));
      print("?????????????");

      ExtendedNavigator.of(context).push(Routes.codeVerifyScreen);
    }
  }

  void convertToEnglishNum() {
    String newString = "";
    for (int i = 0; i < phoneNumber.length; ++i) {
      if (phoneNumber[i] == '٠') newString += "0";

      if (phoneNumber[i] == '١') newString += "1";

      if (phoneNumber[i] == '٢') newString += "2";

      if (phoneNumber[i] == '٣') newString += "3";

      if (phoneNumber[i] == '٤') newString += "4";

      if (phoneNumber[i] == '٥') newString += "5";

      if (phoneNumber[i] == '٦') newString += "6";

      if (phoneNumber[i] == '٧') newString += "7";

      if (phoneNumber[i] == '٨') newString += "8";

      if (phoneNumber[i] == '٩') newString += "9";
    }
    phoneNumber = newString;
  }

  @override
  void initState() {
    // TODO: implement initState
    _txtController.addListener(() {
      if (_txtController.text.isNotEmpty)
        setState(() {
          enabled = true;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _txtController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
              MainHeader(),
              Container(
                margin:
                    EdgeInsetsDirectional.only(top: 26, bottom: 18, start: 16),
                child: Text(
                  AppStrings.phoneNumber,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 16, end: 16),
                child: FormBuilder(
                    key: _formKey,
                    child: FormBuilderTextField(
                      onFieldSubmitted: (_) => _submitForm(),
                      attribute: "Phone Number",
                      controller: _txtController,
                      //  keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.lightGrayBackground,
                        hintText: AppStrings.enterPhoneNumber,
                        hintStyle:
                            TextStyle(color: AppColors.lightText, fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: AppColors.borderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                BorderSide(color: AppColors.primary, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                color: AppColors.redError, width: 2)),
                        alignLabelWithHint: true,
                      ),

                      textDirection: TextDirection.ltr,
                      validators: [
                        _invalNum(_txtController.text.trim()),
                        FormBuilderValidators.minLength(11,
                            errorText: AppStrings.invalidPhone),
                        FormBuilderValidators.maxLength(11,
                            errorText: AppStrings.invalidPhone)
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 33),
                child: LoadingButton(
                  enabled: enabled,
                  loading: loading,
                  child: AppStrings.sendOTP,
                  fun: _submitForm,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
