import 'package:flutter/material.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/loader_page.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:netflix_app/auth/presentation/login_page.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

enum SplashProps { left, top, width }

const title = "project:90";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller, controllerTwo, controllerThree;
  late Animation<TimelineValue<SplashProps>> animation,
      animationTwo,
      animationThree;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4)).then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const LoaderPage(
            goToPage: RangeSelectorPage(),
          );
        })));
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animation = TimelineTween<SplashProps>()
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.ease,
        )
        .animate(SplashProps.left, tween: Tween(begin: 30.0, end: 0.0))
        .parent
        .animatedBy(controller);
    controllerTwo = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animationTwo = TimelineTween<SplashProps>()
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.ease,
        )
        .animate(SplashProps.top, tween: Tween(begin: 20.0, end: 40.0))
        .parent
        .animatedBy(controllerTwo);

    controllerThree = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    animationThree = TimelineTween<SplashProps>()
        .addScene(
          begin: 0.milliseconds,
          end: 1000.milliseconds,
          curve: Curves.ease,
        )
        .animate(SplashProps.width, tween: Tween(begin: 300.0, end: 10.0))
        .parent
        .animatedBy(controllerThree);

    animateOne();
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => animateThree());
    Future.delayed(const Duration(milliseconds: 1500))
        .then((value) => animateTwo());
  }

  void animateOne() {
    controller.forward();
  }

  void animateTwo() {
    controllerTwo.forward();
  }

  void animateThree() {
    controllerThree.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: defaultTextStyle(
              Colors.red,
              Container(
                height: getHeightRatio(context, 0.2),
                width: getWidthRatio(context, 0.8),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    AnimatedBuilder(
                      animation: controller,
                      builder: (context, state) {
                        return Positioned(
                            top: 40,
                            left: animation.value.get(SplashProps.left),
                            child: Text(title
                                .toUpperCase()
                                .substring(0, title.indexOf(":"))));
                      },
                    ),
                    AnimatedBuilder(
                      animation: controllerTwo,
                      builder: (context, state) {
                        return Positioned(
                            left: 220,
                            top: animationTwo.value.get(SplashProps.top),
                            child: Text(title
                                .capitalize()
                                .substring(title.indexOf(":") + 1)));
                      },
                    ),
                    AnimatedBuilder(
                      animation: controllerThree,
                      builder: (context, state) {
                        return Positioned(
                          right: 0,
                          child: Container(
                            width: animationThree.value.get(SplashProps.width),
                            height: 200,
                            color: Colors.black,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              50,
              FontWeight.bold)),
    );
  }
}
