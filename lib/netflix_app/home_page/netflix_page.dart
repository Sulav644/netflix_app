import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_app/netflix_app/home_page/account_logo.dart';
import 'package:netflix_app/netflix_app/home_page/components/netflix_page_components.dart';
import 'package:netflix_app/netflix_app/home_page/series_horizontal_list.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/utils.dart';

import 'domain/movie_data.dart';
import 'components/navbar.dart';

import '../domain/review_alert_notice_cubit.dart';
import 'color_filter_logo.dart';
import 'movie_list_and_info_button.dart';
import 'navigation_icon.dart';

typedef DoubleValueSetter = void Function(double value);

enum PageState { newComing, redirected }

enum NotificationProps { height }

class NetFlixPage extends StatefulWidget {
  final PageState pageState;
  const NetFlixPage({
    super.key,
    required this.pageState,
  });

  @override
  State<NetFlixPage> createState() => _NetFlixPageState();
}

class _NetFlixPageState extends State<NetFlixPage>
    with TickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollController verticalScrollController = ScrollController(),
      horizontalScrollController = ScrollController();
  late GlobalKey keyColorToggle;

  late AnimationController notificationController, netFlixPageController;
  late Animation<TimelineValue<NotificationProps>> notificationAnimation,
      netFlixPageAnimation;

  @override
  void initState() {
    super.initState();
    keyColorToggle = GlobalKey();

    if (widget.pageState == PageState.redirected) {
      Future.microtask(
          () => context.read<ShowReviewNoticeCubit>().toggleReviewState(true));
    }

    notificationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    netFlixPageController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    notificationAnimation = TimelineTween<NotificationProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 900.milliseconds,
          curve: Curves.ease,
        )
        .animate(NotificationProps.height, tween: Tween(begin: 0.0, end: 20.0))
        .parent
        .animatedBy(notificationController);
    netFlixPageAnimation = TimelineTween<NotificationProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 1500.milliseconds,
          curve: Curves.ease,
        )
        .animate(NotificationProps.height, tween: Tween(begin: 120.0, end: 0.0))
        .parent
        .animatedBy(netFlixPageController);
    netFlixPageController.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    notificationController.dispose();
    super.dispose();
  }

  PageController controller = PageController(initialPage: 0);

  Images images = Images(
      nowPlaying: nowPlaying,
      popularSeries: popularSeries,
      animes: animes,
      tvComedies: tvComedies);

  double xOffsetForColorToggle = 0.0;
  double yOffsetForColorToggle = 0.0;
  double xOffsetForNavigation = 0.0;
  double yOffsetForNavigation = 0.0;
  int movieIndex = 0;

  @override
  Widget build(BuildContext context) {
    final reviewNoticeState = context.watch<ShowReviewNoticeCubit>().state;
    final backgroundColor = context.watch<ThemeColorCubit>().state;
    final profileDialogStatus = context.watch<ShowProfileCubit>().state;
    final colorDialogStatus = context.watch<ShowColorDialogCubit>().state;
    final navigationStatus = context.watch<ShowNavigationCubit>().state;
    final initalOffsetForNavigationDialogStatus =
        context.watch<InitialOffsetForNavigationDialogCubit>().state;
    void toggleDialogState() {
      context.read<ShowColorDialogCubit>().toggleShowColorDialog(false);
      context.read<ShowNavigationCubit>().toggleShowNavigation(false);
      context.read<ShowProfileCubit>().toggleShowProfile(false);
    }

    if (reviewNoticeState) {
      notificationController.forward();
      Future.delayed(const Duration(seconds: 2)).then((value) {
        notificationController.reverse();
      });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        context.read<ShowReviewNoticeCubit>().toggleReviewState(false);
      });
    }

    return GestureDetector(
      onTap: () {
        toggleDialogState();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  AnimatedBuilder(
                      animation: netFlixPageController,
                      builder: (context, child) {
                        return SizedBox(
                          height: netFlixPageAnimation.value
                              .get(NotificationProps.height),
                        );
                      }),
                  movieHeaderAndShowcase(
                      isColorDialogOpened: colorDialogStatus,
                      isNavigationDialogOpened: navigationStatus,
                      isProfileDialogOpened: profileDialogStatus,
                      appName: 'project90^'.capitalizeAndTrim(),
                      onClick: () {
                        toggleDialogState();
                      },
                      navigationStatus: navigationStatus),
                  SeriesHorizontalList(
                      isColorDialogOpened: colorDialogStatus,
                      isNavigationDialogOpened: navigationStatus,
                      isProfileDialogOpened: profileDialogStatus,
                      onClick: () => toggleDialogState(),
                      title: 'popular on* netflix'.capitalizeAndTrim(),
                      seriesList: images.popularSeries),
                  SeriesHorizontalList(
                      isColorDialogOpened: colorDialogStatus,
                      isNavigationDialogOpened: navigationStatus,
                      isProfileDialogOpened: profileDialogStatus,
                      onClick: () => toggleDialogState(),
                      title: 'animes'.capitalizeAndTrim(),
                      seriesList: images.animes),
                  SeriesHorizontalList(
                      isColorDialogOpened: colorDialogStatus,
                      isNavigationDialogOpened: navigationStatus,
                      isProfileDialogOpened: profileDialogStatus,
                      onClick: () => toggleDialogState(),
                      title: 'tv^ comedies'.capitalizeAndTrim(),
                      seriesList: images.tvComedies),
                ],
              ),
            ),
            NavbarPage(
              navigationState: StateForNavigation.comingFromHomePage,
              xOffsetForNavigation: initalOffsetForNavigationDialogStatus[0],
              yOffsetForNavigation: initalOffsetForNavigationDialogStatus[1],
              offsetXForColor: xOffsetForColorToggle,
              offsetYForColor: yOffsetForColorToggle,
            ),
            if (reviewNoticeState)
              NetflixPageComponents().movieReviewNotification(
                  notificationController, notificationAnimation, context),
          ],
        ),
      ),
    );
  }

  Widget movieHeaderAndShowcase(
          {required String appName,
          required VoidCallback onClick,
          required bool navigationStatus,
          required bool isProfileDialogOpened,
          required bool isColorDialogOpened,
          required bool isNavigationDialogOpened}) =>
      SizedBox(
        width: getWidth(context),
        height: getHeightRatio(context, 0.6),
        child: Stack(
          children: [
            PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  movieIndex = value;
                });
                controller.animateToPage(value,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease);
              },
              children: NetflixPageComponents()
                  .nowPlayingImages(
                      isColorDialogOpened: isColorDialogOpened,
                      isNavigationDialogOpened: isNavigationDialogOpened,
                      isProfileDialogOpened: isProfileDialogOpened,
                      images: images,
                      context: context,
                      onClick: onClick)
                  .toList(),
            ),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      movieHeader(
                          appName: appName,
                          isColorDialogOpened: isColorDialogOpened,
                          isNavigationDialogOpened: isNavigationDialogOpened,
                          isProfileDialogOpened: isProfileDialogOpened),
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    children: [
                      NavigationIcon(
                          doubleValueSetterXAxis: (value) =>
                              xOffsetForNavigation = value,
                          doubleValueSetterYAxis: (value) =>
                              yOffsetForNavigation = value,
                          navigationStatus: navigationStatus),
                    ],
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NetflixPageComponents().movieCategories(
                          onClick: onClick,
                          context: context,
                          isColorDialogOpened: isColorDialogOpened,
                          isNavigationDialogOpened: isNavigationDialogOpened,
                          isProfileDialogOpened: isProfileDialogOpened),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyListAndInfoButtons(
                        isColorDialogOpened: isColorDialogOpened,
                        isNavigationDialogOpened: isNavigationDialogOpened,
                        isProfileDialogOpened: isProfileDialogOpened,
                        movieDetail: images.nowPlaying[movieIndex],
                        onClick: onClick,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        verticalSpace(15),
                        NetflixPageComponents()
                            .movieScrollCircles(images, movieIndex),
                      ],
                    )),
              ],
            ),
          ],
        ),
      );
  Widget movieHeader(
          {required String appName,
          required bool isProfileDialogOpened,
          required bool isColorDialogOpened,
          required bool isNavigationDialogOpened}) =>
      SizedBox(
        height: 26,
        child: Row(
          children: [
            headerTitle(appName),
            headerActionIcons(
                isColorDialogOpened: isColorDialogOpened,
                isNavigationDialogOpened: isNavigationDialogOpened,
                isProfileDialogOpened: isProfileDialogOpened),
          ],
        ),
      );
  Widget headerTitle(String appName) => Expanded(
      flex: 4,
      child: Text(
        appName,
        style: const TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
      ));

  Widget headerActionIcons(
          {required bool isProfileDialogOpened,
          required bool isColorDialogOpened,
          required bool isNavigationDialogOpened}) =>
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ColorFilterLogo(
              isColorDialogOpened: isColorDialogOpened,
              isNavigationDialogOpened: isNavigationDialogOpened,
              isProfileDialogOpened: isProfileDialogOpened,
              onTap: () {
                toggleDialogState();
              },
              doubleValueSetter: (value) => xOffsetForColorToggle = value,
              key: keyColorToggle,
            ),
            const AccountLogo(),
          ],
        ),
      );
  void toggleDialogState() {
    context.read<ShowNavigationCubit>().toggleShowNavigation(false);
  }
}

class InitialOffsetForNavigationDialogCubit extends Cubit<List<double>> {
  InitialOffsetForNavigationDialogCubit() : super([0, 0]);
  void setOffset(List<double> offset) => emit(offset);
}
