import 'package:flutter/material.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

class BigHeader extends StatelessWidget {
  final TextDirection td = AppStrings.currentCode == CodeStrings.arabicCode
      ? TextDirection.rtl
      : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius:
            BorderRadiusDirectional.only(bottomEnd: Radius.circular(50)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.directional(
            top: 0,
            end: 0,
            textDirection: td,
            child: Image.asset(
              AssetStrings.smallLeaf,
              height: 153,
              fit: BoxFit.cover,
              matchTextDirection: true,
            ),
          ),
          Positioned.directional(
            textDirection: td,
            top: 70,
            start: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AssetStrings.logo_white,
                  width: 100,
                ),
                SizedBox(
                  height: 16,
                ),
                Image.asset(
                  td == TextDirection.rtl
                      ? AssetStrings.slogan_ar
                      : AssetStrings.slogan_en,
                  width: 200,
                ),
                Text(
                  AppStrings.forPartners,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TitleHeader extends StatelessWidget {
  final Widget child;
  final TextDirection td = AppStrings.currentCode == CodeStrings.arabicCode
      ? TextDirection.rtl
      : TextDirection.ltr;

  TitleHeader({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 130),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius:
            BorderRadiusDirectional.only(bottomEnd: Radius.circular(50)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.directional(
            top: 0,
            end: 0,
            textDirection: td,
            child: Image.asset(
              AssetStrings.smallLeaf,
              fit: BoxFit.cover,
              height: 100,
              matchTextDirection: true,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
              ),
              child
            ],
          )
        ],
      ),
    );
  }
}
