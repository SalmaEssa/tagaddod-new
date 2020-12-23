import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/location/location_bloc.dart';
import 'package:tagaddod/bloc/location/location_event.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

import '../../main_route.dart';

class RatingDialog extends StatefulWidget {
  Request request;
  RatingDialog({this.request});
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription sub;
  int userrating = 0;
  LocationBloc _locationBloc = GetIt.instance<LocationBloc>();
  @override
  void initState() {
    // TODO: implement initState
    sub = _requestBloc.requestStateSubject.listen((state) {
      if (state is RatingIsAdded) {
        _locationBloc.dispatch(CancelSub());
        ExtendedNavigator.of(context).push(Routes.navigationScreen);
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _requestBloc.dispatch(
                        RatingAdded(widget.request.id, 1, CodeStrings.skipped));
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                )
              ],
            ),
          ),
          Center(
              child: Text(
            AppStrings.pleaseRate + " " + widget.request.customer.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 50),
            child: Center(
              child: RatingBar(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                  setState(() {
                    userrating = rating.round();
                  });
                },
              ),
            ),
          ),
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (userrating != 0) {
                _requestBloc.dispatch(RatingAdded(
                    widget.request.id, userrating, CodeStrings.rated));
              }
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                  color: userrating == 0
                      ? AppColors.primaryFaded
                      : AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
              child: Center(
                child: Text(
                  AppStrings.sendRating,
                  style: TextStyle(
                      color:
                          userrating == 0 ? AppColors.black : AppColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
