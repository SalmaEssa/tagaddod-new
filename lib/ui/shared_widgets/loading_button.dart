import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../resources/colors.dart';

class LoadingButton extends StatefulWidget {
  String child;
  Function onPressed;
  bool loading;
  bool enabled;

  LoadingButton({this.child, this.onPressed, this.loading, this.enabled});

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
          color: widget.enabled
                ? AppColors.primary
                : AppColors.primaryFaded,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        child: InkWell(
          onTap: widget.enabled && !widget.loading? widget.onPressed : null,
          child: widget.loading ? _loader() : _child(),
        ),
      ),
    );
  }

  Widget _child() {
    return Center(
      child: Text(
        widget.child,
        style: TextStyle(
          color: widget.enabled ? AppColors.white : AppColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _loader() {
    return SpinKitThreeBounce(
      color: AppColors.white,
      size: 20,
    );
  }
}
