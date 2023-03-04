import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Generate PDF';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const AppWidget(),
      );
}

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:youtube_app/pdf_reader.dart';
// import 'package:youtube_app/video_player.dart';
// import 'app_widget.dart';
// import 'image_picker.dart';
// import 'netflix_page.dart';
// import 'save_file_mobile_and_desktop.dart'
//     if (dart.library.html) 'save_file_web.dart';
// import 'package:file_picker/file_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   static final String title = 'Invoice';
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: AppWidget(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String text = '';
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               child: Text(
//                 'Extract Text from PDF',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith(
//                       (states) => Colors.blue)),
//               onPressed: _extractTextFromPDF,
//             ),
//             Text(
//               text,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String> _extractTextFromPDF() async {
//     FilePickerResult? filePicker = await FilePicker.platform
//         .pickFiles(allowedExtensions: ['pdf'], type: FileType.custom);
//     //Load the PDF document.
//     // final PdfDocument document =
//     //     PdfDocument(inputBytes: await _readDocumentData('sample.pdf'));

//     // //Create PDF text extractor to extract text.
//     // PdfTextExtractor extractor = PdfTextExtractor(document);

//     // //Extract text.
//     // String textnew = extractor.extractText();
//     // print(textnew.substring(0, 150));
//     // setState(() {
//     //   text = textnew;
//     // });

//     // // Dispose the document.
//     // document.dispose();

//     // //Save the file and launch/download.
//     // SaveFile.saveAndLaunchFile(text, 'output.txt');
//     return text.substring(0, 10);
//   }

//   Future<List<int>> _readDocumentData(String name) async {
//     final ByteData data = await rootBundle.load('assets/$name');
//     return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';

// // import 'app_widget.dart';

// // void main() {
// //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
// //       statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
// //   runApp(const AppWidget());
// // }
