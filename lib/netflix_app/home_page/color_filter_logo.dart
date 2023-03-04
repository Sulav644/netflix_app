import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'components/navbar.dart';
import 'netflix_page.dart';

class ColorFilterLogo extends StatefulWidget {
  final VoidCallback onTap;
  final DoubleValueSetter doubleValueSetter;
  final bool isProfileDialogOpened;
  final bool isColorDialogOpened;
  final bool isNavigationDialogOpened;
  const ColorFilterLogo(
      {Key? key,
      required this.onTap,
      required this.doubleValueSetter,
      required this.isProfileDialogOpened,
      required this.isColorDialogOpened,
      required this.isNavigationDialogOpened})
      : super(key: key);

  @override
  State<ColorFilterLogo> createState() => ColorFilterLogoState();
}

class ColorFilterLogoState extends State<ColorFilterLogo> {
  late GlobalKey keyForColorToggle;
  final String assetName = "assets/icons/filter.svg";

  @override
  void initState() {
    super.initState();
    keyForColorToggle = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      assetName,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
    final colorDialogStatus = context.watch<ShowColorDialogCubit>().state;

    Offset getColorCoordinates() {
      RenderBox box =
          keyForColorToggle.currentContext?.findRenderObject() as RenderBox;
      Offset offset = box.localToGlobal(Offset.zero);
      return offset;
    }

    return GestureDetector(
        onTap: () {
          if (widget.isNavigationDialogOpened || widget.isProfileDialogOpened) {
            widget.onTap();
          } else {
            Offset offset = getColorCoordinates();

            if (colorDialogStatus) {
              context.read<ShowColorDialogCubit>().toggleShowColorDialog(false);
            } else {
              context.read<ShowColorDialogCubit>().toggleShowColorDialog(true);
            }
            widget.doubleValueSetter(offset.dx);
            debugPrint('offset ${offset.dx}');
          }
        },
        child: CircleAvatar(
          key: keyForColorToggle,
          backgroundColor: Colors.transparent,
          child: svg,
        ));
  }
}
