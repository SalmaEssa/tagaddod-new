import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

class DoneDialog extends StatefulWidget {
  @override
  _DoneDialogState createState() => _DoneDialogState();
}

class _DoneDialogState extends State<DoneDialog> {
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
                    ExtendedNavigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Center(child: Image.asset(AssetStrings.success)),
          ),
          Padding(
              padding: EdgeInsetsDirectional.only(top: 28, bottom: 5),
              child: Center(
                  child: Text(
                AppStrings.thanks,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ))),
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 30, start: 20, end: 20),
            child: Center(
              child: Text(
                AppStrings.youFinishedAllRequests,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
