import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/location/location_bloc.dart';
import 'package:tagaddod/bloc/location/location_event.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/main_route.dart';
import 'package:tagaddod/podo/complainType.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/shared_widgets/common_headers.dart';

class SubmitIssueScreen extends StatefulWidget {
  @override
  _SubmitIssueScreenState createState() => _SubmitIssueScreenState();
}

class _SubmitIssueScreenState extends State<SubmitIssueScreen> {
  bool loading = true;
  bool enabled = false;
  List<ComplainType> complains = [];
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription sub;
  String selectedComplain = "";
  ComplainType currentComplain;
  TextEditingController controller = TextEditingController();
  LocationBloc _locationBloc = GetIt.instance<LocationBloc>();

  @override
  void initState() {
    sub = _requestBloc.requestStateSubject.listen((state) {
      if (state is AllComplainsAre) {
        setState(() {
          complains = state.complains;
          loading = false;
        });
      }
      if (state is ComplainAddedIS) {
        _locationBloc.dispatch(CancelSub());
        ExtendedNavigator.of(context).push(Routes.navigationScreen);
      }
    });
    _requestBloc.dispatch(GetAllComplains());
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? _buildLoadingWidget()
          : SingleChildScrollView(
              child: Column(
                children: [
                  TitleHeader(child: _buildHeaderChild()),
                  _buildIssuesList(),
                  _buildButton(),
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
        Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: Text(
              AppStrings.downloading,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget _buildHeaderChild() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10.0),
      child: Row(
        children: [
          BackButton(color: AppColors.white),
          Text(
            AppStrings.reportProblem,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 10),
      child: FlatButton(
        onPressed: () {
          if (enabled) {
            _requestBloc
                .dispatch(ComplainAdded(currentComplain.id, controller.text));
          }
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: enabled ? AppColors.redError : AppColors.redErrorLight),
          child: Center(
            child: Text(
              AppStrings.sendIssue,
              style: TextStyle(
                color: enabled ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIssuesList() {
    return Column(
      children: [
        _buildSingleComplain(complains[1]),
        _buildSingleComplain(complains[2]),
        _buildSingleComplain(complains[3]),
        _buildSingleComplain(complains[4]),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  selectedComplain = complains[0].name;
                  currentComplain = complains[0];
                  enabled = false;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      complains[0].name,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkText),
                    ),
                    selectedComplain == complains[0].name
                        ? Icon(
                            Icons.check,
                            color: AppColors.accent,
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            selectedComplain == complains[0].name
                ? _buildTextField()
                : Container(),
            Divider(color: AppColors.textFieldBorderColor),
          ],
        )
      ],
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: FormBuilder(
        child: FormBuilderTextField(
          textDirection: TextDirection.rtl,
          controller: controller,
          maxLines: 4,
          validators: [],
          keyboardType: TextInputType.text,
          onChanged: (value) {
            if (value != "") {
              setState(() {
                enabled = true;
              });
            }
            if (value == "") {
              setState(() {
                enabled = false;
              });
            }
          },
          decoration: InputDecoration(
            filled: true,
            hintText: AppStrings.describeYourIssue,
            fillColor: AppColors.lightGrayBackground,
            hintStyle: TextStyle(color: AppColors.lightText, fontSize: 13),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: AppColors.textFieldBorderColor)),
          ),
          attribute: "issue",
        ),
      ),
    );
  }

  Widget _buildSingleComplain(ComplainType complain) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedComplain = complain.name;
              currentComplain = complain;
              enabled = true;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complain.name,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkText),
                ),
                selectedComplain == complain.name
                    ? Icon(
                        Icons.check,
                        color: AppColors.accent,
                      )
                    : Container()
              ],
            ),
          ),
        ),
        Divider(color: AppColors.textFieldBorderColor),
      ],
    );
  }
}
