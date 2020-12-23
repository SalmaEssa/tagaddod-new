import 'package:flutter/material.dart';
import 'package:tagaddod/resources/colors.dart';
import 'package:tagaddod/resources/strings.dart';

class MainHeader extends StatelessWidget {
  TextDirection td = AppStrings.currentCode == CodeStrings.arabicCode
      ? TextDirection.rtl
      : TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    //var w = MediaQuery.of(context).size.width;
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 30.0,
            ),
          ],
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
      child: Stack(
        children: [
          Positioned.directional(
            textDirection: td,
            top: 0,
            // bottom: 66.62 * w / 100,
            // start: 53.26 * w / 100,
            end: 0,
            child: Image.asset(
              AssetStrings.smallLeaf,
              height: 153,
              fit: BoxFit.cover,
              matchTextDirection: true,
            ),
          ),
          Positioned.directional(
            textDirection: td,
            top: 68,
            // bottom: 67,
            start: 16,
            // end: 272,
            child: Image.asset(
              AssetStrings.logo_white,
              // height: 77,
              width: 100,
              fit: BoxFit.cover,
              matchTextDirection: td == TextDirection.rtl ? false : true,
            ),
          ),
          Positioned.directional(
            textDirection: td,
            top: 140,
            // bottom: 55,
            start: 16,
            // end: 272,
            child: Image.asset(
              td == TextDirection.rtl
                  ? AssetStrings.slogan_ar
                  : AssetStrings.slogan_en,
              // height: 77,
              width: 200,
              fit: BoxFit.cover,
              matchTextDirection: td == TextDirection.rtl ? false : true,
            ),
          ),
          Positioned.directional(
            textDirection: td,
            top: 185,
            // bottom: 55,
            start: 16,
            // end: 272,
            child: Text(
              AppStrings.forPartners,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallHeader extends StatelessWidget {
  TextDirection td = TextDirection.rtl;

  @override
  Widget build(BuildContext context) {
    //var w = MediaQuery.of(context).size.width;
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 30.0,
            ),
          ],
          color: AppColors.primaryDark,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
      child: Stack(
        children: [
          Positioned.directional(
            textDirection: td,
            top: 0,
            // bottom: 66.62 * w / 100,
            // start: 53.26 * w / 100,
            end: 0,
            child: Image.asset(
              AssetStrings.smallLeaf,
              height: 100,
              fit: BoxFit.cover,
              matchTextDirection: true,
            ),
          ),
        ],
      ),
    );
  }
}
