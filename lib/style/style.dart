import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_ftfl/style/colors.dart';
import 'package:task_ftfl/style/string.dart';

class AppStyles {
  /* --- Text Style --- */
  static TextStyle text700 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: kDefaultFontName,
  );
  static TextStyle text600 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: kDefaultFontName,
  );
  static TextStyle text500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    fontFamily: kDefaultFontName,
  );
  static TextStyle text400 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: kDefaultFontName,
  );
  static TextStyle text300 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
    fontFamily: kDefaultFontName,
  );

  /* --- Padding and Margins --- */
  static EdgeInsets defaultPadding = EdgeInsets.all(16.w);
  static EdgeInsets smallPadding = EdgeInsets.all(8.w);
  static EdgeInsets largePadding = EdgeInsets.all(32.w);
  static EdgeInsets defaultSymmetricPadding = EdgeInsets.symmetric(
    vertical: 10.h,
    horizontal: 20.w,
  );
  static EdgeInsets defaultVerticalPadding = EdgeInsets.symmetric(vertical: 14.h);
  static EdgeInsets defaultHorizontalPadding = EdgeInsets.symmetric(horizontal: 14.w);

  /* --- Borders --- */
  static BorderRadius defaultBorderRadius = BorderRadius.all(Radius.circular(8.r));

  /* ---  Box Shadows --- */
  static BoxShadow defaultBoxShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 4.r,
    offset: const Offset(0, 2),
  );

  /* --- Sizes --- */
  static const double buttonHeight = 48.0;
  static const double cardElevation = 4.0;

  /* --- BoxDecoration Style --- */
  static BoxDecoration get baseCircleBorderDecor => BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.white,
    border: Border.all(color: AppColors.textPrimary.withOpacity(0.3)),
  );

  static BoxDecoration get baseBottomSheetDecor => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24.r),
      topRight: Radius.circular(24.r),
    ),
    boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2)),
    ],
  );

  static BoxDecoration get baseBorderDecor => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: AppColors.textPrimary.withOpacity(0.3)),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.3),
        offset: const Offset(0, 6),
        blurRadius: 8.0,
      ),
    ],
  );

  static BoxDecoration get baseOnlyBorderDecor => BoxDecoration(
    borderRadius: BorderRadius.circular(20.r),
    border: Border.all(color: AppColors.textPrimary.withOpacity(0.3)),
  );

  /* --- App Style --- */
  static ThemeData get appTheme => ThemeData.from(colorScheme: const ColorScheme.light()).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

extension ExtendedWidget on Widget {
  Center get toCenter => Center(child: this);

  Expanded get toExpanded => Expanded(child: this);

  Flexible get toFlexible => Flexible(child: this);
}
