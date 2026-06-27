import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_ftfl/routes/navigation_routes.dart';
import 'package:task_ftfl/style/colors.dart';
import 'package:task_ftfl/widgets/text_widget.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.shouldShowBackButton = true,
    this.bottom,
    this.isPrefixIcon,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
    this.prefixIcon,
    this.leadingColor,
    this.prefixIconName,
    this.titleWidget,
    this.titleColor,
    this.toolbarHeight,
    this.onTapPrefix,
    this.onPressBack,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.flexibleSpace,
    this.statusBarColor,
    this.prefixWidget,
    this.backgroundColor,
    this.onTapAction,
    this.isCenterTitle = true,
  });

  final String? title;
  final String? subtitle;
  final String? prefixIconName, prefixIcon;
  final bool? shouldShowBackButton;
  final PreferredSizeWidget? bottom;
  final bool? isPrefixIcon;
  final Color? leadingColor;
  final Widget? leading;
  final Widget? prefixWidget;
  final Widget? titleWidget;
  final Widget? flexibleSpace;
  final bool automaticallyImplyLeading;
  final GestureTapCallback? onTapPrefix;
  final GestureTapCallback? onPressBack;
  final Color? statusBarColor, backgroundColor, titleColor;
  final GestureTapCallback? onTapAction;
  final double? toolbarHeight;
  final bool isCenterTitle; // NEW
  final Brightness? statusBarIconBrightness;
  final Brightness? statusBarBrightness;

  double get _resolvedToolbarHeight {
    if (toolbarHeight != null) return toolbarHeight!;
    return subtitle != null ? 60.h : 50.h;
  }

  @override
  Widget build(final BuildContext context) => AppBar(
    flexibleSpace: flexibleSpace,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarDividerColor: AppColors.white,
      statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      statusBarBrightness: statusBarBrightness ?? Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: backgroundColor ?? AppColors.white,
    elevation: 0.0,
    automaticallyImplyLeading: automaticallyImplyLeading,
    centerTitle: isCenterTitle,
    title: Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child:
          titleWidget ??
          (subtitle != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  // left-align when not centered
                  crossAxisAlignment: isCenterTitle
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: title,
                      color: titleColor ?? AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                    TextWidget(
                      text: subtitle,
                      color: AppColors.textPrimary.withOpacity(0.45),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ],
                )
              : TextWidget(
                  text: title,
                  color: titleColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.sp,
                )),
    ),
    leading: shouldShowBackButton ?? true
        ? leading ??
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:
                    onPressBack ??
                    () {
                      if (Navigator.canPop(context)) {
                        navigate(navigationType: NavigationType.goBack);
                      }
                    },
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w, right: 8.w),
                  child: Icon(Icons.arrow_back, color: leadingColor ?? AppColors.textPrimary),
                ),
              )
        : null,
    leadingWidth: 50.w,
    actions: [
      prefixIconName != null
          ? Container(
              margin: EdgeInsets.only(right: 15.w),
              padding: const EdgeInsets.only(right: 5, left: 5, top: 25),
              child: TextWidget(text: prefixIconName, fontSize: 14.sp, onTap: onTapAction),
            )
          : prefixIcon != null
          ? GestureDetector(
              onTap: onTapAction,
              child: Container(
                margin: const EdgeInsets.only(right: 22),
                child: SvgPicture.asset(prefixIcon!),
              ),
            )
          : prefixWidget ?? const SizedBox.shrink(),
    ],
    bottom: bottom,
  );

  @override
  Size get preferredSize => Size.fromHeight(_resolvedToolbarHeight);
}
