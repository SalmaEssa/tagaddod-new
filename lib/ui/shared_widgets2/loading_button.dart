import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../resources/colors.dart';

class LoadingButton extends StatefulWidget {
  String child;
  Function fun;
  bool loading;
  bool enabled;

  LoadingButton({this.child, this.fun, this.loading, this.enabled});

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: Card(
        color: widget.enabled ? AppColors.primary : AppColors.primaryFaded,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: InkWell(
          child: widget.loading
              ? SpinKitThreeBounce(
                  color: AppColors.white,
                  size: 20,
                )
              : Center(
                  child: Text(
                    widget.child,
                    style: TextStyle(
                      color: widget.enabled ? AppColors.white : AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
          onTap: widget.enabled && !widget.loading ? widget.fun : null,
        ),
      ),
    );
  }
}
