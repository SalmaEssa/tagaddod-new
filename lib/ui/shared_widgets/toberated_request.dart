import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/shared_widgets/loading_button.dart';

class ToBeRatedRequest extends StatefulWidget {
  Request request;
  ToBeRatedRequest({this.request});
  @override
  _ToBeRatedRequestState createState() => _ToBeRatedRequestState();
}

class _ToBeRatedRequestState extends State<ToBeRatedRequest> {
  bool buttonLoading = false;
  bool buttonEnabled = false;
  int userrating = 0;
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();

  @override
  Widget build(BuildContext context) {
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
                  DateFormat('d MMMM y , h:mm a')
                      .format(widget.request.created_at),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightText),
                ),
                getStatus(widget.request.status),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.request.customer.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                widget.request.rated_by_collector
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
                        widget.request.collected_quantity.toString() +
                            " " +
                            AppStrings.litres,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.request.gift.name,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        widget.request.address.description,
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
          widget.request.rated_by_collector ||
                  widget.request.status != "COLLECTED"
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
                            _requestBloc.dispatch(
                                RatingAdded(widget.request.id, userrating, "RATED"));
                          }
                          setState(() {
                            buttonLoading = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
          widget.request.status == "REPORTED"
              ? Divider(
                  color: AppColors.textFieldBorderColor,
                )
              : Container(),
          widget.request.status == "REPORTED"
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
                            widget.request.complain.description,
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
      case "COLLECTED":
        return Text(
          AppStrings.requestCollected,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.accent),
        );
        break;
      case "FAILED":
        return Text(
          AppStrings.requestFailed,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.redError),
        );
        break;
      case "REPORTED":
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
}
