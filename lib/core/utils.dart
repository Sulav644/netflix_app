import 'package:flutter/material.dart';

double getWidth(BuildContext context) => MediaQuery.of(context).size.width;
double getHeight(BuildContext context) => MediaQuery.of(context).size.height;
double getWidthRatio(BuildContext context, double ratio) =>
    MediaQuery.of(context).size.width * ratio;
double getHeightRatio(BuildContext context, double ratio) =>
    MediaQuery.of(context).size.height * ratio;

SizedBox verticalSpace(double height) => SizedBox(
      height: height,
    );
SizedBox horizontalSpace(double width) => SizedBox(
      width: width,
    );
Widget verticalDivider(
        {required double width,
        double? height,
        required double thickness,
        Color? color}) =>
    SizedBox(
      height: height,
      child: VerticalDivider(
        width: width,
        thickness: 3,
        color: color ?? Colors.red,
      ),
    );
Widget divider(
        {required double width,
        double? height,
        required double thickness,
        Color? color}) =>
    SizedBox(
      width: width,
      child: Divider(
        height: height,
        thickness: thickness,
        color: color ?? Colors.red,
      ),
    );

extension StringExtension on String {
  String capitalizeAndTrim() {
    final list = split(" ").map((e) {
      return (() {
        if (e.contains('^')) {
          return e.toUpperCase();
        } else if (e.contains('*')) {
          return e.toLowerCase();
        } else {
          return e[0].toUpperCase().toString() + e.substring(1);
        }
      }());
    });
    return list.toString().replaceAll(RegExp(r'[(,^@*)]'), "");
  }
}

extension StringExtensionOneWord on String {
  String capitalizeAndTrimOneWord() {
    final list = split(" ").map((e) {
      return (() {
        if (e.toString() == '') {
          return '';
        } else if (e.contains('^')) {
          return e.toUpperCase();
        } else if (e.contains('%')) {
          return e[0].toUpperCase().toString() + e.substring(1);
        } else {
          return e.toLowerCase();
        }
      }());
    });
    return list.toString().replaceAll(RegExp(r'[(,^@*%)]'), "");
  }
}

extension StringExtensionCapitalize on String {
  String capitalize() {
    final string = contains('^')
        ? toUpperCase()
        : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    // print('string $string');
    return string.replaceAll(RegExp(r'[(,^@*%)]'), "");
  }
}
