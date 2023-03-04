import 'dart:io';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:supercharged/supercharged.dart';

import '../../core/utils.dart';
import '../domain/netflix_data.dart';

class PdfMovieReview {
  static Future<File> generate(
      MovieDetail movieReviewList, image, bContext) async {
    var pathToFile = await rootBundle.load("assets/MyFlutterApp.ttf");
    final ttf = pw.Font.ttf(pathToFile);
    final pdf = Document();

    pdf.addPage(Page(
      theme: ThemeData.withFont(
          base: await PdfGoogleFonts.varelaRoundRegular(),
          bold: await PdfGoogleFonts.varelaRoundRegular(),
          icons: ttf),
      build: (Context context) => Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...StarCount.values
                      .map((i) => Icon(
                          movieReviewList.starCount
                                  .where((element) => element == i)
                                  .isNotEmpty
                              ? const IconData(
                                  0xe800,
                                )
                              : const IconData(0xe802),
                          size: 40))
                      .toList(),
                  Image(image, width: 100, height: 100),
                ],
              ),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 35),
                child: Container(
                  child: Row(children: [
                    Wrap(
                      children: [
                        Text('I give this movie rate of '),
                        Text(
                          '${movieReviewList.starCount.length} stars',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    )
                  ]),
                ),
              ),
              DefaultTextStyle(
                style: const TextStyle(fontSize: 25),
                child: Container(
                  width: 21 * PdfPageFormat.cm,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text('The movie completely comes under '),
                      ...List.generate(
                          movieReviewList.type.length,
                          (index) => Text(
                                movieTypeString[MovieType.values[index]]
                                    .toString()
                                    .replaceAll(
                                        "/",
                                        movieReviewList.type[index] ==
                                                movieReviewList.type[
                                                    movieReviewList
                                                        .type.lastIndex!]
                                            ? ""
                                            : "/"),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic),
                              )).toList(),
                      Text('genre and its '),
                      Text(
                        movieGenreString[movieReviewList.genreType]!
                            .toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(' rated'),
                    ],
                  ),
                ),
              ),
              DefaultTextStyle(
                  style: const TextStyle(fontSize: 25),
                  child: Container(
                    width: 21 * PdfPageFormat.cm,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        Text('description ${movieReviewList.description}')
                      ],
                    ),
                  )),
              if (movieReviewList.message != '')
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 25),
                  child: Container(
                    width: getWidth(bContext),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [Text('message ${movieReviewList.message}')],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    ));

    return PdfApiReview.saveDocument(name: 'movie_review.pdf', pdf: pdf);
  }
}

class PdfApiReview {
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
