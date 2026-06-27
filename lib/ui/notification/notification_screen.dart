import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_ftfl/style/colors.dart';
import 'package:task_ftfl/widgets/base_stateful_widget_state.dart';
import 'package:task_ftfl/widgets/common_appbar.dart';
import 'package:task_ftfl/widgets/text_widget.dart';

enum NotificationType { rose, compliment, match, message, dateApproved }

class NotificationModel {
  final String? imageUrl;
  final String title;
  final String subtitle;
  final String time;
  final NotificationType type;
  final bool isUnread;
  final String? actionLabel;
  final IconData? placeholderIcon;
  final Color? placeholderIconBgColor;
  final Color? badgeColor;

  const NotificationModel({
    this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.type,
    this.isUnread = false,
    this.actionLabel,
    this.placeholderIcon,
    this.placeholderIconBgColor,
    this.badgeColor,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends BaseStatefulWidgetState<NotificationScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = ['All  56', 'Likes & roses', 'Matches', 'Gifts', 'Dates'];

  final List<NotificationModel> _notifications = [
    const NotificationModel(
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      title: 'Dev, 27 sent you a Rose',
      subtitle: '"Your trekking photos sold me — let\'s swap trail stories."',
      time: '12 min ago',
      type: NotificationType.rose,
      isUnread: true,
      actionLabel: 'View profile',
      badgeColor: Color(0xFFE91E63),
    ),
    const NotificationModel(
      imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
      title: 'Arjun, 28 complimented your About',
      subtitle: '"Equally driven and equally curious — that line got me."',
      time: '3 h ago',
      type: NotificationType.compliment,
      badgeColor: Color(0xFFFFB300),
    ),
    const NotificationModel(
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      title: 'It\'s a match with Aanya, 25',
      subtitle: 'You both liked each other. Say hello before the spark fades.',
      time: '40 min ago',
      type: NotificationType.match,
      isUnread: true,
      actionLabel: 'Send a message',
      badgeColor: Color(0xFF4CAF50),
    ),
    const NotificationModel(
      imageUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
      title: 'Elena, 23 sent you a message',
      subtitle: '"Haha okay that café pick was elite. When are you free?"',
      time: '1 h ago',
      type: NotificationType.message,
      isUnread: true,
      badgeColor: Color(0xFFFFB300),
    ),
    const NotificationModel(
      title: 'Kabir approved your date request',
      subtitle: 'Coffee at Blue Tokai · Today, 7:00 PM · Koregaon Park',
      time: '2 h ago',
      type: NotificationType.dateApproved,
      isUnread: true,
      actionLabel: 'Open chat',
      placeholderIcon: Icons.calendar_today_outlined,
      placeholderIconBgColor: Color(0xFFFFF3E0),
    ),
  ];

  @override
  void initialize() {
    super.initialize();
    useSafeArea = true;
    scaffoldBackgroundColor = const Color(0xFFF7F3F0);
  }

  @override
  PreferredSizeWidget? buildAppBar(final BuildContext context) => CommonAppBar(
    title: 'Notifications',
    subtitle: '9 new updates',
    isCenterTitle: false,
    prefixWidget: Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: TextWidget(
            text: 'Mark all read',
            color: AppColors.primary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );

  @override
  Widget buildBody(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      10.verticalSpace,
      SizedBox(
        height: 33.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _filters.length,
          separatorBuilder: (_, final __) => SizedBox(width: 8.w),
          itemBuilder: (final context, final index) {
            final isSelected = _selectedFilterIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedFilterIndex = index),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.textPrimary : AppColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? AppColors.textPrimary : Colors.grey.withOpacity(0.25),
                  ),
                ),
                child: TextWidget(
                  text: _filters[index],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.white : AppColors.textPrimary,
                ),
              ),
            );
          },
        ),
      ),

      16.verticalSpace,

      Padding(
        padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
        child: TextWidget(
          text: 'TODAY',
          color: AppColors.textPrimary.withOpacity(0.45),
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),

      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: _notifications.length,
          separatorBuilder: (_, final __) => 10.verticalSpace,
          itemBuilder: (final context, final index) =>
              _buildNotificationCard(_notifications[index]),
        ),
      ),
    ],
  );

  Widget _buildNotificationCard(final NotificationModel notif) => Container(
    padding: EdgeInsets.all(14.r),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            notif.imageUrl != null
                ? CircleAvatar(
                    radius: 28.r,
                    backgroundImage: NetworkImage(notif.imageUrl!),
                    backgroundColor: Colors.grey[200],
                  )
                : Container(
                    width: 56.r,
                    height: 56.r,
                    decoration: BoxDecoration(
                      color: notif.placeholderIconBgColor ?? const Color(0xFFFFF3E0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      notif.placeholderIcon ?? Icons.calendar_today_outlined,
                      color: AppColors.primary,
                      size: 26.r,
                    ),
                  ),
            if (notif.badgeColor != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 18.r,
                  height: 18.r,
                  decoration: BoxDecoration(
                    color: notif.badgeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                  child: Icon(
                    notif.type == NotificationType.rose
                        ? Icons.favorite
                        : notif.type == NotificationType.match
                        ? Icons.check
                        : notif.type == NotificationType.compliment
                        ? Icons.emoji_emotions_outlined
                        : Icons.message_outlined,
                    color: AppColors.white,
                    size: 10.r,
                  ),
                ),
              ),
          ],
        ),

        12.horizontalSpace,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                        children: _buildTitleSpans(notif.title),
                      ),
                    ),
                  ),
                  if (notif.isUnread) ...[
                    8.horizontalSpace,
                    Container(
                      width: 9.r,
                      height: 9.r,
                      margin: EdgeInsets.only(top: 4.h),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE91E63),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 4.h),
              TextWidget(
                text: notif.subtitle,
                color: AppColors.textPrimary.withOpacity(0.6),
                fontSize: 13.sp,
                textHeight: 1.4,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
              ),
              6.verticalSpace,
              TextWidget(
                text: notif.time,
                color: AppColors.textPrimary.withOpacity(0.4),
                fontSize: 12.sp,
              ),
              if (notif.actionLabel != null) ...[
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextWidget(
                      text: notif.actionLabel!,
                      color: AppColors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );

  List<TextSpan> _buildTitleSpans(final String title) {
    final boldWords = RegExp(r'(\w+,\s*\d+|About|match)');
    final spans = <TextSpan>[];
    var lastEnd = 0;

    for (final match in boldWords.allMatches(title)) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(text: title.substring(lastEnd, match.start)));
      }
      spans.add(
        TextSpan(
          text: title.substring(match.start, match.end),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < title.length) {
      spans.add(TextSpan(text: title.substring(lastEnd)));
    }
    return spans;
  }
}
