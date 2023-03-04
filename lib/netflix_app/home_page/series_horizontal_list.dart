import 'package:flutter/material.dart';
import 'package:netflix_app/netflix_app/home_page/popular_on_netflix.dart';

import '../../core/utils.dart';
import '../domain/netflix_data.dart';

class SeriesHorizontalList extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final List<MovieDetail> seriesList;
  final bool isProfileDialogOpened;
  final bool isColorDialogOpened;
  final bool isNavigationDialogOpened;
  const SeriesHorizontalList(
      {super.key,
      required this.onClick,
      required this.title,
      required this.seriesList,
      required this.isProfileDialogOpened,
      required this.isColorDialogOpened,
      required this.isNavigationDialogOpened});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(context),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: PopularOnNetFlix(
            isColorDialogOpened: isColorDialogOpened,
            isNavigationDialogOpened: isNavigationDialogOpened,
            isProfileDialogOpened: isProfileDialogOpened,
            onClick: onClick,
            title: title,
            images: seriesList),
      ),
    );
  }
}
