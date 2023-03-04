import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../favourite_list/netflix_favorite_list.dart';
import '../domain/netflix_data.dart';

class MovieImage extends StatelessWidget {
  final MovieDetail e;
  final VoidCallback onClick;
  const MovieImage({super.key, required this.e, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Image.network(
        e.imgUrl!,
        errorBuilder: (context, error, stackTrace) {
          return defaultTextStyle(
              Colors.white, const Text('something went wrong'));
        },
        width: getWidth(context),
        height: getHeightRatio(context, 0.6),
        fit: BoxFit.cover,
      ),
    );
  }
}
