import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_ftfl/style/colors.dart';
import 'package:task_ftfl/ui/home/home_screen.dart';
import 'package:task_ftfl/widgets/text_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.selectedIndex});

  final int? selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  AnimationController? animationController;

  final List<Widget> _widgetOptions = const [
    HomeScreen(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  static const List<_TabItem> _tabs = [
    _TabItem(icon: Icons.home_outlined, filledIcon: Icons.home, label: 'Home'),
    _TabItem(icon: Icons.play_circle_outline, filledIcon: Icons.play_circle, label: 'Date Now'),
    _TabItem(icon: Icons.favorite_outline, filledIcon: Icons.favorite, label: 'Admirers'),
    _TabItem(icon: Icons.chat_bubble_outline, filledIcon: Icons.chat_bubble, label: 'Chat'),
    _TabItem(
      icon: Icons.calendar_today_outlined,
      filledIcon: Icons.calendar_today,
      label: 'Events',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
    animationController = BottomSheet.createAnimationController(this);
    animationController?.duration = const Duration(milliseconds: 500);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    body: _widgetOptions[_selectedIndex],
    bottomNavigationBar: _createBottomNavigationBar(),
  );

  Widget _createBottomNavigationBar() => Container(
    height: Platform.isIOS ? 90.h : 70.h,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, -2),
          blurRadius: 8,
          spreadRadius: 1,
        ),
      ],
    ),
    child: StylishBottomBar(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      backgroundColor: AppColors.white,
      items: List.generate(_tabs.length, (final index) => _buildBottomBarItem(_tabs[index])),
      option: AnimatedBarOptions(),
      currentIndex: _selectedIndex,
      onTap: (final index) => setState(() => _selectedIndex = index),
    ),
  );

  BottomBarItem _buildBottomBarItem(final _TabItem tab) => BottomBarItem(
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(tab.icon, size: 24.r, color: AppColors.textPrimary.withOpacity(0.45)),
        3.verticalSpace,
        TextWidget(
          text: tab.label,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary.withOpacity(0.45),
        ),
      ],
    ),
    selectedIcon: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(tab.filledIcon, size: 24.r, color: AppColors.primary),
        3.verticalSpace,
        TextWidget(
          text: tab.label,
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ],
    ),
    title: const Offstage(),
  );
}

class _TabItem {
  const _TabItem({required this.icon, required this.filledIcon, required this.label});
  final IconData icon;
  final IconData filledIcon;
  final String label;
}
