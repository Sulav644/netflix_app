import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:netflix_app/netflix_app/activity/presentation/components.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:netflix_app/netflix_app/home_page/components/navbar.dart';

import '../../../core/utils.dart';
import '../domain/activity_log_list_cubit.dart';

final addedTitles = ["Added Movies", "Added Reviews", "Added Tickets"];

class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({
    super.key,
  });

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final activityList = context.watch<ActivityLogListCubit>().state;
    final backgroundColor = context.watch<ThemeColorCubit>().state;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                if (activityList.isEmpty)
                  SizedBox(
                    width: getWidth(context),
                    height: getHeight(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: getWidthRatio(context, 0.8),
                          child: defaultTextStyle(
                            Colors.white,
                            const Text(
                                'No activities done yet\nAll the movie titles which are added to favorite, the title of movies whose reviews are created and the title of movies whose tickets are bought appear here'),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (activityList.isNotEmpty) verticalSpace(80),
                if (activityList.isNotEmpty)
                  ...activityList
                      .map((e) => defaultTextStyle(
                            Colors.white,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(DateFormat.yMMMEd()
                                            .format(DateTime.parse(
                                                e.dateTime.toString()))
                                            .toString()),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(DateFormat.Hms()
                                            .format(DateTime.parse(
                                                e.dateTime.toString()))
                                            .toString()),
                                      ),
                                    ),
                                  ),
                                  if (e.addedMovie.isNotEmpty)
                                    ActivityLogWidgets(color: backgroundColor)
                                        .buildItems(
                                            0, e.addedMovie, activityList, e),
                                  if (e.addedReview.isNotEmpty)
                                    ActivityLogWidgets(color: backgroundColor)
                                        .buildItems(
                                            1, e.addedReview, activityList, e),
                                  if (e.addedTickets.isNotEmpty)
                                    ActivityLogWidgets(color: backgroundColor)
                                        .buildItems(
                                            2, e.addedTickets, activityList, e),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                verticalSpace(20)
              ],
            ),
            NavbarPage(
                navigationState: StateForNavigation.comingFromActivityLog,
                offsetXForColor: 200,
                offsetYForColor: 0,
                yOffsetForNavigation: getHeightRatio(context, 0.02),
                xOffsetForNavigation: getWidthRatio(context, 0.65)),
          ],
        ),
      ),
    );
  }
}
