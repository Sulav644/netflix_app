import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../../core/utils.dart';
import '../domain/activity_freezed.dart';
import 'activity_log.dart';

class ActivityLogWidgets {
  final Color color;
  ActivityLogWidgets({required this.color});
  Widget buildItems(int index, List<String> list,
      List<ActivitySingle> activityList, ActivitySingle activity) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (activityList.length > 1)
            mainTreeToJoinAllRecords(activityList, activity),
          treeToJoinAllAddedItemsSubtree(activityList, activity, index),
          addedItemsSubtree(list, index),
        ],
      ),
    );
  }

  Widget mainTreeToJoinAllRecords(
          List<ActivitySingle> activityList, ActivitySingle activity) =>
      Row(
        children: [
          horizontalSpace(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (activity != activityList[activityList.lastIndex!])
                Expanded(
                  child: verticalDivider(width: 2, height: 50, thickness: 3),
                )
            ],
          ),
        ],
      );

  Widget treeToJoinAllAddedItemsSubtree(List<ActivitySingle> activityList,
          ActivitySingle activity, int index) =>
      Expanded(
        flex: 2,
        child: Row(
          children: [
            horizontalSpace(activityList.length > 1 &&
                    activity == activityList[activityList.lastIndex!]
                ? 24
                : 20),
            treeToJoinAddedItemsSubtree(activity, index),
          ],
        ),
      );

  Widget treeToJoinAddedItemsSubtree(ActivitySingle activity, int index) =>
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalDivider(width: 2, height: 39, thickness: 4),
            Container(
              width: 56,
              height: 5,
              color: Colors.red,
            ),
            (() {
              if (index == 0) {
                if (activity.addedReview.isNotEmpty ||
                    activity.addedTickets.isNotEmpty) {
                  return Expanded(
                    child: verticalDivider(width: 2, height: 50, thickness: 4),
                  );
                }
              } else if (index == 1) {
                if (activity.addedTickets.isNotEmpty) {
                  return Expanded(
                    child: verticalDivider(width: 2, height: 50, thickness: 4),
                  );
                }
              } else {
                return Container();
              }
              return Container();
            }())
          ],
        ),
      );

  Widget addedItemsSubtree(List<String> list, int index) => Expanded(
      flex: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addedItemsAndTitlesSubtree(index),
          ...movieTitleSubtreeList(list, index),
        ],
      ));

  Widget addedItemsAndTitlesSubtree(int index) => SizedBox(
        width: 200,
        height: 80,
        child: Stack(
          children: [
            angledBarForAddedItemTitle(),
            addedItemTitles(index),
          ],
        ),
      );

  List movieTitleSubtreeList(List<String> list, int index) =>
      List.generate(list.length, (index) => movieTitleSubtree(list, index))
          .toList();

  Widget angledBarForAddedItemTitle() => Positioned(
        top: 62,
        left: -16,
        child: Transform.rotate(
          angle: (50 / 180 * pi),
          child: divider(width: 80, thickness: 3),
        ),
      );

  Widget addedItemTitles(int index) => Positioned(
      top: 40,
      left: 40,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(addedTitles[index]),
          )));

  Widget movieTitleSubtree(List<String> list, int index) => Expanded(
        child: Row(
          children: [
            SizedBox(
              width: 82,
              child: Column(
                children: [
                  angledBarForMovieTitle(index),
                  movieTitleBarSeperator(list, index),
                ],
              ),
            ),
            movieTitle(list, index),
          ],
        ),
      );

  Widget angledBarForMovieTitle(int index) => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: (() {
              if (index == 0) {
                return 30.toDouble();
              } else {
                return 38.toDouble();
              }
            }())),
            child: Transform(
              transform: (() {
                if (index == 0) {
                  return Matrix4.skewX(40 / 180 * pi);
                } else {
                  return Matrix4.skewX(0 / 180 * pi);
                }
              }()),
              child: Container(
                width: 40,
                height: 10,
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.red, width: 5),
                        bottom: BorderSide(color: Colors.red, width: 5))),
              ),
            ),
          )
        ],
      );

  Widget movieTitleBarSeperator(List<String> list, int index) => Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: (() {
              return 38.toDouble();
            }())),
            child: Container(
              width: 40,
              height: 10,
              decoration: BoxDecoration(
                  border: Border(
                left: BorderSide(
                    color: (() {
                      if (index == list.lastIndex) {
                        return color;
                      } else {
                        return Colors.red;
                      }
                    }()),
                    width: 5),
              )),
            ),
          )
        ],
      );

  Widget movieTitle(List<String> list, int index) => Expanded(
        child: Text(
          list[index],
          overflow: TextOverflow.ellipsis,
        ),
      );
}
