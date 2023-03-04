import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_app/core/utils.dart';
import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';

typedef IntValueSetter = void Function(int value);
typedef StringValueSetter = void Function(String value);
typedef BoolValueSetter = void Function(bool value);

class RangeSelectorTextFormField extends StatelessWidget {
  const RangeSelectorTextFormField({
    super.key,
    required this.labelText,
    required this.intValueSetter,
    required this.textInputAction,
    required this.focusNode,
  });
  final String labelText;
  final IntValueSetter intValueSetter;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: focusNode.hasFocus
                  ? const Color.fromARGB(255, 128, 127, 127)
                  : const Color.fromARGB(255, 109, 108, 108),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    labelText: labelText,
                    labelStyle: TextStyle(
                        color: focusNode.hasFocus
                            ? const Color.fromARGB(255, 207, 207, 207)
                            : const Color.fromARGB(255, 170, 169, 169)),
                    fillColor: focusNode.hasFocus
                        ? const Color.fromARGB(255, 128, 127, 127)
                        : const Color.fromARGB(255, 109, 108, 108),
                    filled: true),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: true),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly
                ],
                cursorHeight: 35,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                textInputAction: textInputAction,
                focusNode: focusNode,

                // validator: (value) {
                //   if (value == null || int.tryParse(value) == null) {
                //     return 'Must be an integer';
                //   } else {
                //     return null;
                //   }
                // },
                onChanged: (newValue) =>
                    intValueSetter(newValue == '' ? 0 : int.parse(newValue)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FirstNameTextFormField extends StatelessWidget {
  const FirstNameTextFormField({
    super.key,
    required this.labelText,
    required this.stringValueSetter,
    required this.textInputAction,
    required this.focusNode,
    required this.textCapitalization,
  });
  final String labelText;
  final StringValueSetter stringValueSetter;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: focusNode.hasFocus
                  ? const Color.fromARGB(255, 128, 127, 127)
                  : const Color.fromARGB(255, 109, 108, 108),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: focusNode.hasFocus
                          ? const Color.fromARGB(255, 207, 207, 207)
                          : const Color.fromARGB(255, 170, 169, 169)),
                  fillColor: focusNode.hasFocus
                      ? const Color.fromARGB(255, 128, 127, 127)
                      : const Color.fromARGB(255, 109, 108, 108),
                  filled: true,
                ),
                textCapitalization: textCapitalization,
                cursorHeight: 35,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                textInputAction: textInputAction,
                focusNode: focusNode,

                // validator: (value) {
                //   if (value == null || int.tryParse(value) == null) {
                //     return 'Must be an integer';
                //   } else {
                //     return null;
                //   }
                // },
                onChanged: (newValue) =>
                    stringValueSetter(newValue == '' ? '' : newValue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// class LastNameTextFormField extends StatelessWidget {
//   LastNameTextFormField({
//     super.key,
//     required this.labelText,
//     required this.stringValueSetter,
//     required this.textInputAction,
//     required this.focusNode,
//   });
//   final String labelText;
//   final StringValueSetter stringValueSetter;
//   final TextInputAction textInputAction;
//   final FocusNode focusNode;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Color.fromARGB(255, 26, 25, 25))),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Color.fromARGB(255, 26, 25, 25))),
//           labelText: labelText,
//           labelStyle: TextStyle(
//               color: focusNode.hasFocus
//                   ? Color.fromARGB(255, 207, 207, 207)
//                   : Color.fromARGB(255, 170, 169, 169)),
//           fillColor: focusNode.hasFocus
//               ? Color.fromARGB(255, 128, 127, 127)
//               : Colors.red,
//           filled: true),
//       keyboardType: TextInputType.emailAddress,
//       textInputAction: textInputAction,
//       focusNode: focusNode,

//       // validator: (value) {
//       //   if (value == null || int.tryParse(value) == null) {
//       //     return 'Must be an integer';
//       //   } else {
//       //     return null;
//       //   }
//       // },
//       onChanged: (newValue) =>
//           stringValueSetter(newValue == '' || newValue == null ? '' : newValue),
//     );
//   }
// }

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    super.key,
    required this.labelText,
    required this.stringValueSetter,
    required this.textInputAction,
    required this.focusNode,
  });
  final String labelText;
  final StringValueSetter stringValueSetter;
  final TextInputAction textInputAction;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: focusNode.hasFocus
                  ? const Color.fromARGB(255, 128, 127, 127)
                  : const Color.fromARGB(255, 109, 108, 108),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    labelText: labelText,
                    labelStyle: TextStyle(
                        color: focusNode.hasFocus
                            ? const Color.fromARGB(255, 207, 207, 207)
                            : const Color.fromARGB(255, 170, 169, 169)),
                    fillColor: focusNode.hasFocus
                        ? const Color.fromARGB(255, 128, 127, 127)
                        : const Color.fromARGB(255, 109, 108, 108),
                    filled: true),
                cursorHeight: 35,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                textInputAction: textInputAction,
                focusNode: focusNode,

                // validator: (value) {
                //   if (value == null || int.tryParse(value) == null) {
                //     return 'Must be an integer';
                //   } else {
                //     return null;
                //   }
                // },
                onChanged: (newValue) =>
                    stringValueSetter(newValue == '' ? '' : newValue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.labelText,
    required this.stringValueSetter,
    required this.textInputAction,
    required this.focusNode,
    required this.onTap,
    required this.showPassword,
    required this.showPasswordToggler,
    required this.boolValueSetter,
  });
  final String labelText;
  final StringValueSetter stringValueSetter;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final VoidCallback onTap;
  final bool showPassword;
  final bool showPasswordToggler;
  final BoolValueSetter boolValueSetter;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: focusNode.hasFocus
                  ? const Color.fromARGB(255, 128, 127, 127)
                  : const Color.fromARGB(255, 109, 108, 108),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: focusNode.hasFocus
                          ? const Color.fromARGB(255, 207, 207, 207)
                          : const Color.fromARGB(255, 170, 169, 169)),
                  fillColor: focusNode.hasFocus
                      ? const Color.fromARGB(255, 128, 127, 127)
                      : const Color.fromARGB(255, 109, 108, 108),
                  filled: true,
                ),

                cursorHeight: 35,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                obscureText: !showPassword,
                textInputAction: textInputAction,

                focusNode: focusNode,

                // validator: (value) {
                //   if (value == null || int.tryParse(value) == null) {
                //     return 'Must be an integer';
                //   } else {
                //     return null;
                //   }
                // },
                onChanged: (newValue) {
                  boolValueSetter(newValue.isNotEmpty ? true : false);
                  stringValueSetter(newValue == '' ? '' : newValue);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          width: getWidth(context),
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (showPasswordToggler)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: defaultTextStyle(
                    const Color.fromARGB(255, 51, 51, 51),
                    GestureDetector(
                        onTap: () => onTap(),
                        child: showPassword
                            ? Text('hide^'.capitalizeAndTrim())
                            : Text('show^'.capitalizeAndTrim())),
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
