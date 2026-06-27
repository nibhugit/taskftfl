import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_ftfl/routes/navigation_routes.dart';
import 'package:task_ftfl/style/colors.dart';
import 'package:task_ftfl/style/style.dart';
import 'package:task_ftfl/ui/home/bloc/home_bloc.dart';
import 'package:task_ftfl/ui/home/bloc/home_event.dart';
import 'package:task_ftfl/ui/home/bloc/home_state.dart';
import 'package:task_ftfl/ui/home/models/home_model.dart';
import 'package:task_ftfl/ui/notification/notification_screen.dart';
import 'package:task_ftfl/widgets/base_stateful_widget_state.dart';
import 'package:task_ftfl/widgets/common_appbar.dart';
import 'package:task_ftfl/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidgetState<HomeScreen> {
  final CardSwiperController controller = CardSwiperController();

  @override
  void initialize() {
    super.initialize();
    useSafeArea = true;
    scaffoldBackgroundColor = AppColors.white;
    context.read<HomeBloc>().add(GetUsersEvent());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(final BuildContext context) => BlocBuilder<HomeBloc, HomeState>(
    builder: (context, state) {
      if (state is HomeLoading || state is HomeInitial) {
        return const Center(child: CircularProgressIndicator(color: AppColors.primary));
      } else if (state is HomeError) {
        return Center(
          child: TextWidget(text: state.message, color: AppColors.error),
        );
      } else if (state is HomeLoaded) {
        final profiles = state.profiles;
        if (profiles.isEmpty) {
          return const Center(
            child: TextWidget(text: 'No profiles found', color: AppColors.textPrimary),
          );
        }
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: AppStyles.defaultPadding.copyWith(top: 0),
                child: CardSwiper(
                  controller: controller,
                  cardsCount: profiles.length,
                  onSwipe: (final previousIndex, final currentIndex, final direction) => true,
                  numberOfCardsDisplayed: profiles.length > 2 ? 2 : profiles.length,
                  padding: EdgeInsets.zero,
                  allowedSwipeDirection: const AllowedSwipeDirection.only(left: true, right: true),
                  cardBuilder:
                      (
                        final context,
                        final index,
                        final horizontalThresholdPercentage,
                        final verticalThresholdPercentage,
                      ) {
                        final profile = profiles[index];
                        return _buildProfileCard(profile);
                      },
                ),
              ),
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    },
  );

  @override
  PreferredSizeWidget? buildAppBar(final BuildContext context) => CommonAppBar(
    leading: Center(
      child: CircleAvatar(
        backgroundColor: AppColors.white,
        radius: 20.r,
        child: Icon(Icons.menu, color: AppColors.textPrimary, size: 24.r),
      ),
    ),
    titleWidget: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: AppColors.primary, size: 10.r),
          8.horizontalSpace,
          TextWidget(
            text: 'Dally 25',
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ],
      ),
    ),
    prefixWidget: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 20.r,
          child: Icon(Icons.flash_on, color: AppColors.textPrimary, size: 24.r),
        ),
        4.horizontalSpace,
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 20.r,
          child: Icon(Icons.tune, color: AppColors.textPrimary, size: 24.r),
        ),
        4.horizontalSpace,
        GestureDetector(
          onTap: () {
            navigate(enterPage: const NotificationScreen());
          },
          child: CircleAvatar(
            backgroundColor: AppColors.white,
            radius: 20.r,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 24.r),
                Container(
                  margin: EdgeInsets.only(top: 2.h, right: 3.w),
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
        ),
        16.horizontalSpace,
      ],
    ),
  );

  Widget _buildProfileCard(final ProfileModel profile) => LayoutBuilder(
    builder: (final context, final constraints) {
      final cardHeight = constraints.maxHeight;
      return ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: AppColors.creamBackground)),
            Positioned.fill(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildImageSection(profile, cardHeight),

                    _buildDetailsSection(profile),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 24.h,
              right: 16.w,
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 15.r,
                      spreadRadius: 2.r,
                    ),
                  ],
                ),
                child: TextWidget(text: '🌹', fontSize: 28.sp),
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _buildImageSection(final ProfileModel profile, final double cardHeight) => SizedBox(
    height: cardHeight,
    child: Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: profile.imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (final context, final url) => Container(color: Colors.grey[200]),
          errorWidget: (final context, final url, final error) =>
              Container(color: Colors.grey[200]),
        ),
        // Gradient for text readability
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.5, 0.8, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          top: 20.h,
          left: 16.w,
          right: 16.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 22.r,
                child: Icon(Icons.refresh, color: AppColors.textPrimary, size: 24.r),
              ),
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 22.r,
                child: Icon(Icons.more_vert, color: AppColors.textPrimary, size: 24.r),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24.h,
          left: 20.w,
          right: 20.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildTag(Icons.circle, Colors.blue, '${profile.matchPercent ?? 0}% Match'),
                  _buildTag(Icons.circle, Colors.green, '${profile.trustPercent ?? 0}% Trust'),
                  _buildTag(Icons.circle, Colors.orange, profile.replyTime ?? ''),
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  Container(
                    width: 10.r,
                    height: 10.r,
                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                  ),
                  8.horizontalSpace,
                  Flexible(
                    child: TextWidget(
                      text: '${profile.name ?? ''} ',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextWidget(text: '${profile.age ?? ''}', fontSize: 20.sp),
                  8.horizontalSpace,
                  Icon(Icons.check_circle, color: AppColors.primary, size: 20.r),
                ],
              ),
              12.verticalSpace,
              _buildInfoRow(
                Icons.location_on,
                '${profile.location ?? ''} · ${profile.distance ?? ''}',
              ),
              6.verticalSpace,
              _buildInfoRow(
                Icons.work_outline,
                '${profile.occupation ?? ''} · ${profile.height ?? ''}',
              ),
              6.verticalSpace,
              _buildInfoRow(Icons.favorite, profile.intent ?? ''),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildDetailsSection(final ProfileModel profile) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildDetailsTag(
                const Color(0xFF3498DB),
                '${profile.matchPercent ?? 0}% Match',
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: _buildDetailsTag(
                const Color(0xFF2ECC71),
                '${profile.trustPercent ?? 0}% Trust',
              ),
            ),
            8.horizontalSpace,
            Expanded(child: _buildDetailsTag(const Color(0xFFF1C40F), profile.replyTime ?? '')),
          ],
        ),
        24.verticalSpace,

        TextWidget(
          text: 'ABOUT',
          color: const Color(0xFFD35E71),
          fontSize: 13.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
        12.verticalSpace,
        // Bio Text
        TextWidget(
          text: profile.bio ?? '',
          color: AppColors.textPrimary.withOpacity(0.8),
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          textHeight: 1.5,
        ),
        24.verticalSpace,
        // Details Card
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailsRow(
                icon: Icons.cake_outlined,
                title: 'Age',
                value: '${profile.age ?? 0} years old',
                subtext: profile.dobDate,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.straighten_outlined,
                title: 'Height',
                value: profile.height ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.filter_hdr_outlined,
                title: 'Lives in',
                value: profile.locationCity ?? '',
                subtext: profile.locationRegion,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.favorite_border_outlined,
                title: 'Love language',
                value: profile.loveLanguage ?? '',
                subtext: profile.loveLanguageSubtext,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.spa_outlined,
                title: 'Religion',
                value: profile.religion ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.wc_outlined,
                title: 'Interested in',
                value: profile.interestedIn ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.wb_sunny_outlined,
                title: 'Zodiac',
                value: profile.zodiac ?? '',
                subtext: profile.zodiacTraits,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.translate_outlined,
                title: 'Mother tongue',
                value: profile.motherTongue ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.phone_outlined,
                title: 'Communication style',
                value: profile.communicationStyle ?? '',
              ),
            ],
          ),
        ),
        24.verticalSpace,

        _buildVideoCard(profile),
        24.verticalSpace,

        _buildPromptCard(profile.prompt1Question ?? '', profile.prompt1Answer ?? ''),
        24.verticalSpace,

        _buildSectionHeader('CAREER & AMBITION'),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailsRow(
                icon: Icons.school_outlined,
                title: 'Education',
                value: profile.eduCollege ?? '',
                subtext: profile.eduDegree,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.business_center_outlined,
                title: 'Work as',
                value: profile.workRole ?? '',
                subtext: profile.workDetails,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.auto_awesome_outlined,
                title: 'Work style',
                value: profile.workStyle ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.trending_up_outlined,
                title: 'Ambition level',
                value: profile.ambitionLevel ?? '',
              ),
              _buildDivider(),
              TextWidget(
                text:
                    '${(profile.interestedIn?.contains('Women') ?? false) ? 'HER' : 'HIS'} BIG DREAM',
                color: const Color(0xFFD35E71),
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
              8.verticalSpace,
              TextWidget(
                text: profile.bigDream ?? '',
                color: AppColors.textPrimary.withOpacity(0.8),
                fontSize: 14.sp,
                textHeight: 1.4,
              ),
            ],
          ),
        ),
        24.verticalSpace,

        _buildImageCard(profile.imageUrl2 ?? ''),
        24.verticalSpace,

        _buildPromptCard(profile.prompt2Question ?? '', profile.prompt2Answer ?? ''),
        24.verticalSpace,

        _buildSectionHeader('INTERESTS & HOBBIES'),
        Wrap(
          spacing: 8.w,
          runSpacing: 10.h,
          children: (profile.interests ?? []).map(_buildInterestPill).toList(),
        ),
        24.verticalSpace,

        _buildSectionHeader('LIFESTYLE'),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailsRow(
                icon: Icons.restaurant_menu_outlined,
                title: 'Diet',
                value: profile.lifestyleDiet ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.local_bar_outlined,
                title: 'Drinking',
                value: profile.lifestyleDrinking ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.smoke_free_outlined,
                title: 'Smoking',
                value: profile.lifestyleSmoking ?? '',
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.show_chart_outlined,
                title: 'Fitness',
                value: profile.lifestyleFitness ?? '',
                subtext: profile.lifestyleFitnessSub,
              ),
              _buildDivider(),
              _buildDetailsRow(
                icon: Icons.explore_outlined,
                title: 'Travel',
                value: profile.lifestyleTravel ?? '',
              ),
            ],
          ),
        ),
        24.verticalSpace,

        _buildDatingGoalCard(profile),
        24.verticalSpace,

        _buildImageCard(profile.imageUrl3 ?? ''),

        80.verticalSpace,
      ],
    ),
  );

  Widget _buildDetailsTag(final Color dotColor, final String text) => Container(
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2)),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
        ),
        8.horizontalSpace,
        Flexible(
          child: TextWidget(
            text: text,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
  );

  Widget _buildDetailsRow({
    required final IconData icon,
    required final String title,
    required final String value,
    final String? subtext,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFD35E71), size: 20.r),
          12.horizontalSpace,
          TextWidget(
            text: title,
            color: AppColors.textPrimary.withOpacity(0.6),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
      16.horizontalSpace,
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              text: value,
              color: AppColors.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.end,
            ),
            if (subtext != null) ...[
              2.verticalSpace,
              TextWidget(
                text: subtext,
                color: AppColors.textPrimary.withOpacity(0.4),
                fontSize: 11.sp,
                textAlign: TextAlign.end,
              ),
            ],
          ],
        ),
      ),
    ],
  );

  Widget _buildDivider() =>
      Divider(height: 24.h, thickness: 0.5, color: Colors.grey.withOpacity(0.2));

  Widget _buildTag(final IconData icon, final Color iconColor, final String text) => Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    decoration: BoxDecoration(
      color: AppColors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: AppColors.white.withOpacity(0.3)),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4.r)],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 10.r),
        6.horizontalSpace,
        TextWidget(text: text, fontSize: 12.sp, fontWeight: FontWeight.w600),
      ],
    ),
  );

  Widget _buildInfoRow(final IconData icon, final String text) => Row(
    children: [
      Icon(icon, color: AppColors.white, size: 18.r),
      10.horizontalSpace,
      Expanded(
        child: TextWidget(text: text, fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    ],
  );

  Widget _buildVideoCard(final ProfileModel profile) => ClipRRect(
    borderRadius: BorderRadius.circular(24.r),
    child: SizedBox(
      height: 220.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: profile.videoThumbnailUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (final context, final url) => Container(color: Colors.grey[200]),
            errorWidget: (final context, final url, final error) =>
                Container(color: Colors.grey[200]),
          ),
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.2))),
          Center(
            child: Container(
              width: 50.r,
              height: 50.r,
              decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
              child: Icon(Icons.play_arrow, color: AppColors.textPrimary, size: 28.r),
            ),
          ),
          Positioned(
            bottom: 12.h,
            left: 16.w,
            child: TextWidget(
              text: 'Video intro · 0:28',
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildPromptCard(final String title, final String answer) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: title,
          color: const Color(0xFFD35E71),
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        10.verticalSpace,
        TextWidget(
          text: answer,
          color: AppColors.textPrimary,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          textHeight: 1.3,
        ),
        16.verticalSpace,
        Container(
          padding: EdgeInsets.all(6.r),
          decoration: BoxDecoration(
            color: AppColors.creamBackground.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
          ),
          child: TextWidget(text: '🌹', fontSize: 16.sp),
        ),
      ],
    ),
  );

  Widget _buildImageCard(final String imageUrl) => ClipRRect(
    borderRadius: BorderRadius.circular(24.r),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      height: 350.h,
      fit: BoxFit.cover,
      placeholder: (final context, final url) => Container(color: Colors.grey[200], height: 350.h),
      errorWidget: (final context, final url, final error) =>
          Container(color: Colors.grey[200], height: 350.h),
    ),
  );

  Widget _buildSectionHeader(final String title) => Padding(
    padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
    child: TextWidget(
      text: title,
      color: const Color(0xFFD35E71),
      fontSize: 13.sp,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.2,
    ),
  );

  Widget _buildDatingGoalCard(final ProfileModel profile) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(20.r),
    decoration: BoxDecoration(
      color: const Color(0xFFE91E63),
      borderRadius: BorderRadius.circular(24.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE91E63).withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: 'DATING GOAL',
          color: AppColors.white.withOpacity(0.8),
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
        8.verticalSpace,
        TextWidget(
          text: profile.datingGoalTitle ?? '',
          fontSize: 18.sp,
          fontWeight: FontWeight.w800,
        ),
        8.verticalSpace,
        TextWidget(
          text: profile.datingGoalDesc ?? '',
          color: AppColors.white.withOpacity(0.9),
          fontSize: 13.sp,
          textHeight: 1.4,
        ),
      ],
    ),
  );

  Widget _buildInterestPill(final String label) {
    IconData getInterestIcon(final String val) {
      switch (val.toLowerCase()) {
        case 'travel':
          return Icons.flight_takeoff_outlined;
        case 'coffee':
          return Icons.coffee_outlined;
        case 'trekking':
          return Icons.terrain_outlined;
        case 'books':
          return Icons.book_outlined;
        case 'yoga':
          return Icons.self_improvement_outlined;
        case 'indie music':
          return Icons.music_note_outlined;
        case 'cooking':
          return Icons.restaurant_outlined;
        case 'photography':
          return Icons.camera_alt_outlined;
        case 'art':
          return Icons.palette_outlined;
        case 'cycling':
          return Icons.directions_bike_outlined;
        case 'gardening':
          return Icons.yard_outlined;
        case 'movies':
          return Icons.movie_outlined;
        default:
          return Icons.star_border_outlined;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFD35E71).withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(getInterestIcon(label), color: const Color(0xFFD35E71), size: 18.r),
          8.horizontalSpace,
          TextWidget(
            text: label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
