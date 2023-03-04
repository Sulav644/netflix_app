import 'package:flutter/material.dart';

class ColorFilterLogoWidgets {
  Widget filter() => Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        child: SizedBox(
          width: 20,
          height: 20,
          child: Stack(
            children: [
              Positioned(
                top: 6,
                child: filterBar(),
              ),
              Positioned(
                top: 4,
                child: filterBarCircle(),
              ),
              Positioned(
                top: 12,
                child: filterBar(),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: filterBarCircle(),
              ),
              Positioned(
                top: 18,
                child: filterBar(),
              ),
              Positioned(
                top: 16,
                left: 6,
                child: filterBarCircle(),
              )
            ],
          ),
        ),
      );
  Widget filterBar() => Container(
        width: 20,
        height: 2,
        color: Colors.white,
      );
  Widget filterBarCircle() => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(100)),
      );
}
