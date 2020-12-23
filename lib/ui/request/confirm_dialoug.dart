import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tagaddod/bloc/request/bloc.dart';
import 'package:tagaddod/podo/gift.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/request/rating_dialog.dart';
import 'package:tagaddod/ui/request/select_gift_dialog.dart';

class ConfirmDialog extends StatefulWidget {
  Request request;
  ConfirmDialog({this.request});
  @override
  _ConfirmDialogState createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  int quantity;
  bool wrongGift = false;
  RequestBloc _requestBloc = GetIt.instance<RequestBloc>();
  StreamSubscription sub;
  Gift selectedGift;
  List<Gift> availableGifts = [];

  @override
  void initState() {
    // TODO: implement initState
    selectedGift = widget.request.gift;
    sub = _requestBloc.requestStateSubject.listen((state) {
      if (state is SelectedGiftIs) {
        if (state.selectedGift != null) {
          setState(() {
            selectedGift = state.selectedGift;
            wrongGift = false;
          });
        }
      }
      if (state is AvailableGiftsAre) {
        setState(() {
          availableGifts = state.gifts;
          List<String> giftIDs = [];
          for (var gift in availableGifts) {
            giftIDs.add(gift.id);
          }
          if (!giftIDs.contains(selectedGift.id)) {
            setState(() {
              wrongGift = true;
            });
          }
        });
      }
      if (state is CollectionIsConfirmed) {
        ExtendedNavigator.of(context).pop();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext ctx) => RatingDialog(
                  request: widget.request,
                ));
      }
    });
    quantity = widget.request.collected_quantity;
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.recieve,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  child: Icon(
                    Icons.close,
                    color: AppColors.black,
                  ),
                  onTap: () {
                    ExtendedNavigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Divider(
            color: AppColors.textFieldBorderColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: Text(
              AppStrings.collectedAmount,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
            child: _buildQuantityCounter(),
          ),
          Divider(
            color: AppColors.textFieldBorderColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Text(
              AppStrings.gift,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
                start: 16, end: 16, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedGift.name,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          decoration: wrongGift
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (BuildContext ctx) => SelectGiftDialog(
                                  request: widget.request,
                                  quantity: quantity,
                                ));
                      },
                      child: Text(
                        AppStrings.change,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark),
                      ),
                    )
                  ],
                ),
                wrongGift
                    ? Text(
                        AppStrings.selectAnotherGift,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.redError),
                      )
                    : Container(),
              ],
            ),
          ),
          FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (!wrongGift) {
                _requestBloc.dispatch(CollectionConfirmed(
                    widget.request.id, quantity, selectedGift.id));
              }
            },
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                  color:
                      wrongGift ? AppColors.accentLight : AppColors.accentDark,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
              child: Center(
                child: Text(
                  AppStrings.confirmCollect,
                  style: TextStyle(
                      color: wrongGift ? AppColors.black : AppColors.white,
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

  Widget _buildQuantityCounter() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              quantity += 1;
              wrongGift = false;
            });
            _requestBloc.dispatch(GetAvailableGifts(quantity));
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(5),
                  bottomStart: Radius.circular(5)),
              color: AppColors.primaryDark,
            ),
            child: Center(
              child: Icon(
                Icons.add,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 55,
            color: AppColors.textFieldBorderColor,
            child: Center(
              child: Text(
                quantity.toString() + " " + AppStrings.litres,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (quantity > 5) {
              setState(() {
                quantity -= 1;
                wrongGift = false;
              });
              _requestBloc.dispatch(GetAvailableGifts(quantity));
            }
          },
          child: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(5), bottomEnd: Radius.circular(5)),
              color: AppColors.accentYellow,
            ),
            child: Center(
              child: Icon(
                Icons.remove,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
