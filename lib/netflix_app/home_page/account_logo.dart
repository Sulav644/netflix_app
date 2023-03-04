import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/navbar.dart';

class AccountLogo extends StatelessWidget {
  const AccountLogo({super.key});

  @override
  Widget build(BuildContext context) {
    void toggleDialogState() {
      context.read<ShowProfileCubit>().toggleShowProfile(true);
      context.read<ShowColorDialogCubit>().toggleShowColorDialog(false);
      context.read<ShowNavigationCubit>().toggleShowNavigation(false);
    }

    return GestureDetector(
        onTap: () {
          toggleDialogState();
        },
        child: const CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ));
  }
}
