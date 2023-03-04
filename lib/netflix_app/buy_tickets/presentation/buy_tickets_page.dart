import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:netflix_app/netflix_app/favourite_list/netflix_favorite_list.dart';
import 'package:printing/printing.dart';

import '../../home_page/components/navbar.dart';
import '../components/buy_tickets_components.dart';
import '../domain/buy_tickets_cubit.dart';
import 'buy_tickets_pdf.dart';

Widget title(String title, [Color? color]) => Text(
      title,
      style: TextStyle(color: color ?? Colors.black),
    );

const width = 42;
const height = 20;

class BuyTicketsPage extends StatefulWidget {
  final String imgUrl;
  final String title;
  const BuyTicketsPage({super.key, required this.imgUrl, required this.title});

  @override
  State<BuyTicketsPage> createState() => _BuyTicketsPageState();
}

class _BuyTicketsPageState extends State<BuyTicketsPage> {
  @override
  Widget build(BuildContext context) {
    final sittingStatus = context.watch<BuyTicketsCubit>().state;
    final sum = sittingStatus.isNotEmpty
        ? sittingStatus.fold(
            0, (previousValue, element) => previousValue + element[2])
        : 0;
    final backgroundColor = context.watch<ThemeColorCubit>().state;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: defaultTextStyle(
          Colors.white,
          Column(
            children: [
              BuyTicketsComponents().headingImageAndBooking(
                  context, sittingStatus, widget.imgUrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    BuyTicketsComponents().rowForSittingSectionAndColoredLine(
                        sittingStatus,
                        [
                          ...BuyTicketsComponents().sittingList(
                              columnLength: columnOne,
                              rowLength: rowOne,
                              sittingStatus: sittingStatus,
                              addIndex: 100),
                          ...BuyTicketsComponents().sittingList(
                              columnLength: columnTwo,
                              rowLength: rowTwo,
                              sittingStatus: sittingStatus,
                              addIndex: 200),
                        ],
                        0),
                    BuyTicketsComponents().rowForSittingSectionAndColoredLine(
                        sittingStatus,
                        [
                          ...BuyTicketsComponents().sittingList(
                              columnLength: columns,
                              rowLength: rows,
                              sittingStatus: sittingStatus,
                              addIndex: 300),
                          ...BuyTicketsComponents().bookedSitting(),
                        ],
                        1),
                    BuyTicketsComponents().rowForSittingSectionAndColoredLine(
                        sittingStatus,
                        [
                          ...BuyTicketsComponents().sittingList(
                              columnLength: columnFour,
                              rowLength: rowFour,
                              sittingStatus: sittingStatus,
                              addIndex: 400)
                        ],
                        2),
                    BuyTicketsComponents().theatreScreen(),
                  ],
                ),
              ),
              BuyTicketsComponents().sitBookingDetails(),
              BuyTicketsComponents()
                  .priceCalculator(sum, widget.title, context),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> printDoc(List<List<int>> noOfSits, movieReviewList) async {
  final netImage = await networkImage(movieReviewList);
  final pdfFile = await PdfInvoiceApi.generate(noOfSits, netImage);

  PdfApi.openFile(pdfFile);
}
