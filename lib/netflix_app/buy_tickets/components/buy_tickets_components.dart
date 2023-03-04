import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/netflix_app/buy_tickets/components/press_button.dart';
import 'package:netflix_app/netflix_app/buy_tickets/components/sitting_row.dart';

import '../../../core/utils.dart';
import '../../favourite_list/netflix_favorite_list.dart';
import '../../activity/domain/activity_freezed.dart';
import '../../activity/domain/activity_log_cubit.dart';
import '../../activity/domain/activity_log_list_cubit.dart';
import '../domain/buy_tickets_cubit.dart';
import '../presentation/buy_tickets_page.dart';

var rows = 5;
var columns = 4;

var rowOne = 5;
var columnOne = 1;

var rowTwo = 6;
var columnTwo = 1;

var rowFour = 4;
var columnFour = 2;
final price = [10, 20, 30];
const width = 42;
const height = 20;

class BuyTicketsComponents {
  Widget rowForSittingSectionAndColoredLine(
          List<List<int>> sittingStatus, List<Widget> children, int index) =>
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            sittingSection(index),
            Padding(
              padding: EdgeInsets.only(
                  right: (() {
                if (index == 0) {
                  return 0.0;
                } else if (index == 1) {
                  return 12.0;
                } else {
                  return 44.0;
                }
              }())),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ],
        ),
      );

  List bookedSitting() => List.generate(
      columns,
      (colIndex) => Row(
            children: List.generate(
                rows,
                (rowIndex) => Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width.toDouble(),
                          height: height.toDouble(),
                          decoration: BoxDecoration(
                              color: (() {
                            return Colors.red;
                          }())),
                        ),
                      ),
                    )).toList(),
          )).toList();

  List sittingList(
          {required int columnLength,
          required int rowLength,
          required List<List<int>> sittingStatus,
          required int addIndex}) =>
      List.generate(
          columnLength,
          (colIndex) => Row(
                children: List.generate(
                    rowLength,
                    (rowIndex) => SittingRow(
                          sittingStatus: sittingStatus,
                          colIndex: colIndex,
                          rowIndex: rowIndex,
                          addIndex: addIndex,
                        )).toList(),
              )).toList();

  Widget sittingSection(int index) => Expanded(
        flex: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(8),
            Expanded(
              child: verticalDivider(
                  width: 4,
                  height: 40,
                  thickness: 2,
                  color: (() {
                    if (index == 0) {
                      return Colors.red;
                    } else if (index == 1) {
                      return Colors.blue;
                    } else {
                      return Colors.green;
                    }
                  }())),
            ),
            verticalSpace(8),
          ],
        ),
      );

  Widget priceCalculator(int sum, String title, BuildContext context) => Row(
        children: [
          horizontalSpace(5),
          Text('Price \$$sum'),
          horizontalSpace(5),
          PressButton(
              onPressed: () {
                final sittingStatus = context.read<BuyTicketsCubit>().state;
                if (sittingStatus.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('please% select atleast one sit'
                          .capitalizeAndTrimOneWord())));
                } else {
                  context
                      .read<ActivityLogCubit>()
                      .addSingleTickets(DateTime.now(), title);
                  final singleMovie = context.read<ActivityLogCubit>().state;
                  context.read<ActivityLogListCubit>().addTickets(
                      ActivitySingle(
                          dateTime: singleMovie.dateTime,
                          addedTickets: singleMovie.addedTickets));
                  context.read<ActivityLogCubit>().resetActivity();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('added% on activity record'
                          .capitalizeAndTrimOneWord())));
                }
              },
              title: 'save^'.capitalizeAndTrim()),
        ],
      );
  Widget sitBookingDetails() => Row(
        children: [
          horizontalSpace(5),
          title('row'.capitalize(), Colors.white),
          Row(
            children: [
              titleDividerAndSquareBoxes(),
              titleDividerAndPriceUnits(),
            ],
          )
        ],
      );
  Widget titleDividerAndPriceUnits() => Row(
        children: [
          horizontalSpace(5),
          title('costs', Colors.white),
          horizontalSpace(5),
          verticalDivider(width: 2, height: 58, thickness: 0),
          horizontalDividers(),
          priceUnits(),
        ],
      );
  Widget priceUnits() => SizedBox(
        height: 70,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...[10, 20, 30].map((e) => Text('\$$e per sit')).toList(),
            ]),
      );
  Widget horizontalDividers() => SizedBox(
        height: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...[1, 1, 1]
                .map(
                  (e) => divider(width: 20, height: 2, thickness: 0),
                )
                .toList()
          ],
        ),
      );
  Widget titleDividerAndSquareBoxes() => Row(
        children: [
          horizontalSpace(5),
          divider(width: 20, height: 2, thickness: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalDivider(width: 2, height: 58, thickness: 0),
            ],
          ),
          SizedBox(
            height: 58,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [box(Colors.blue), box(Colors.red), box(Colors.green)],
            ),
          ),
          divider(width: 20, height: 2, thickness: 0)
        ],
      );

  Widget box(Color color) => Container(
        width: 10,
        height: 10,
        color: color,
      );

  Widget theatreScreen() => IntrinsicHeight(
        child: Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
                flex: 12,
                child: Center(
                  child: Column(
                    children: [
                      verticalSpace(12),
                      Container(
                        width: 140,
                        height: 40,
                        color: Colors.red,
                        alignment: Alignment.center,
                        child: Text(
                          'theatre^ screen^'.capitalizeAndTrim(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      verticalSpace(12)
                    ],
                  ),
                ))
          ],
        ),
      );

  Widget headingImageAndBooking(
          BuildContext context, List<List<int>> sittingStatus, String imgUrl) =>
      Container(
        width: getWidth(context),
        height: getHeightRatio(context, 0.25),
        color: Colors.transparent,
        child: Stack(
          children: [
            headingImage(context, imgUrl),
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 10,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      horizontalSpace(10),
                      Expanded(flex: 4, child: Container(child: bookSitting())),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: bookingRecordsCalculator(
                              20 + sittingStatus.length,
                              39 - sittingStatus.length),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        pdfButton(sittingStatus, imgUrl),
                        horizontalSpace(25)
                      ],
                    ))
              ],
            ),
          ],
        ),
      );
  Widget pdfButton(List<List<int>> sittingStatus, String imgUrl) => PressButton(
      onPressed: () => printDoc(sittingStatus, imgUrl),
      title: 'get pdf^'.capitalizeAndTrim());
  Widget bookingRecordsCalculator(int sitsBooked, int sitsOpened) =>
      defaultTextStyle(
        Colors.white,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            realTimeBookingRecords(
                'booked^'.capitalizeAndTrim(), sitsBooked, Colors.red),
            verticalSpace(5),
            realTimeBookingRecords(
                'opened^'.capitalizeAndTrim(), sitsOpened, Colors.blue)
          ],
        ),
      );
  Widget realTimeBookingRecords(
          String tag, int priceCalculation, Color color) =>
      Row(
        children: [
          Container(
            width: 20,
            height: 20,
            color: color,
          ),
          horizontalSpace(5),
          Text('$tag: $priceCalculation'),
        ],
      );
  Widget bookSitting() => Row(
        children: [title('book sitting'.capitalizeAndTrim(), Colors.white)],
      );
  Widget headingImage(BuildContext context, String imgUrl) => Image.network(
        imgUrl,
        width: getWidth(context),
        fit: BoxFit.cover,
      );
}
