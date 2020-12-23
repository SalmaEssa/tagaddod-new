import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tagaddod/main_route.dart';
import 'package:tagaddod/podo/request.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';
import 'package:tagaddod/ui/request/confirm_dialoug.dart';
import 'package:url_launcher/url_launcher.dart';

class SlidingPanel extends StatefulWidget {
  final Request request;
  SlidingPanel({this.request});
  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      parallaxEnabled: true,
      minHeight: 180,
      maxHeight: 400,
      panelBuilder: (sc) =>
          ListView(controller: sc, children: [scrollList(sc)]),
    );
  }

  Widget scrollList(ScrollController sc) {
    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17.0),
              child: Center(child: Image.asset(AssetStrings.rect)),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.request.customer.name,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        widget.request.address.description,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                _launchURL(CodeStrings.googleNavigation +
                                    "${widget.request.address.latitude},${widget.request.address.longitude}");
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsetsDirectional.only(end: 9),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blueNavigation),
                                child: Icon(
                                  Icons.near_me,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL(CodeStrings.googleNavigation +
                                    "${widget.request.address.latitude},${widget.request.address.longitude}");
                              },
                              child: Text(
                                AppStrings.directions,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.blueNavigation),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL(
                                    "tel:${widget.request.customer.phone}");
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                margin: EdgeInsetsDirectional.only(
                                    end: 9, start: 70),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.accent),
                                child: Icon(
                                  Icons.phone,
                                  color: AppColors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _launchURL(
                                    "tel:${widget.request.customer.phone}");
                              },
                              child: Text(
                                AppStrings.call,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.accent),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.textFieldBorderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 120.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.quantity,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    widget.request.collected_quantity
                                            .toString() +
                                        " " +
                                        AppStrings.litres,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.gift,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  widget.request.gift.name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: AppColors.textFieldBorderColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.notes,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              widget.request.notes ?? "",
                              // maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (BuildContext ctx) => ConfirmDialog(
                                    request: widget.request,
                                  ));
                        },
                        child: Container(
                          margin: EdgeInsetsDirectional.only(end: 4),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: AppColors.accentDark,
                          child: Center(
                            child: Text(
                              AppStrings.recieve,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ExtendedNavigator.of(context)
                              .push(Routes.submitIssueScreen);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: AppColors.redError,
                          child: Center(
                            child: Text(
                              AppStrings.reportProblem,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
