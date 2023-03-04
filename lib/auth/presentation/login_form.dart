import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/auth/presentation/login_page.dart';
import 'package:netflix_app/auth/presentation/components/login_text_form_field.dart';

import 'package:simple_animations/timeline_tween/timeline_tween.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/utils.dart';
import '../infrastructure/user_details.dart';
import 'components/login_form_components.dart';

extension StringExtensionCapitalizeForLogin on String {
  String capitalizeLogins() {
    final list = split(" ").map((e) {
      return (() {
        if (e.toString() == '') {
          return '';
        } else if (e.contains('^')) {
          return e[0].toUpperCase().toString() + e.substring(1);
        } else {
          return e.toLowerCase();
        }
      }());
    }).toList();
    final string = list.toString();
    final filteredList = string.substring(1, string.lastIndexOf(']'));
    return filteredList.replaceAll(RegExp(r'[,^]'), "");
  }
}

const dynamic emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
const dynamic passwordPattern =
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#/$&*~]).{8,}$';
bool isEmail(String phoneOrMail) {
  if (RegExp(emailPattern.toString()).hasMatch(phoneOrMail)) {
    return true;
  } else {
    return false;
  }
}

bool isPassword(String password) {
  if (RegExp(passwordPattern.toString()).hasMatch(password)) {
    return true;
  } else {
    return false;
  }
}

enum AnimProps { top, opacity, height }

Duration duration = 1000.milliseconds;
Duration begin = 0.milliseconds;
Duration end = 1000.milliseconds;
Curve curve = Curves.ease;
Tween tween = Tween(begin: 20.0, end: 60.0);

class RangeSelectorForm extends StatefulWidget {
  const RangeSelectorForm({
    super.key,
    required this.formKey,
    required this.minValueSetter,
    required this.emailValueSetter,
    required this.passwordValueSetter,
    required this.firstValueSetter,
    required this.lastValueSetter,
    required this.focusNodeFirstName,
    required this.focusNodeLastName,
    required this.focusNodePhoneNumber,
    required this.focusNodeEmail,
    required this.focusNodePassword,
  });
  final GlobalKey<FormState> formKey;
  final IntValueSetter minValueSetter;
  final StringValueSetter firstValueSetter;
  final StringValueSetter lastValueSetter;
  final StringValueSetter emailValueSetter;
  final StringValueSetter passwordValueSetter;
  final FocusNode focusNodeFirstName,
      focusNodeLastName,
      focusNodePhoneNumber,
      focusNodeEmail,
      focusNodePassword;

  @override
  State<RangeSelectorForm> createState() => RangeSelectorFormState();
}

class RangeSelectorFormState extends State<RangeSelectorForm>
    with TickerProviderStateMixin {
  late AnimationController firstNameController,
      nameController,
      firstNameNotMatchController,
      phoneNumberController,
      phoneNumberEmptyController,
      phoneNumberNotMatchController,
      emailController,
      emailEmptyController,
      emailNotMatchController,
      passwordController,
      passwordEmptyController,
      passwordNotMatchController;
  late Animation<TimelineValue<AnimProps>> firstNameAnimation,
      firstNameNotMatchAnimation,
      nameAnimation,
      phoneNumberAnimation,
      phoneNumberEmptyAnimation,
      phoneNumberNotMatchAnimation,
      emailAnimation,
      emailEmptyAnimation,
      emailNotMatchAnimation,
      passwordAnimation,
      passwordEmptyAnimation,
      passwordNotMatchAnimation;
  Tween tween = Tween(begin: 20.0, end: 60.0);
  bool showPassword = false;
  bool showPasswordToggler = false;

  @override
  void initState() {
    super.initState();

    nameController = AnimationController(duration: duration, vsync: this);

    phoneNumberController =
        AnimationController(duration: duration, vsync: this);
    emailController = AnimationController(duration: duration, vsync: this);
    passwordController = AnimationController(duration: duration, vsync: this);

    firstNameController = nameController;
    firstNameNotMatchController = nameController;

    phoneNumberEmptyController = phoneNumberController;
    phoneNumberNotMatchController = phoneNumberController;

    emailEmptyController = emailController;
    emailNotMatchController = emailController;

    passwordEmptyController = passwordController;
    passwordNotMatchController = passwordController;

    nameAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(AnimProps.top, tween: Tween(begin: 20.0, end: 80.0))
        .animate(AnimProps.height, tween: Tween(begin: 60.0, end: 110.0))
        .parent
        .animatedBy(nameController);

    phoneNumberAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(AnimProps.top, tween: Tween(begin: 20.0, end: 80.0))
        .animate(AnimProps.height, tween: Tween(begin: 60.0, end: 110.0))
        .parent
        .animatedBy(phoneNumberController);
    emailAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(AnimProps.top, tween: Tween(begin: 20.0, end: 80.0))
        .animate(AnimProps.height, tween: Tween(begin: 60.0, end: 110.0))
        .parent
        .animatedBy(emailController);
    passwordAnimation = TimelineTween<AnimProps>()
        // opacity
        .addScene(begin: begin, end: end, curve: curve)
        .animate(AnimProps.top, tween: Tween(begin: 20.0, end: 80.0))
        .animate(AnimProps.height, tween: Tween(begin: 60.0, end: 110.0))
        .parent
        .animatedBy(passwordController);

    firstNameAnimation = nameAnimation;
    firstNameNotMatchAnimation = nameAnimation;

    phoneNumberEmptyAnimation = phoneNumberAnimation;
    phoneNumberNotMatchAnimation = phoneNumberAnimation;

    emailEmptyAnimation = emailAnimation;
    emailNotMatchAnimation = emailAnimation;

    passwordEmptyAnimation = passwordAnimation;
    passwordNotMatchAnimation = passwordAnimation;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginVerifyCubit>().state;
    if (loginState.firstName == const Validation.empty()) {
      firstNameController.forward();
    } else if (loginState.firstName == const Validation.notMatchedPattern()) {
      firstNameNotMatchController.forward();
    } else {
      firstNameController.reverse();
      firstNameNotMatchController.reverse();
    }

    if (loginState.phoneNumber == const Validation.empty()) {
      phoneNumberEmptyController.forward();
    } else if (loginState.phoneNumber == const Validation.notMatchedPattern()) {
      phoneNumberNotMatchController.forward();
    } else {
      phoneNumberEmptyController.reverse();
      phoneNumberNotMatchController.reverse();
    }

    if (loginState.email == const Validation.empty()) {
      emailEmptyController.forward();
    } else if (loginState.email == const Validation.notMatchedPattern()) {
      emailNotMatchController.forward();
    } else {
      emailEmptyController.reverse();
      emailNotMatchController.reverse();
    }

    if (loginState.password == const Validation.empty()) {
      passwordEmptyController.forward();
    } else if (loginState.password == const Validation.notMatchedPattern()) {
      passwordNotMatchController.forward();
    } else {
      passwordEmptyController.reverse();
      passwordNotMatchController.reverse();
    }
    double space = 20;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            LoginFormComponents().animationBuilder(
                field: loginState.firstName,
                firstStatus: const Validation.empty(),
                secondStatus: const Validation.notMatchedPattern(),
                firstController: firstNameController,
                secondController: firstNameNotMatchController,
                firstAnimation: firstNameAnimation,
                secondAnimation: firstNameNotMatchAnimation,
                firstTitle: 'full^ name^ is required*'.capitalizeLogins(),
                secondTitle: 'full^ name^ not match'.capitalizeLogins()),
            FirstNameTextFormField(
              labelText: 'full^ name^'.capitalizeLogins(),
              textCapitalization: TextCapitalization.words,
              stringValueSetter: widget.firstValueSetter,
              textInputAction: TextInputAction.next,
              focusNode: widget.focusNodeFirstName,
            ),
          ],
        ),

        // Stack(
        //   children: [
        //     LoginFormComponents().animationBuilder(
        //         field: loginState.lastName,
        //         firstStatus: Validation.empty(),
        //         secondStatus: Validation.notMatchedPattern(),
        //         firstController: lastNameEmptyController,
        //         secondController: lastNameNotMatchController,
        //         firstAnimation: lastNameEmptyAnimation,
        //         secondAnimation: lastNameNotMatchAnimation,
        //         firstTitle: 'LastName is required*',
        //         secondTitle: 'LastName not match'),
        //     LastNameTextFormField(
        //       labelText: 'LastName',
        //       stringValueSetter: widget.lastValueSetter,
        //       textInputAction: TextInputAction.next,
        //       focusNode: widget.focusNodeLastName,
        //     ),
        //   ],
        // ),
        verticalSpace(space),
        Stack(
          children: [
            LoginFormComponents().animationBuilder(
                field: loginState.phoneNumber,
                firstStatus: const Validation.empty(),
                secondStatus: const Validation.notMatchedPattern(),
                firstController: phoneNumberEmptyController,
                secondController: phoneNumberNotMatchController,
                firstAnimation: phoneNumberEmptyAnimation,
                secondAnimation: phoneNumberNotMatchAnimation,
                firstTitle: 'phone^ number^ is required*'.capitalizeLogins(),
                secondTitle:
                    'phone^ number^ is less than 10 chars'.capitalizeLogins()),
            RangeSelectorTextFormField(
              labelText: 'phone^ number^'.capitalizeLogins(),
              intValueSetter: widget.minValueSetter,
              textInputAction: TextInputAction.next,
              focusNode: widget.focusNodePhoneNumber,
            ),
          ],
        ),
        verticalSpace(space),
        Stack(
          children: [
            LoginFormComponents().animationBuilder(
                field: loginState.email,
                firstStatus: const Validation.empty(),
                secondStatus: const Validation.notMatchedPattern(),
                firstController: emailEmptyController,
                secondController: emailNotMatchController,
                firstAnimation: emailEmptyAnimation,
                secondAnimation: emailNotMatchAnimation,
                firstTitle: 'email^ is required*'.capitalizeLogins(),
                secondTitle: 'email^ not match'.capitalizeLogins()),
            EmailTextFormField(
              labelText: 'email^'.capitalizeLogins(),
              stringValueSetter: widget.emailValueSetter,
              textInputAction: TextInputAction.next,
              focusNode: widget.focusNodeEmail,
            ),
          ],
        ),
        verticalSpace(space),
        Stack(
          children: [
            LoginFormComponents().animationBuilder(
                field: loginState.password,
                firstStatus: const Validation.empty(),
                secondStatus: const Validation.notMatchedPattern(),
                firstController: passwordEmptyController,
                secondController: passwordNotMatchController,
                firstAnimation: passwordEmptyAnimation,
                secondAnimation: passwordNotMatchAnimation,
                firstTitle: 'password^ is required*'.capitalizeLogins(),
                secondTitle:
                    'password^ should match (@*\$%#)'.capitalizeLogins()),
            PasswordTextFormField(
              labelText: 'password'.capitalizeLogins(),
              onTap: () => setState(() {
                showPassword = !showPassword;
              }),
              boolValueSetter: (value) => setState(() {
                showPasswordToggler = value;
              }),
              showPassword: showPassword,
              showPasswordToggler: showPasswordToggler,
              stringValueSetter: widget.passwordValueSetter,
              textInputAction: TextInputAction.done,
              focusNode: widget.focusNodePassword,
            ),
          ],
        ),
      ],
    );
  }
}
