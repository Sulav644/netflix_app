import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/navbar.dart';
import 'netflix_page.dart';

class NavigationIcon extends StatefulWidget {
  final bool navigationStatus;
  final DoubleValueSetter doubleValueSetterYAxis;
  final DoubleValueSetter doubleValueSetterXAxis;
  const NavigationIcon(
      {super.key,
      required this.navigationStatus,
      required this.doubleValueSetterYAxis,
      required this.doubleValueSetterXAxis});

  @override
  State<NavigationIcon> createState() => _NavigationIconState();
}

class _NavigationIconState extends State<NavigationIcon> {
  late GlobalKey keyForNavigation;
  @override
  void initState() {
    super.initState();
    keyForNavigation = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    Offset getCoordinates() {
      RenderBox box =
          keyForNavigation.currentContext?.findRenderObject() as RenderBox;
      Offset offset = box.localToGlobal(Offset.zero);
      return offset;
    }

    void toggleDialogState() {
      context.read<ShowColorDialogCubit>().toggleShowColorDialog(false);
    }

    return GestureDetector(
        onTap: () {
          Offset offset = getCoordinates();

          widget.doubleValueSetterXAxis(offset.dx);
          widget.doubleValueSetterYAxis(offset.dy);
          context
              .read<InitialOffsetForNavigationDialogCubit>()
              .setOffset([offset.dx, offset.dy]);
          if (widget.navigationStatus) {
            context.read<ShowNavigationCubit>().toggleShowNavigation(false);
          } else {
            context.read<ShowNavigationCubit>().toggleShowNavigation(true);
          }
          toggleDialogState();
        },
        child: CircleAvatar(
          key: keyForNavigation,
          backgroundColor: Colors.transparent,
          radius: 15,
          child: const Icon(
            Icons.shuffle,
          ),
        ));
  }
}
