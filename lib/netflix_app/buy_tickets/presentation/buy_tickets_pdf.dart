import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class PdfInvoiceApi {
  static Future<File> generate(List<List<int>> noOfSits, imgUrl) async {
    var pathToFile = await rootBundle.load("assets/MyFlutterApp.ttf");
    final ttf = pw.Font.ttf(pathToFile);
    final pdf = Document();
    int totalTicketsOf1stRow = 0,
        totalTicketsOf2ndRow = 0,
        totalTicketsOf3rdRow = 0;
    for (var element in noOfSits) {
      if (element[0] == 100 || element[0] == 200) {
        totalTicketsOf1stRow++;
      } else if (element[0] >= 300 && element[0] < 400) {
        totalTicketsOf2ndRow++;
      } else if (element[0] >= 400) {
        totalTicketsOf3rdRow++;
      }
    }
    final totalPrice = noOfSits.fold(
        0, (previousValue, element) => previousValue + element[2]);

    pdf.addPage(Page(
      theme: ThemeData.withFont(
          base: await PdfGoogleFonts.varelaRoundRegular(),
          bold: await PdfGoogleFonts.varelaRoundRegular(),
          icons: ttf),
      build: (Context context) => Column(
        children: [
          Image(imgUrl, width: 100, height: 100),
          DefaultTextStyle(
              style: const TextStyle(fontSize: 30),
              child: Row(children: [
                Text('Total tickets bought: '),
                Text('${noOfSits.length}'),
              ])),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 30),
            child: Column(children: [
              Text('Price of 1st Row: \$10 per sit'),
              Text('Price of 2nd Row: \$20 per sit'),
              Text('Price of 3rd Row: \$30 per sit'),
            ]),
          ),
          DefaultTextStyle(
              style: const TextStyle(fontSize: 30),
              child: Row(children: [
                Text('Total tickets of 1st Row: $totalTicketsOf1stRow'),
              ])),
          DefaultTextStyle(
              style: const TextStyle(fontSize: 30),
              child: Row(children: [
                Text('Total tickets of 2nd Row: $totalTicketsOf2ndRow'),
              ])),
          DefaultTextStyle(
              style: const TextStyle(fontSize: 30),
              child: Row(children: [
                Text('Total tickets of 3rd Row: $totalTicketsOf3rdRow'),
              ])),
          DefaultTextStyle(
              style: const TextStyle(fontSize: 28),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Column(children: [
                  Text('Total price'),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      '= $totalTicketsOf1stRow x \$10 + $totalTicketsOf2ndRow x \$20 + $totalTicketsOf3rdRow x \$30'),
                  Text('= \$$totalPrice')
                ])
              ])),
        ],
      ),
    ));

    return PdfApi.saveDocument(name: 'movie_review.pdf', pdf: pdf);
  }
}

class PdfApi {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
