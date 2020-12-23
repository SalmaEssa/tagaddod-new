import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/shared_widgets/common_headers.dart';
import 'package:tagaddod/ui/shared_widgets/loading_button.dart';
import 'package:tagaddod/ui/shared_widgets/response_toast.dart';
import 'package:tagaddod/ui/shared_widgets/toberated_request.dart';

class PastRequestsScreen extends StatefulWidget {
  @override
  _PastRequestsScreenState createState() => _PastRequestsScreenState();
}

class _PastRequestsScreenState extends State<PastRequestsScreen> {
  List<Request> pastRequests = [];
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription sub;
  bool loading = true;
  bool buttonLoading = false;
  bool buttonEnabled = false;
  int userrating = 0;
  bool visible = false;
  Timer errorTimer;
  @override
  void initState() {
    // TODO: implement initState
    sub = _requestBloc.requestStateSubject.listen((state) {
      if (state is PastRequestsAre) {
        setState(() {
          pastRequests = state.pastRequests;
          loading = false;
        });
      }
      if (state is RatingIsAdded) {
        setState(() {
          visible = true;
        });
        errorTimer = Timer.periodic(Duration(seconds: 5), (timer) {
          setState(() {
            visible = false;
            errorTimer.cancel();
            errorTimer = null;
          });
        });
        _requestBloc.dispatch(GetAllPastRequests());
      }
    });
    _requestBloc.dispatch(GetAllPastRequests());
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
    return Scaffold(
      body: loading
          ? _buildLoadingWidget()
          : pastRequests.isEmpty
              ? _buildEmptyRequests()
              : Column(
                  children: [
                    TitleHeader(child: _buildHeaderChild()),
                    Expanded(child: _buildRequestsList()),
                    visible
                        ? Container(
                            padding: EdgeInsets.all(16),
                            child: _buildToast(),
                          )
                        : Container()
                  ],
                ),
    );
  }

  Widget _buildHeaderChild() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 10.0),
      child: Row(
        children: [
          BackButton(color: AppColors.white),
          Text(
            AppStrings.requestHistory,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.white),
          )
        ],
      ),
    );
  }

  Widget _buildEmptyRequests() {
    return Column(
      children: [
        TitleHeader(child: _buildHeaderChild()),
        Expanded(child: Container()),
        Image.asset(AssetStrings.emptyPastRequests),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            AppStrings.noPastRequests,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(child: Container()),
      ],
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

  Widget _buildRequestsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemCount: pastRequests.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          if (pastRequests[index].status != CodeStrings.rCollected ||
              pastRequests[index].rated_by_collector) {
            return _buildSingleRequest(pastRequests[index]);
          }
          return ToBeRatedRequest(request: pastRequests[index]);
        },
      ),
    );
  }

  Widget _buildSingleRequest(Request request) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('d MMMM y , h:mm a').format(request.created_at),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightText),
                ),
                getStatus(request.status),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.customer.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                request.rated_by_collector
                    ? RatingBar(
                        initialRating: 3,
                        minRating: 1,
                        itemSize: 20,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Divider(
            color: AppColors.textFieldBorderColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.quantity,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightText),
                    ),
                    Text(
                      AppStrings.gift,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightText),
                    ),
                    Text(
                      AppStrings.address,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightText),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.collected_quantity.toString() +
                            " " +
                            AppStrings.litres,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        request.gift.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        request.address.description,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          request.rated_by_collector || request.status != CodeStrings.rCollected
              ? Container()
              : Column(
                  children: [
                    Divider(
                      color: AppColors.textFieldBorderColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: RatingBar(
                        initialRating: 0,
                        minRating: 1,
                        itemSize: 40,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (value) {
                          print(value);
                          setState(() {
                            userrating = value.round();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: LoadingButton(
                        child: AppStrings.sendRating,
                        enabled: userrating >= 1,
                        loading: buttonLoading,
                        onPressed: () {
                          if (userrating != 0) {
                            _requestBloc.dispatch(RatingAdded(
                                request.id, userrating, CodeStrings.rated));
                          }
                          setState(() {
                            buttonLoading = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
          request.status == CodeStrings.rReported
              ? Divider(
                  color: AppColors.textFieldBorderColor,
                )
              : Container(),
          request.status == CodeStrings.rReported
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.problem,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.lightText),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            request.complain.description,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkText),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget getStatus(String status) {
    switch (status) {
      case CodeStrings.rCollected:
        return Text(
          AppStrings.requestCollected,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.accent),
        );
        break;
      case CodeStrings.rFailed:
        return Text(
          AppStrings.requestFailed,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.redError),
        );
        break;
      case CodeStrings.rReported:
        return Text(
          AppStrings.requestReported,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.accent),
        );
        break;
      default:
    }
  }

  Widget _buildToast() {
    return Container(
      width: double.infinity,
      height: 70,
      child: Card(
        color: AppColors.greenSuccessLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  color: AppColors.greenSuccess,
                ),
                _buildCircularSign(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.success,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      AppStrings.ratingSent,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0, top: 13),
              child: InkWell(
                //padding: EdgeInsets.zero,
                onTap: () {
                  setState(() {
                    visible = false;
                  });
                },
                child: Icon(
                  Icons.close,
                  color: AppColors.greenSuccess,
                ),
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
          color: AppColors.greenSuccess,
        ),
        child: Icon(Icons.check, color: AppColors.white, size: 12));
  }
}
