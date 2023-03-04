import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:netflix_app/auth/presentation/login_page.dart';
import 'package:netflix_app/netflix_app/home_page/domain/movie_data.dart';

import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

import '../../../auth/infrastructure/user_details.dart';
import '../../activity/presentation/activity_log.dart';
import '../../../core/utils.dart';
import '../netflix_page.dart';

class ThemeColorCubit extends Cubit<Color> {
  ThemeColorCubit() : super(Colors.black);
  void toggleColor(Color color) {
    emit(color);
  }
}

enum StateForNavigation { comingFromHomePage, comingFromActivityLog }

List<String> list =
    ["red^", "green^", "purple^", "blue^", "pink^", "black^"].capitalizeList();
List<Color> colors = [
  Colors.red,
  Colors.green,
  Colors.purple,
  Colors.blue,
  Colors.pink,
  Colors.black
];

class ColorToggleObject {
  List<String> colorName;
  List<Color> color;
  ColorToggleObject({required this.colorName, required this.color});
}

enum AnimProps { top, opacity }

class NavbarPage extends StatefulWidget {
  final double offsetXForColor;
  final double offsetYForColor;
  final double yOffsetForNavigation;
  final double xOffsetForNavigation;
  final StateForNavigation navigationState;

  const NavbarPage({
    super.key,
    required this.offsetXForColor,
    required this.offsetYForColor,
    required this.yOffsetForNavigation,
    required this.xOffsetForNavigation,
    required this.navigationState,
  });

  @override
  State<NavbarPage> createState() => _NavbarPageState();
}

class _NavbarPageState extends State<NavbarPage> with TickerProviderStateMixin {
  late AnimationController animationController,
      optionController,
      drawerController;
  late Animation<TimelineValue<AnimProps>> animation,
      optionAnimation,
      drawerAnimation;

  final PageController itemScrollController = PageController();
  PageController controller = PageController(initialPage: 0);

  late GlobalKey keyForColorToggle, keyForNavigation;
  double xOffsetForColorToggle = 0.0;
  double yOffsetForColorToggle = 0.0;
  double xOffsetForNavigation = 0.0;
  double yOffsetForNavigation = 0.0;

  @override
  void dispose() {
    controller.dispose();
    itemScrollController.dispose();
    animationController.dispose();
    optionController.dispose();
    drawerController.dispose();
    super.dispose();
  }

  double x = 0.0;
  double y = 0.0;

  double shiftToValue = 1;

  bool showPassword = false;
  bool showProfileDialog = false;

  @override
  void initState() {
    super.initState();
    keyForColorToggle = GlobalKey();
    keyForNavigation = GlobalKey();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    animation = TimelineTween<AnimProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 900.milliseconds,
          curve: Curves.ease,
        )
        .animate(AnimProps.top, tween: Tween(begin: 210.0, end: 60.16))
        .parent
        .animatedBy(animationController);

    optionController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    optionAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 900.milliseconds,
          curve: Curves.ease,
        )
        .animate(AnimProps.top, tween: Tween(begin: 20.0, end: 60.16))
        .addSubsequentScene(
          duration: 100.milliseconds,
          curve: Curves.ease,
        )
        .animate(AnimProps.opacity, tween: Tween(begin: 20.0, end: 60.16))
        .parent
        .animatedBy(optionController);
    drawerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    drawerAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(
          begin: 0.milliseconds,
          end: 900.milliseconds,
          curve: Curves.ease,
        )
        .animate(AnimProps.top, tween: Tween(begin: 28.0, end: 32.16))
        .parent
        .animatedBy(drawerController);
    drawerController.repeat();
  }

  void reverseOptionAnimation() {
    optionController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final detailStatus = context.watch<DetailsCubit>().state;
    final profileDialogStatus = context.watch<ShowProfileCubit>().state;
    final colorDialogStatus = context.watch<ShowColorDialogCubit>().state;
    final navigationStatus = context.watch<ShowNavigationCubit>().state;
    if (!colorDialogStatus) {
      reverseOptionAnimation();
    }
    if (colorDialogStatus) {
      optionController.forward();
    } else {
      optionController.reverse();
    }

    setState(() {
      xOffsetForColorToggle = widget.offsetXForColor;
      yOffsetForColorToggle = widget.offsetYForColor;
    });
    if (profileDialogStatus) {
      setState(() {
        showProfileDialog = true;
      });
      animationController.forward();
    }
    if (!profileDialogStatus) {
      animationController.reverse().then((value) => setState(
            () {
              showProfileDialog = false;
            },
          ));
    }
    return Stack(
      children: [
        if (navigationStatus)
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: widget.yOffsetForNavigation + 40,
                    left: widget.xOffsetForNavigation + 10),
                child: NavigationDialog(
                  yOffset: widget.yOffsetForNavigation,
                  xOffset: widget.xOffsetForNavigation,
                  navigationState: widget.navigationState,
                ),
              ),
            ],
          ),
        if (colorDialogStatus)
          ColorToggler(
              optionAnimation: optionAnimation,
              pageController: itemScrollController,
              xOffsetForColorToggle: xOffsetForColorToggle),
        if (showProfileDialog)
          ProfileDialog(
              onTap: () => setState(() {
                    showPassword = !showPassword;
                  }),
              showPassword: showPassword,
              animationController: animationController,
              animation: animation,
              detailStatus: detailStatus),
      ],
    );
  }
}

class NavigationDialog extends StatelessWidget {
  final StateForNavigation navigationState;
  final double yOffset;
  final double xOffset;

  const NavigationDialog(
      {super.key,
      required this.navigationState,
      required this.yOffset,
      required this.xOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 124, 123, 123),
          borderRadius: BorderRadius.circular(10)),
      child: defaultTextStyle(
          Colors.white,
          NavigationItems(
            yOffset: yOffset,
            xOffset: xOffset,
            navigationState: navigationState,
          )),
    );
  }
}

class NavigationItems extends StatelessWidget {
  final double yOffset;
  final double xOffset;
  final StateForNavigation navigationState;

  const NavigationItems(
      {super.key,
      required this.navigationState,
      required this.yOffset,
      required this.xOffset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              debugPrint('yOffsetForNavigation $yOffset');
              debugPrint('xOffsetForNavigation $xOffset');

              if (navigationState == StateForNavigation.comingFromActivityLog) {
                navigateToConsequentPage(
                  context,
                  0,
                );
              }
            },
            child: Container(
              width: getWidthRatio(context, 0.25),
              height: getHeightRatio(context, 0.04),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: NavigationField(
                title: 'home'.capitalize(),
                style: TextStyle(
                    color:
                        navigationState == StateForNavigation.comingFromHomePage
                            ? Colors.blue
                            : Colors.white),
              ),
            ),
          ),
          verticalSpace(getHeightRatio(context, 0.01)),
          GestureDetector(
            onTap: () {
              debugPrint('yOffsetForNavigation $yOffset');
              debugPrint('xOffsetForNavigation $xOffset');

              if (navigationState == StateForNavigation.comingFromHomePage) {
                navigateToConsequentPage(
                  context,
                  1,
                );
              }
            },
            child: Container(
              width: getWidthRatio(context, 0.25),
              height: getHeightRatio(context, 0.04),
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: NavigationField(
                title: 'activity log'.capitalizeAndTrim(),
                style: TextStyle(
                    color: navigationState ==
                            StateForNavigation.comingFromActivityLog
                        ? Colors.blue
                        : Colors.white),
              ),
            ),
          ),
          verticalSpace(4),
        ],
      ),
    );
  }

  Future<dynamic> navigateToConsequentPage(
    BuildContext context,
    int index,
  ) =>
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return (() {
          if (index == 0) {
            return const NetFlixPage(pageState: PageState.newComing);
          } else {
            return const ActivityLogPage();
          }
        }());
      }));
}

class NavigationField extends StatelessWidget {
  final String title;

  final TextStyle style;
  const NavigationField({super.key, required this.title, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: style,
    );
  }
}

class ColorToggler extends StatefulWidget {
  final Animation<TimelineValue<AnimProps>> optionAnimation;

  final PageController pageController;
  final double xOffsetForColorToggle;

  const ColorToggler(
      {super.key,
      required this.optionAnimation,
      required this.pageController,
      required this.xOffsetForColorToggle});

  @override
  State<ColorToggler> createState() => _ColorTogglerState();
}

class _ColorTogglerState extends State<ColorToggler> {
  final controller = PageController(initialPage: 0);
  ColorToggleObject colorObject =
      ColorToggleObject(colorName: list, color: colors);
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.optionAnimation,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                top: widget.optionAnimation.value.get(AnimProps.top),
                left: widget.xOffsetForColorToggle - 150),
            child: defaultTextStyle(
                Colors.white,
                Row(
                  children: [
                    ColorBoxScrollIcon(
                        counter: counter,
                        itemScrollController: controller,
                        icon: '<',
                        onTap: () {
                          _previousCounter();
                          controller.animateToPage(counter,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        }),
                    colorBoxAndScroller(controller),
                    ColorBoxScrollIcon(
                        counter: counter,
                        itemScrollController: controller,
                        icon: '>',
                        onTap: () {
                          _nextCounter();
                          controller.animateToPage(counter,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        }),
                  ],
                ),
                20),
          );
        });
  }

  Widget colorBoxAndScroller(PageController controller) => SizedBox(
      width: 110,
      height: 40,
      child: PageView(
        controller: controller,
        onPageChanged: (value) {
          counter = value;
        },
        children: [
          ...colorObject.colorName
              .map((e) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<ThemeColorCubit>().toggleColor(
                              colorObject
                                  .color[colorObject.colorName.indexOf(e)]);
                          context
                              .read<ShowColorDialogCubit>()
                              .toggleShowColorDialog(false);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(e),
                            )),
                      ),
                    ],
                  ))
              .toList()
        ],
      ));
  int counter = 0;

  void _nextCounter() {
    setState(() => counter = (counter + 1) % list.length);
  }

  void _previousCounter() {
    setState(() => counter = (counter - 1) % list.length);
  }
}

class ColorBoxScrollIcon extends StatelessWidget {
  final int counter;
  final String icon;
  final PageController itemScrollController;
  final VoidCallback onTap;
  const ColorBoxScrollIcon(
      {super.key,
      required this.counter,
      required this.itemScrollController,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: 40,
        height: 40,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(100)),
            child: Text(icon)),
      ),
    );
  }
}

class ProfileDialog extends StatelessWidget {
  final AnimationController animationController;
  final Animation<TimelineValue<AnimProps>> animation;
  final UserDetails detailStatus;
  final bool showPassword;
  final VoidCallback onTap;
  const ProfileDialog(
      {super.key,
      required this.animationController,
      required this.animation,
      required this.detailStatus,
      required this.showPassword,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color.fromARGB(220, 40, 40, 40),
        ),
        AnimatedBuilder(
            animation: animationController,
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimationBarToRaiseProfileSection(
                          animationController: animationController,
                          animation: animation),
                      profileBanner(context, showPassword, onTap),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget profileBanner(
          BuildContext context, bool showPassword, VoidCallback onTap) =>
      Container(
        width: getWidthRatio(context, 0.9),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 145, 143, 143),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            profileHeader(context),
            profileDetails(showPassword, onTap, context),
          ],
        ),
      );

  Widget profileHeader(BuildContext context) => Stack(
        children: [
          Container(
            height: getHeightRatio(context, 0.3),
            decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            alignment: Alignment.center,
            child: const Text(
              'Project90',
              style: TextStyle(fontSize: 65, color: Colors.red),
            ),
          ),
          SizedBox(
            height: getHeightRatio(context, 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: getWidthRatio(context, 0.38),
                  height: getWidthRatio(context, 0.38),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getHeightRatio(context, 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                detailStatus.image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(
                          detailStatus.image!,
                        ),
                        radius: getWidthRatio(context, 0.18),
                      )
                    : CircleAvatar(
                        backgroundImage: const NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMOcWwaMRfd3rZmyShkF0I-fTDSHEnH3_Rgg&usqp=CAU'),
                        radius: getWidthRatio(context, 0.18),
                      ),
              ],
            ),
          )
        ],
      );
  Widget profileDetails(
          bool showPassword, VoidCallback onTap, BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultTextStyle(
          Colors.black,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${detailStatus.firstName} ${detailStatus.lastName}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'phone'.capitalize(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: getWidthRatio(context, 0.5),
                    child: Text(
                      '${detailStatus.phone}',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'email'.capitalize(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                      width: getWidthRatio(context, 0.5),
                      child: Text(detailStatus.email)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'password'.capitalize(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: getWidthRatio(context, 0.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: getWidthRatio(context, 0.35),
                          child: showPassword
                              ? Text(
                                  detailStatus.password,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : const Text('*********'),
                        ),
                        showPassword
                            ? GestureDetector(
                                onTap: () => onTap(),
                                child: const Icon(Icons.visibility))
                            : GestureDetector(
                                onTap: () => onTap(),
                                child: const Icon(Icons.visibility_off)),
                      ],
                    ),
                  ),
                ],
              ),
              verticalSpace(getHeightRatio(context, 0.3))
            ],
          ),
        ),
      );
}

class AnimationBarToRaiseProfileSection extends StatelessWidget {
  final AnimationController animationController;
  final Animation<TimelineValue<AnimProps>> animation;
  const AnimationBarToRaiseProfileSection(
      {super.key, required this.animationController, required this.animation});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        height: animation.value.get(AnimProps.top),
        color: Colors.transparent,
      ),
    );
  }
}

class ShowProfileCubit extends Cubit<bool> {
  ShowProfileCubit() : super(false);
  void toggleShowProfile(bool status) {
    emit(status);
  }
}

class ShowColorDialogCubit extends Cubit<bool> {
  ShowColorDialogCubit() : super(false);
  void toggleShowColorDialog(bool status) {
    emit(status);
  }
}

class ShowNavigationCubit extends Cubit<bool> {
  ShowNavigationCubit() : super(false);
  void toggleShowNavigation(bool status) {
    emit(status);
  }
}
