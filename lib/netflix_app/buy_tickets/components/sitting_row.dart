import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/buy_tickets_cubit.dart';
import '../presentation/buy_tickets_page.dart';

class SittingRow extends StatelessWidget {
  final List<List> sittingStatus;
  final int colIndex;
  final int rowIndex;
  final int addIndex;
  const SittingRow(
      {super.key,
      required this.sittingStatus,
      required this.colIndex,
      required this.rowIndex,
      required this.addIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          sittingStatus.isNotEmpty &&
                  sittingStatus
                      .where((element) =>
                          element[0] == colIndex + addIndex &&
                          element[1] == rowIndex)
                      .isNotEmpty
              ? context
                  .read<BuyTicketsCubit>()
                  .removeSitting([colIndex + addIndex, rowIndex])
              : context
                  .read<BuyTicketsCubit>()
                  .addSitting([colIndex + addIndex, rowIndex]);
        },
        child: Container(
          width: width.toDouble(),
          height: height.toDouble(),
          decoration: BoxDecoration(
              color: (() {
            if (sittingStatus
                .where((element) =>
                    element[0] == colIndex + addIndex && element[1] == rowIndex)
                .isNotEmpty) {
              return Colors.red;
            } else {
              return Colors.blue;
            }
          }())),
        ),
      ),
    );
  }
}
