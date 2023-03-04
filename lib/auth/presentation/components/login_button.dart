import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/core/utils.dart';

import '../../application/response_repos_cubit.dart';
import '../../infrastructure/response_repos_notifier.dart';
import '../../infrastructure/user_details.dart';
import '../login_form.dart';
import '../login_page.dart';

class LoginButton extends StatelessWidget {
  final int phone;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final LoginVerifyCubit loginStatus;
  final DetailsCubit detailStatus;
  final int statusCode;
  final ResponseReposState responseReposState;
  final RangeSelectorPage rangeSelectorPage = const RangeSelectorPage();
  const LoginButton({
    super.key,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.loginStatus,
    required this.detailStatus,
    required this.statusCode,
    required this.responseReposState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.red)))),
          onPressed: () {
            if (firstName == '') {
              loginStatus.setFirstName(const Validation.empty());
            } else if (firstName != '' && firstName.length < 3) {
              loginStatus.setFirstName(const Validation.notMatchedPattern());
            } else {
              loginStatus.setFirstName(const Validation.valid());
              detailStatus.addFirstName(firstName);
            }

            if (lastName == '') {
              loginStatus.setLastName(const Validation.empty());
            } else if (lastName != '' && lastName.length < 3) {
              loginStatus.setLastName(const Validation.notMatchedPattern());
            } else {
              loginStatus.setLastName(const Validation.valid());
              detailStatus.addLastName(lastName);
            }

            if (phone == 0) {
              loginStatus.setPhoneNumber(const Validation.empty());
            } else if (phone != 0 && phone.toString().length < 10) {
              loginStatus.setPhoneNumber(const Validation.notMatchedPattern());
            } else {
              loginStatus.setPhoneNumber(const Validation.valid());
              detailStatus.addPhone(phone);
            }

            if (email == '') {
              loginStatus.setEmail(const Validation.empty());
            } else if (email != '' && !isEmail(email)) {
              loginStatus.setEmail(const Validation.notMatchedPattern());
            } else {
              loginStatus.setEmail(const Validation.valid());
              detailStatus.addEmail(email);
            }

            if (password == '') {
              loginStatus.setPassword(const Validation.empty());
            } else if (password != '' && !isPassword(password)) {
              loginStatus.setPassword(const Validation.notMatchedPattern());
            } else {
              loginStatus.setPassword(const Validation.valid());
              detailStatus.addPassword(password);
            }

            final isVerified = context.read<DetailsCubit>().isVerified();
            if (isVerified) {
              context.read<ResponseReposNotifier>().getResponseReposPage();
            }
          },
          child: responseReposState.map(
              initial: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              loadInProgress: (_) => const CircularProgressIndicator(),
              loadSuccess: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
              loadFailure: (_) => Text(
                    'login'.capitalize(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ))),
    );
  }
}
