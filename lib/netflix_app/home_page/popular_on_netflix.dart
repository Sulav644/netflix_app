import 'package:flutter/material.dart';

import 'components/popular_on_netflix_widgets.dart';

class PopularOnNetFlix extends StatelessWidget {
  final List images;
  final String title;
  final VoidCallback onClick;
  final bool isProfileDialogOpened;
  final bool isColorDialogOpened;
  final bool isNavigationDialogOpened;
  const PopularOnNetFlix(
      {super.key,
      required this.images,
      required this.title,
      required this.onClick,
      required this.isProfileDialogOpened,
      required this.isColorDialogOpened,
      required this.isNavigationDialogOpened});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PopularOnNetflixWidgets().seriesTitle(
          title,
        ),
        Row(
            children: images
                .map((e) => Padding(
                      padding: PopularOnNetflixWidgets().edgePadding(e, images),
                      child: GestureDetector(
                        onTap: () async {
                          if (isColorDialogOpened ||
                              isProfileDialogOpened ||
                              isNavigationDialogOpened) {
                            onClick();
                          } else {
                            PopularOnNetflixWidgets()
                                .navigateToContentDetailPage(context, e);
                          }
                        },
                        child: PopularOnNetflixWidgets()
                            .gridSeriesImage(e, context),
                      ),
                    ))
                .toList()),
      ],
    );
  }
}
