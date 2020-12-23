import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

class SelectGiftDialog extends StatefulWidget {
  final Request request;
  final int quantity;
  SelectGiftDialog({this.request, this.quantity});
  @override
  _SelectGiftDialogState createState() => _SelectGiftDialogState();
}

class _SelectGiftDialogState extends State<SelectGiftDialog> {
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription sub;
  bool loading = true;
  List<Gift> gifts = [];
  Gift selectedGift;
  @override
  void initState() {
    // TODO: implement initState
    selectedGift = widget.request.gift;
    sub = _requestBloc.requestStateSubject.listen((state) {
      if (state is AvailableGiftsAre) {
        setState(() {
          gifts = state.gifts;
          loading = false;
        });
      }
      if (state is SelectedGiftIs) {
        if (state.selectedGift != null) {
          setState(() {
            selectedGift = state.selectedGift;
          });
        }
      }
    });
    _requestBloc.dispatch(GetAvailableGifts(widget.quantity));
    _requestBloc.dispatch(GetSelectedGift());
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
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    ExtendedNavigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 15),
                  child: Text(AppStrings.selectGift),
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.textFieldBorderColor,
          ),
          loading
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.white,
                        ),
                      ),
                      Center(
                        child: Text(
                          AppStrings.downloadingGifts,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              : _buildGiftsList(),
        ],
      ),
    );
  }

  Widget _buildGiftsList() {
    return ListView.builder(
      itemCount: gifts.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return buildSingleGift(gifts[index], index);
      },
    );
  }

  Widget buildSingleGift(Gift gift, int index) {
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            setState(() {
              selectedGift = gift;
            });
            _requestBloc.dispatch(GiftSelected(gift));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gift.name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              gift.name == selectedGift.name
                  ? Icon(
                      Icons.check,
                      color: AppColors.primaryDark,
                    )
                  : Container()
            ],
          ),
        ),
        index != gifts.length - 1
            ? Divider(
                color: AppColors.textFieldBorderColor,
              )
            : Container(),
      ],
    );
  }
}
