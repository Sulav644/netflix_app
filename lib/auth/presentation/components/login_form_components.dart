import 'package:flutter/material.dart';
import 'package:simple_animations/timeline_tween/timeline_tween.dart';

import '../../../netflix_app/favourite_list/netflix_favorite_list.dart';
import '../../infrastructure/user_details.dart';
import '../login_form.dart';

class LoginFormComponents {
  Widget firstNameVerifyAnimationBanner(
          {required AnimationController controller,
          required Animation<TimelineValue<AnimProps>> animation,
          required String title}) =>
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Positioned(
            top: animation.value.get(AnimProps.top),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                height: 28,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 26, 25, 25),
                  border: Border(
                    bottom: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
                child: defaultTextStyle(
                  Colors.red,
                  Text(title),
                ),
              ),
            ),
          );
        },
      );
  AnimationController animationController(
          {required Validation field,
          required Validation firstStatus,
          required Validation secondStatus,
          required AnimationController firstController,
          required AnimationController secondController}) =>
      (() {
        if (field == firstStatus) {
          return firstController;
        } else if (field == secondStatus) {
          return secondController;
        } else {
          return secondController;
        }
      }());
  double animation(
          {required Validation field,
          required Validation firstStatus,
          required Validation secondStatus,
          required Animation<TimelineValue<AnimProps>> firstAnimation,
          required Animation<TimelineValue<AnimProps>> secondAnimation}) =>
      (() {
        if (field == firstStatus) {
          return firstAnimation.value.get(AnimProps.height);
        } else if (field == secondStatus) {
          return secondAnimation.value.get(AnimProps.height);
        } else {
          return secondAnimation.value.get(AnimProps.height);
        }
      }());
  int index({
    required Validation field,
    required Validation firstStatus,
    required Validation secondStatus,
  }) =>
      (() {
        if (field == firstStatus) {
          return 0;
        } else if (field == secondStatus) {
          return 1;
        } else {
          return 0;
        }
      }());
  Widget animationBuilder({
    required Validation field,
    required Validation firstStatus,
    required Validation secondStatus,
    required AnimationController firstController,
    required AnimationController secondController,
    required Animation<TimelineValue<AnimProps>> firstAnimation,
    required Animation<TimelineValue<AnimProps>> secondAnimation,
    required String firstTitle,
    required String secondTitle,
  }) =>
      AnimatedBuilder(
        animation: animationController(
            field: field,
            firstStatus: firstStatus,
            secondStatus: secondStatus,
            firstController: firstController,
            secondController: secondController),
        builder: (context, child) {
          return SizedBox(
            height: animation(
                field: field,
                firstStatus: firstStatus,
                secondStatus: secondStatus,
                firstAnimation: firstAnimation,
                secondAnimation: secondAnimation),
            child: IndexedStack(
              index: index(
                  field: field,
                  firstStatus: firstStatus,
                  secondStatus: secondStatus),
              children: [
                firstNameVerifyAnimationBanner(
                    controller: firstController,
                    animation: firstAnimation,
                    title: firstTitle),
                firstNameVerifyAnimationBanner(
                    controller: secondController,
                    animation: secondAnimation,
                    title: secondTitle),
              ],
            ),
          );
        },
      );
}
