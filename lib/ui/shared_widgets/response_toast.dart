import 'dart:async';

import 'package:flutter/material.dart';

import '../../resources/colors.dart';
import '../../resources/strings.dart';

class ResponseToast extends StatefulWidget {
  bool success;
  String title;
  String message;
  bool visible;

  ResponseToast({this.success, this.title, this.message, this.visible});

  @override
  _ResponseToastState createState() => _ResponseToastState();
}

class _ResponseToastState extends State<ResponseToast> {
  bool shown;

  @override
  void initState() {
    setShown();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ResponseToast oldWidget) {
    setState(() {
      setShown();
    });
    super.didUpdateWidget(oldWidget);
  }

  setShown() {
    shown = widget.visible;
  }

  @override
  Widget build(BuildContext context) {
    return shown
        ? Container(
            width: double.infinity,
            height: 70,
            child: Card(
              color: widget.success
                  ? AppColors.greenSuccessLight
                  : AppColors.redErrorLight,
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
                        color: widget.success
                            ? AppColors.greenSuccess
                            : AppColors.redError,
                      ),
                      _buildCircularSign(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title!=null?widget.title:widget.success
                                ? AppStrings.success
                                : AppStrings.fail,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            widget.message,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end:10.0,top:13),
                    child: InkWell(
                      //padding: EdgeInsets.zero,
                      onTap: () {
                        setState(() {
                          shown = false;
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: widget.success
                            ? AppColors.greenSuccess
                            : AppColors.redError,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildCircularSign() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.success ? AppColors.greenSuccess : AppColors.redError,
      ),
      child: widget.success
          ? Icon(Icons.check, color: AppColors.white, size: 12)
          : Icon(Icons.close, color: AppColors.white, size: 12),
    );
  }
}
